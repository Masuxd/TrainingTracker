const mongoose = require('mongoose');

const exerciseSchema = new mongoose.Schema({
  name: String,
  weight: Boolean,
  distance: Boolean,
  duration: Boolean,
  speed: Boolean,
}, { collection: 'exercise' });

const Exercise = mongoose.model('Exercise', exerciseSchema);

module.exports = Exercise;