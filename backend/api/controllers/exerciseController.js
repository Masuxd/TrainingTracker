const Exercise = require('../models/exerciseModel');

async function getAllExercises(req, res) {
  try {
    const exercises = await Exercise.find();
    res.json(exercises);
  } catch (error) {
    return res.status(500).json({ error: 'Internal Server Error: get exercise-list' });
  }
}

async function getExerciseById(req, res) {
  try {
    const { id } = req.params;
    const exercise = await Exercise.findById(id);
    if (!exercise) {
      return res.status(404).json({ error: 'Exercise not found' });
    }
    res.json(exercise);
  } catch (error) {
    return res.status(500).json({ error: 'Internal Server Error: get exercise by ID' });
  }
}

async function searchExercises(req, res) {
  try {
    const { query } = req.params;
    if (!query) {
      return res.status(400).json({ error: 'Query parameter is required' });
    }

    const regex = new RegExp(query, 'i');
    const exercises = await Exercise.find({
      $or: [
        { name: regex },
        { type: regex }
      ]
    });
    res.json(exercises);
  } catch (error) {
    return res.status(500).json({ error: 'Internal Server Error: search exercise' });
  }
}

module.exports = {
  getAllExercises,
  getExerciseById,
  searchExercises
};