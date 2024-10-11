const User = require('../models/userModel');

async function authenticateSession(req, res, next) {
  if (!req.session.userId) {
    return res.sendStatus(401);
  }

  const user = await User.findById(req.session.userId);
  if (!user) {
    return res.sendStatus(403);
  }

  req.user = user;
  next();
}

module.exports = { authenticateSession };