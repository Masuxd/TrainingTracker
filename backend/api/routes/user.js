const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');
const authenticateToken = require('../middleware/auth');

router.use(authenticateToken); //verify token before proceeding

router.get('/', userController.getAllUsers);

// Add more routes as needed

module.exports = router;