const express = require('express');
const Verification = require('../../models/verificationModel');
const User = require('../../models/userModel');

const router = express.Router();

const verifyEmail = async (req, res) => {

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
};

module.exports = {
    verifyEmail,
};