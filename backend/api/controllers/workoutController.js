const workout = require('../models/workoutModel');

async function getWorkoutById(req, res) {
  try {
    const { id } = req.params;
    const userId = req.session.userId; // Get user ID from workout

    if (!userId) {
      return res.status(401).json({ error: 'Unauthorized: No workout found' });
    }

    const workout = await workout.findOne({ _id: id, user_id: userId });
    if (!workout) {
      return res.status(404).json({ error: 'Training workout not found or you do not have access to it' });
    }
    res.json(workout);
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error: get workout' });
  }
}

async function getWorkoutListByUserId(req, res) {
  try {
    const userId = req.session.userId; // Get user ID from workout
    if (!userId) {
      return res.status(401).json({ error: 'Unauthorized: No workout found' });
    }
    const workoutList = await workout.find({ user_id: userId });
    if (workoutList.length === 0) {
      return res.status(404).json({ error: 'Training workouts not found' });
    }
    res.json(workoutList);
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error: workout list' });
  }
}

async function saveWorkout(req, res) {
  try {
    const userId = req.session.userId; // Get user ID from workout
    if (!userId) {
      return res.status(401).json({ error: 'Unauthorized: No workout found' });
    }

    const { is_plan, name, end_time, start_time, finished, set } = req.body;

    const newWorkout = new workout({
      user_id: userId,
      is_plan: is_plan,
      name: name,
      start_time: start_time,
      end_time: end_time,
      finished: finished,
      set: set
    });

    await newWorkout.save();
    res.status(201).json(newWorkout);
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: 'Internal Server Error: post workout' });
  }
}


module.exports = {
  getWorkoutById,
  getWorkoutListByUserId,
  saveWorkout
};