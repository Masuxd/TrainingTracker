const express = require('express');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const User = require('../models/User');

const router = express.Router();

router.post('/register', async (req, res) => {
  const hashedPassword = await bcrypt.hash(req.body.password, 10);
  const user = new User({ username: req.body.username, password: hashedPassword });
  await user.save();
  res.sendStatus(201);
});

//finds user, compares password hashes, gives access token and refresh token if valid credentials
router.post('/login', async (req, res) => {
  const user = await User.findOne({ username: req.body.username });
  if (user && await bcrypt.compare(req.body.password, user.password)) {
    const accessToken = jwt.sign({ id: user.id }, process.env.ACCESS_TOKEN_SECRET, { expiresIn: '15m' });
    const refreshToken = jwt.sign({ id: user.id }, process.env.REFRESH_TOKEN_SECRET, { expiresIn: '7d' });
    user.refreshToken = await bcrypt.hash(refreshToken, 10);
    await user.save();
    res.json({ accessToken, refreshToken });
  } else {
    res.sendStatus(403);
  }
});

module.exports = router;