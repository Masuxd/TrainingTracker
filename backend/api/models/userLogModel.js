const mongoose = require('mongoose');

const userLogSchema = new mongoose.Schema({
  userId: { type: String, required: true },
  timestamp: { type: Date, default: Date.now, expires: '30d' },
  action: { type: String, required: true },
  ip: { type: String },
  userAgent: { type: String },
  details: { type: mongoose.Schema.Types.Mixed }, // Flexible field for additional data
});

const UserLog = mongoose.model('UserLog', userLogSchema);

module.exports = UserLog;
