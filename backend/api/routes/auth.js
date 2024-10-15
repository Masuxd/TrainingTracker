const express = require('express');
const bcrypt = require('bcrypt');
const User = require('../models/userModel');
const Verification = require('../models/verificationModel');
const PasswordReset = require('../models/passwordResetModel');
const router = express.Router();
const sendEmail = require('../services/mailService');

// Login route
router.post('/login', async (req, res) => {
  const { username, password } = req.body;
  const user = await User.findOne({ username });

  if (!user || !await bcrypt.compare(password, user.password)) {
    return res.status(403).send('Invalid username or password');
  }

  req.session.userId = user._id;
  res.sendStatus(200);
});


// Logout route
router.post('/logout', (req, res) => {
  req.session.destroy(err => {
    if (err) {
      return res.sendStatus(500);
    }
    res.clearCookie('connect.sid');
    res.sendStatus(200);
  });
});

// Registration route
router.post('/register', async (req, res) => {

    try {
        console.log('Request body:', req.body);
    
        if (!req.body) {
          console.error('Request body is undefined');
          return res.status(400).send('Bad Request: Request body is undefined');
        }
    
    const { username, password } = req.body;
    const email = req.body.email;

    // Check that email has @ and .
    const emailRegex = /^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$/;

    if (!emailRegex.test(email)) {
      return res.status(400).send('Invalid email format');
    }

    // Check that username is 3-30 characters and not anything weird characters
    const usernameRegex = /^[a-zA-Z0-9_-]{3,30}$/; 
    
    if (!usernameRegex.test(username)) {
      return res.status(400).send('Invalid username format');
    }
    
    // Check that password is 12-30 characters and not anything weird characters
    const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{12,128}$/;

    if (!passwordRegex.test(password)) {
      return res.status(400).send('Invalid password format');
    }

    // Check if the user already exists
    const existingUser = await User.findOne({ username });
    const existingEmail = await User.findOne({ email });

    if (existingUser) {
      return res.status(409).send('Username already in use');
    }
    
    if (existingEmail) {
      return res.status(409).send('Email already in use');
    }
  
    // Hash the password
    const hashedPassword = await bcrypt.hash(password, 10);
  
    // Create a new user
    const newUser = new User({
      username,
      password: hashedPassword,
      email,
      deleteAt: Date.now()
    });
  
    
    // Save the user to the database
    await newUser.save();
    
    const verificationID = Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
    const newVerification = new Verification({
      email: req.body.email,
      verificationID: verificationID
    });
    await newVerification.save();

    const link = 'http://localhost:3000/auth/verify/' + verificationID;
    const htmlMessage = `Hello! thanks for signing up! Please click <a href="${link}">here</a> to verify your email.<br>If the link is broken, please copy and paste the following URL into your browser: <br>${link}`;
    sendEmail(email, 'Please verify your email', htmlMessage);

    // Create a session for the new user
    req.session.userId = newUser._id;
    res.sendStatus(201);
    
    } catch (error) {
        console.error('Error during registration:', error);
        res.status(500).send('Internal Server Error');
    }
});

// Verify email
router.get('/verify/:verificationID', async (req, res) => {
  const { verificationID } = req.params;
  const verification = await Verification.findOneAndDelete({ verificationID });

  if (!verification) {
    return res.status(403).send('Invalid verification code');
  }

  const user = await User.findOne({ email: verification.email });
  if (!user) {
    return res.status(404).send('User not found');
  }
  User.updateOne({ email: user.email }, { $unset: { deleteAt: 1 } });
  user.verified = true;
  await user.save();

  res.send('User successfully verified');
});

// Send password reset request
router.post('/password-reset-request', async (req, res) => {
  const { email } = req.body;
  const user = await User.findOne({ email });

  if (!user) {
    return res.status(404).send('User not found');
  }

  const resetCode = Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
  const passwordReset = new PasswordReset({ email, resetCode });
  await passwordReset.save();

  sendEmail(email, 'Password Reset Code', `Your password reset code is: ${resetCode} (valid for 15 minutes)`);

  res.sendStatus(200);
});

// Verify password reset code
router.post('/verify-reset-code', async (req, res) => {
  const { resetCode } = req.body;
  const passwordReset = await PasswordReset.findOne({ resetCode });

  if (!passwordReset) {
    return res.status(403).send('Invalid reset code');
  }

  res.sendStatus(200);
});

// Reset password
router.post('/password-reset', async (req, res) => {
  const { resetCode, newPassword } = req.body;
  const passwordReset = await PasswordReset.findOneAndDelete({ resetCode });

  if (!passwordReset) {
    return res.status(403).send('Invalid reset code');
  }

  const user = await User.findOne({ email: passwordReset.email });
  if (!user) {
    return res.status(404).send('User not found');
  }

  // Check that password is 12-30 characters and not anything weird characters
  const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{12,128}$/;

  if (!passwordRegex.test(password)) {
    return res.status(400).send('Invalid password format');
  }

  user.password = await bcrypt.hash(newPassword, 10);
  await user.save();

  res.sendStatus(200);
});

module.exports = router;