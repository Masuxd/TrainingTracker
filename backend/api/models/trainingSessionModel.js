const mongoose = require('mongoose');

const trainingSessionSchema = new mongoose.Schema({
  user_id: mongoose.Schema.Types.ObjectId,
  name: String,
  start_time: Date,
  end_time: Date,
  finished: Boolean,
  set: [{
    exercise: mongoose.Schema.Types.ObjectId,
    recovery_time: Date,
    finished: Boolean,
    rep: [{
        repetitions: Number,
        weight: Number,
        duration: Date,
        distance: Number,
        speed: Number,
        finished: Boolean,
    }]
    }],
}, { collection: 'training_session' });

const TrainingSession = mongoose.model('Training_session', trainingSessionSchema);

module.exports = TrainingSession;