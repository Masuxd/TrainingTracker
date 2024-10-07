const mongoose = require('mongoose');

const trainingSessionSchema = new mongoose.Schema({
  user_id: mongoose.Schema.Types.ObjectId,
  start_time: Date,
  end_time: Date,
  set: [{
    exercise: mongoose.Schema.Types.ObjectId,
    recovery_time: Date,
    rep: {
        repetitions: Number,
        weight: Number,
        duration: Date,
        distance: Number,
        speed: Number,
    }
    }],
}, { collection: 'training_session' });

const TrainingSession = mongoose.model('Training_session', trainingSessionSchema);

module.exports = TrainingSession;