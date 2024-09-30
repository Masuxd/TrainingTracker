const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  username: String,
  password: String,
  fname: String,
  lname: String,
  birthdate: Date,
  email: String,
  phone: String,
  role: String,
  friends: [mongoose.Schema.Types.ObjectId],
  trainee_info: {
    height: Number,
    weight: Number,
    coach: [mongoose.Schema.Types.ObjectId],
    club: mongoose.Schema.Types.ObjectId,
    team: mongoose.Schema.Types.ObjectId,
    team_number: Number,
    training_sessions: [mongoose.Schema.Types.ObjectId],
    training_plans: [mongoose.Schema.Types.ObjectId]
    },
    coach_info: {
        club: mongoose.Schema.Types.ObjectId,
        coaching_teams: [mongoose.Schema.Types.ObjectId],
        trainees: [mongoose.Schema.Types.ObjectId],
        coaching_sessions: [mongoose.Schema.Types.ObjectId]
    }
}, { collection: 'users' });

const User = mongoose.model('User', userSchema);

module.exports = User;