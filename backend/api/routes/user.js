const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');
const { authenticateSession } = require('../middleware/sessionMiddleware');

// Apply sessionMiddleware to routes that require authentication
router.get('/', authenticateSession, userController.getAllUsers);
// Add more routes as needed

module.exports = router;