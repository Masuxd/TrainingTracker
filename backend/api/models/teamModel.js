const mongoose = require('mongoose');

const teamSchema = new mongoose.Schema({
    name: String,
    division: mongoose.Schema.Types.ObjectId,
    coaches: [mongoose.Schema.Types.ObjectId],
    athletes: [{
        athlete_id: mongoose.Schema.Types.ObjectId,
        team_number: Number,
        role: String,
        training_sessions: [mongoose.Schema.Types.ObjectId],
        training_plans: [mongoose.Schema.Types.ObjectId],
    }],
}, { collection: 'team' });

const Team = mongoose.model('Team', teamSchema);

module.exports = Team;