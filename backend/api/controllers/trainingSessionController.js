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
  console.log('Received request to get training sessions');
  try {
    const userId = req.session.userId; // Get user ID from session
    if (!userId) {
      return res.status(401).json({ error: 'Unauthorized: No session found' });
    }
    console.log('Received request to get training sessions for user ID:', userId);
    const trainingSessions = await TrainingSession.find({ user_id: userId });
    if (trainingSessions.length === 0) {
      return res.status(404).json({ error: 'Training sessions not found' });
    }
    res.json(trainingSessions);
  } catch (error) {
    console.error('Error fetching training sessions:', error); // Add detailed logging
    res.status(500).json({ error: 'Internal Server Error: session list' });
  }
}

async function saveTrainingSession(req, res) {
  try {
    console.log('Received request to save training session');
    const userId = req.session.userId; // Get user ID from session
    if (!userId) {
      console.error('Unauthorized: No session found');
      return res.status(401).json({ error: 'Unauthorized: No session found' });
    }

    const { start_time, end_time, finished, set } = req.body;
    console.log('Request body:', req.body);

    const newTrainingSession = new TrainingSession({
      user_id: userId,
      start_time: start_time,
      end_time: end_time,
      finished: finished,
      set: set
    });

    console.log('New training session object:', newTrainingSession);

    await newTrainingSession.save();
    console.log('Training session saved successfully');
    res.status(201).json(newTrainingSession);
  } catch (error) {
    console.error('Error saving training session:', error);
    res.status(500).json({ error: 'Internal Server Error: post session' });
  }
}


module.exports = {
  getTrainingSessionById,
  getTrainingSessionsByUserId,
  saveTrainingSession
};