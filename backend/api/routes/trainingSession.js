const express = require('express');
const router = express.Router();
const trainingSessionController = require('../controllers/trainingSessionController');
const { authenticateSession } = require('../middleware/sessionMiddleware');
const logUserAction = require('../middleware/userLogMiddleware');

// Middleware to log user actions
router.use(logUserAction);


// Apply sessionMiddleware to routes that require authentication
router.use(authenticateSession);

router.get('/list', (req, res, next) => {
    next();
  }, trainingSessionController.getTrainingSessionsByUserId);

router.get('/:id', (req, res, next) => {
  next();
}, trainingSessionController.getTrainingSessionById);

//router.get('/:id', trainingSessionController.getTrainingSessionById);
//router.get('/list', trainingSessionController.getTrainingSessionsByUserId);
router.post('/save', trainingSessionController.saveTrainingSession);

module.exports = router;