const User = require('../../models/userModel');
const PasswordReset = require('../../models/passwordResetModel');
const bcrypt = require('bcrypt');
const sendEmail = require('../../services/mailService');



const passwordResetReq = async (req, res) => {
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
};
  
const verifyResetCode = async (req, res) => {
    const { resetCode } = req.body;
    const passwordReset = await PasswordReset.findOne({ resetCode });
  
    if (!passwordReset) {
      return res.status(403).send('Invalid reset code');
    }
  
    res.sendStatus(200);
  };
  
const passwordReset = async (req, res) => {
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
  };

module.exports = {
    passwordResetReq,
    verifyResetCode,
    passwordReset,
};