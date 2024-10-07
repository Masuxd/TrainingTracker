const TrainingSession = require('../models/trainingSessionModel');

exports.getAllTrainingSessions = async (req, res) => {
  try {
    const TrainingSessions = await TrainingSession.find();
    res.json(TrainingSessions);
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error' });
  }
};
