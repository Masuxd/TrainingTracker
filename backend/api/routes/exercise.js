const express = require('express');
const router = express.Router();
const exerciseController = require('../controllers/exerciseController');
const { authenticateSession } = require('../middleware/sessionMiddleware');

// Apply sessionMiddleware to routes that require authentication
router.use(authenticateSession);

router.get('/', exerciseController.getAllExercises);
router.get('/:id', exerciseController.getExerciseById);
router.get('/search', exerciseController.searchExercises);

module.exports = router;