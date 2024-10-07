const TrainingPlan = require('../models/trainingPlanModel');

exports.getAllTrainingPlans = async (req, res) => {
  try {
    const TrainingPlans = await TrainingPlan.find();
    res.json(TrainingPlans);
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error' });
  }
};
