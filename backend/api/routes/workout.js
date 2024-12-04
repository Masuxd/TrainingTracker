const express = require('express');
const router = express.Router();
const workoutController = require('../controllers/workoutController');
const { authenticateSession } = require('../middleware/sessionMiddleware');
const logUserAction = require('../middleware/userLogMiddleware');

// Middleware to log user actions
router.use(logUserAction);


// Apply sessionMiddleware to routes that require authentication
router.use(authenticateSession);

router.get('/list', (req, res, next) => {
    next();
  }, workoutController.getWorkoutListByUserId);

router.get('/:id', (req, res, next) => {
  next();
}, workoutController.getWorkoutById);

//router.get('/:id', workoutController.getworkoutById);
//router.get('/list', workoutController.getworkoutsByUserId);
router.post('/save', workoutController.saveWorkout);

module.exports = router;