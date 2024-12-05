const mongoose = require('mongoose');

const workoutSchema = new mongoose.Schema({
  user_id: mongoose.Schema.Types.ObjectId,
  is_plan: Boolean,
  name: String,
  start_time: Date,
  end_time: Date,
  finished: Boolean,
  set: [{
    exercise: mongoose.Schema.Types.ObjectId,
    set_id: String,
    widget_id: String,
    recovery_time: Number,
    finished: Boolean,
    rep: [{
        repetitions: Number,
        weight: Number,
        duration: Number,
        distance: Number,
        speed: Number,
        finished: Boolean,
    }]
    }],
}, { collection: 'workout' });

const workout = mongoose.model('Workout', workoutSchema);

module.exports = workout;