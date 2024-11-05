const express = require('express');
const router = express.Router();
const trainingSessionController = require('../controllers/trainingSessionController');
const { authenticateSession } = require('../middleware/sessionMiddleware');

// Apply sessionMiddleware to routes that require authentication
router.use(authenticateSession);

router.get('/:id', trainingSessionController.getTrainingSessionById);
router.get('/user/sessions', trainingSessionController.getTrainingSessionsByUserId);
router.post('/save', trainingSessionController.saveTrainingSession);

module.exports = router;