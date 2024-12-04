const express = require('express');
const router = express.Router();
const exerciseController = require('../controllers/exerciseController');
const { authenticateSession } = require('../middleware/sessionMiddleware');
const logUserAction = require('../middleware/userLogMiddleware');

// Middleware to log user actions
router.use(logUserAction);

// Apply sessionMiddleware to routes that require authentication
router.use(authenticateSession);

router.get('/', exerciseController.getAllExercises);
router.get('/:id', exerciseController.getExerciseById);
router.get('/search/:query', exerciseController.searchExercises);

module.exports = router;