const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const { User } = require('../models');

async function authenticateToken(req, res, next) {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];
  if (token == null) return res.sendStatus(401);

  jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, async (err, userPayload) => {
    if (err) return res.sendStatus(403);
    const user = await User.findById(userPayload.id);
    if (!user) return res.sendStatus(403);
    req.user = user;
    next();
  });
}

async function refreshToken(req, res) {
  const refreshToken = req.body.token;
  if (refreshToken == null) return res.sendStatus(401);

  const user = await User.findById(req.body.userId);
  if (!user) return res.sendStatus(403);

  const validToken = await bcrypt.compare(refreshToken, user.refreshToken);
  if (!validToken) return res.sendStatus(403);

  const accessToken = jwt.sign({ id: user.id }, process.env.ACCESS_TOKEN_SECRET, { expiresIn: '15m' });
  const newRefreshToken = jwt.sign({ id: user.id }, process.env.REFRESH_TOKEN_SECRET, { expiresIn: '7d' });
  user.refreshToken = await bcrypt.hash(newRefreshToken, 10);
  await user.save();

  res.json({ accessToken, refreshToken: newRefreshToken });
}

module.exports = { authenticateToken, refreshToken };