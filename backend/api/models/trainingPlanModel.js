const mongoose = require('mongoose');

const trainingPlanSchema = new mongoose.Schema({
  user_id: mongoose.Schema.Types.ObjectId,
  start_time: Date,
  end_time: Date,
  set: [{
    exercise: mongoose.Schema.Types.ObjectId,
    recovery_time: Date,
    rep: {
        repetitions: Number,
        duration: Date,
        weight: Number,
        distance: Number,
    }
    }],
}, { collection: 'training_plan' });

const TrainingPlan = mongoose.model('Training_plan', trainingPlanSchema);

module.exports = TrainingPlan;