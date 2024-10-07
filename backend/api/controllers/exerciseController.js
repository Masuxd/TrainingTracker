const exercise = require('../models/exerciseModel');

exports.getAllExercises = async (req, res) => {
  try {
    const exercises = await exercise.find();
    res.json(exercises);
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error' });
  }
};
