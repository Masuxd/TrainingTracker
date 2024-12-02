const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');
const { authenticateSession } = require('../middleware/sessionMiddleware');

// Apply sessionMiddleware to routes that require authentication
router.use(authenticateSession);
//router.get('/:username', userController.getUserByUsername);
router.get('/bio', userController.getOwnProfile);
//router.get('/friends', userController.getFriends);
router.get('/search', userController.searchUsers);


// Add more routes as needed

module.exports = router;