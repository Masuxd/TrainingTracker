const express = require('express');
const router = express.Router();
const trainingSessionController = require('../controllers/trainingSessionController');
const { authenticateSession } = require('../middleware/sessionMiddleware');

// Apply sessionMiddleware to routes that require authentication
router.use(authenticateSession);

router.get('/list', (req, res, next) => {
    console.log('Route /trainingSession/list hit');
    next();
  }, trainingSessionController.getTrainingSessionsByUserId);

router.get('/:id', (req, res, next) => {
  console.log('Route /trainingSession/:id hit');
  next();
}, trainingSessionController.getTrainingSessionById);

//router.get('/:id', trainingSessionController.getTrainingSessionById);
//router.get('/list', trainingSessionController.getTrainingSessionsByUserId);
router.post('/save', trainingSessionController.saveTrainingSession);

module.exports = router;