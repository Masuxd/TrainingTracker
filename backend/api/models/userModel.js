const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  verified: { type: Boolean, default: false },
  deleteAt: { type: Date, expires: '7d', default: undefined },
  username: String,
  password: String,
  fname: String,
  lname: String,
  birthdate: Date,
  height: Number,
  weight: Number,
  email: String,
  phone: String,
  role: String,
  friends: [mongoose.Schema.Types.ObjectId],
  training_sessions: [mongoose.Schema.Types.ObjectId],
  training_plans: [mongoose.Schema.Types.ObjectId],
  athlete_info: {
    divisions: [mongoose.Schema.Types.ObjectId],
    teams: [mongoose.Schema.Types.ObjectId],
    },
    coach_info: {
        divisions: [mongoose.Schema.Types.ObjectId],
        coaching_teams: [mongoose.Schema.Types.ObjectId],
    }
}, { collection: 'user' });

const User = mongoose.model('User', userSchema);

module.exports = User;