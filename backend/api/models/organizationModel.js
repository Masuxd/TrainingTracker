const mongoose = require('mongoose');

const organizationSchema = new mongoose.Schema({
    name: String,
    admins: [mongoose.Schema.Types.ObjectId],
    divisions: [mongoose.Schema.Types.ObjectId],
}, { collection: 'organization' });

const Organization = mongoose.model('Organization', organizationSchema);

module.exports = Organization;