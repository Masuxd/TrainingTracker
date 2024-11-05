const User = require('../../models/userModel'); // Adjust the path as necessary
const bcrypt = require('bcrypt');

const login = async (req, res) => {
  const { username, password } = req.body;
  const user = await User.findOne({ username });

  if (!user || !await bcrypt.compare(password, user.password)) {
    return res.status(403).send('Invalid username or password');
  }

  req.session.userId = user._id;
  res.sendStatus(200);
};

module.exports = {
  login,
};