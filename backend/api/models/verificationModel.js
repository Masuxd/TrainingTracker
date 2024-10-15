const mongoose = require('mongoose');

const verificationSchema = new mongoose.Schema({
    email: String,
    verificationID: String ,
}, { collection: 'verification' });

const Verification = mongoose.model('Verification', verificationSchema);

module.exports = Verification;