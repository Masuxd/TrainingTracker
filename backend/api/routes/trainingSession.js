const express = require('express');
const router = express.Router();
const trainingSessionController = require('../controllers/trainingSessionController');

router.get('/', trainingSessionController.getAllTrainingSessions);

// Add more routes as needed

module.exports = router;