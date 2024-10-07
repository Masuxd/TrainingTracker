const express = require('express');
const router = express.Router();
const trainingPlanController = require('../controllers/trainingPlanController');

router.get('/', trainingPlanController.getAllTrainingPlans);

// Add more routes as needed

module.exports = router;