const mongoose = require('mongoose');

const passwordResetSchema = new mongoose.Schema({
    email: String,
    resetCode: String ,
    createdAt: { type: Date, expires: 900, default: Date.now } // 900 seconds = 15 minutes
}, { collection: 'passwordReset' });

const PasswordReset = mongoose.model('PasswordReset', passwordResetSchema);

module.exports = PasswordReset;