const express = require('express');
const router = express.Router();
const trainingPlanController = require('../controllers/trainingPlanController');
const { authenticateSession } = require('../middleware/sessionMiddleware');

// Apply sessionMiddleware to routes that require authentication
router.use(authenticateSession);

router.get('/:id', trainingPlanController.getTrainingPlanById);
router.get('/user/plans', trainingPlanController.getTrainingPlansByUserId);
router.post('/save', trainingPlanController.saveTrainingPlan);

module.exports = router;