const express = require('express');
const router = express.Router();
const { getUserLogs } = require('../controllers/userLogController');
const { authenticateSession } = require('../middleware/sessionMiddleware');
const logUserAction = require('../middleware/userLogMiddleware');

// Middleware to log user actions
router.use(logUserAction);




// Middleware to check if user has admin role
const checkAdminRole = (req, res, next) => {
    if (req.user && req.user.role === 'admin') {
        next();
    } else {
        res.status(403).json({ message: 'Forbidden: Admins only' });
    }
};

// Apply authentication middleware to all routes
router.use(authenticateSession);

// Route to get user logs
router.get('/:userId', checkAdminRole, getUserLogs);

module.exports = router;