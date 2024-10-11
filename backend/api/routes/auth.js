const express = require('express');
const bcrypt = require('bcrypt');
const User = require('../models/userModel');
const router = express.Router();

router.post('/login', async (req, res) => {
  const { username, password } = req.body;
  const user = await User.findOne({ username });

  if (!user || !await bcrypt.compare(password, user.password)) {
    return res.sendStatus(403);
  }

  req.session.userId = user._id;
  res.sendStatus(200);
});

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
  
    // Check if the user already exists
    const existingUser = await User.findOne({ username });
    if (existingUser) {
      return res.status(409).send('User already exists');
    }
  
    // Hash the password
    const hashedPassword = await bcrypt.hash(password, 10);
  
    // Create a new user
    const newUser = new User({
      username,
      password: hashedPassword,
    });
  
    // Save the user to the database
    await newUser.save();
  
    // Create a session for the new user
    req.session.userId = newUser._id;
    res.sendStatus(201);
    
    } catch (error) {
        console.error('Error during registration:', error);
        res.status(500).send('Internal Server Error');
    }
  });

module.exports = router;