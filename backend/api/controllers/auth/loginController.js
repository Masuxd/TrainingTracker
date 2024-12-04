const User = require('../../models/userModel'); // Adjust the path as necessary
const bcrypt = require('bcrypt');

const login = async (req, res) => {
  const { email, password } = req.body;
  const user = await User.findOne({ email });
  const hashedPassword = await bcrypt.hash(password, 10);

  /*if (!user || !await bcrypt.compare(password, user.password)) {
    return res.status(403).send('Invalid email or password');
  }*/

  if (!user) {
    return res.status(403).send('Invalid email' + email);
  }
  if (!await bcrypt.compare(password, user.password)) {
    return res.status(403).json({
      message: 'Invalid password',
      password: password,
      hashedPassword: hashedPassword,
      userPassword: user.password
    });
  }

  req.session.userId = user._id;
  req.session.save((err) => {
    if (err) {
      return res.sendStatus(500);
    }
  res.sendStatus(200);
  });
};

module.exports = {
  login,
};