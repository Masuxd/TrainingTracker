const TrainingSession = require('../models/trainingSessionModel');

async function getTrainingSessionById(req, res) {
  try {
    const { id } = req.params;
    const userId = req.session.userId; // Get user ID from session

    if (!userId) {
      return res.status(401).json({ error: 'Unauthorized: No session found' });
    }

    const trainingSession = await TrainingSession.findOne({ _id: id, user_id: userId });
    if (!trainingSession) {
      return res.status(404).json({ error: 'Training session not found or you do not have access to it' });
    }
    res.json(trainingSession);
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error: get session' });
  }
}

async function getTrainingSessionsByUserId(req, res) {
  try {
    const userId = req.session.userId; // Get user ID from session
    if (!userId) {
      return res.status(401).json({ error: 'Unauthorized: No session found' });
    }
    const trainingSessions = await TrainingSession.find({ user_id: userId });
    if (trainingSessions.length === 0) {
      return res.status(404).json({ error: 'Training sessions not found' });
    }
    res.json(trainingSessions);
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error: session list' });
  }
}

async function saveTrainingSession(req, res) {
  try {
    const userId = req.session.userId; // Get user ID from session
    if (!userId) {
      return res.status(401).json({ error: 'Unauthorized: No session found' });
    }

    const { start_time, name, end_time, finished, set } = req.body;

    const newTrainingSession = new TrainingSession({
      user_id: userId,
      name: name,
      start_time: start_time,
      end_time: end_time,
      finished: finished,
      set: set
    });

    await newTrainingSession.save();
    res.status(201).json(newTrainingSession);
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error: post session' });
  }
}


module.exports = {
  getTrainingSessionById,
  getTrainingSessionsByUserId,
  saveTrainingSession
};