const mongoose = require('mongoose');

const exerciseSchema = new mongoose.Schema({
  name: String,
  type: String,
}, { collection: 'exercise' });

const Exercise = mongoose.model('Exercise', exerciseSchema);

module.exports = Exercise;