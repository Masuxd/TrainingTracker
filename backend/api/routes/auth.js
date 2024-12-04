const express = require('express');
const router = express.Router();

const accVerifyController = require('../controllers/auth/accVerifyController');
const logoutController = require('../controllers/auth/logoutController');
const registerController = require('../controllers/auth/registerController');
const loginController = require('../controllers/auth/loginController');
const resetPasswordController = require('../controllers/auth/passwordResetController');
const logUserAction = require('../middleware/userLogMiddleware');

// Middleware to log user actions
router.use(logUserAction);

router.post('/register', registerController.register);
router.post('/login', loginController.login);
router.post('/verify-email', accVerifyController.verifyEmail);
//router.post('/resend-verification', authController.resendVerification);
router.post('/reset-password', resetPasswordController.passwordReset);
router.post('request-password-reset', resetPasswordController.passwordResetReq);
router.post('verify-reset-code', resetPasswordController.verifyResetCode);
router.post('/logout', logoutController.logout);
//router.post('/update-password', authController.updatePassword);

module.exports = router;