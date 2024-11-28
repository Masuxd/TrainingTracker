const sendEmail = require('../../services/mailService');
const Verification = require('../../models/verificationModel');

const User = require('../../models/userModel');
const bcrypt = require('bcrypt');


const register = async (req, res) => {
try {
    console.log('Request body:', req.body);

    if (!req.body) {
      console.error('Request body is undefined');
      return res.status(400).send('Bad Request: Request body is undefined');
    }

const { email, username, password } = req.body;

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
//sendEmail(email, 'Please verify your email', htmlMessage);

// Create a session for the new user
req.session.userId = newUser._id;
res.sendStatus(201);

} catch (error) {
    console.error('Error during registration:', error);
    res.status(500).send('Internal Server Error: register');
}

};

module.exports = {
    register,
};