const TrainingPlan = require('../models/trainingPlanModel');

async function getTrainingPlanById(req, res) {
  try {
    const { id } = req.params;
    const userId = req.session.userId; // Get user ID from session

    if (!userId) {
      return res.status(401).json({ error: 'Unauthorized: No session found' });
    }

    const trainingPlan = await TrainingPlan.findOne({ _id: id, user_id: userId }).populate('sessions');
    if (!trainingPlan) {
      return res.status(404).json({ error: 'Training plan not found or you do not have access to it' });
    }
    res.json(trainingPlan);
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error: get plan' });
  }
}

async function getTrainingPlansByUserId(req, res) {
  try {
    const userId = req.session.userId; // Get user ID from session
    if (!userId) {
      return res.status(401).json({ error: 'Unauthorized: No session found' });
    }

    const trainingPlans = await TrainingPlan.find({ user_id: userId });
    res.json(trainingPlans);
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error: get plan list' });
  }
}

async function saveTrainingPlan(req, res) {
  try {
    const userId = req.session.userId; // Get user ID from session
    if (!userId) {
      return res.status(401).json({ error: 'Unauthorized: No session found' });
    }

    const { name, description, start_date, end_date, set } = req.body;

    const newTrainingPlan = new TrainingPlan({
      user_id: userId,
      name: name,
      description: description,
      start_time: start_date,
      end_time: end_date,
      set: set
    });

    await newTrainingPlan.save();
    res.status(201).json(newTrainingPlan);
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error: save plan' });
  }
}

module.exports = {
  getTrainingPlanById,
  getTrainingPlansByUserId,
  saveTrainingPlan
};