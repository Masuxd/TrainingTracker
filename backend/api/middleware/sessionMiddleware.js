const User = require('../models/userModel');
//authorize user
async function authenticateSession(req, res, next) {
  console.log('Authenticating session');
  if (!req.session.userId) {
    console.log('Session not authenticated');
    return res.sendStatus(401);
  }

  const user = await User.findById(req.session.userId);
  if (!user) {
    console.log('User not found');
    return res.sendStatus(403);
  }

  req.user = user;
  console.log('Session authenticated: ${user}  ${req.session}');
  next();
}

module.exports = { authenticateSession };