const mongoose = require('mongoose');

const divisionSchema = new mongoose.Schema({
    name: String,
    sport: String,
    admins: [mongoose.Schema.Types.ObjectId],
    teams: [mongoose.Schema.Types.ObjectId],
}, { collection: 'division' });

const Division = mongoose.model('Division', divisionSchema);

module.exports = Division;