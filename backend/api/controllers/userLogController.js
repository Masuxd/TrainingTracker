const UserLog = require('../models/userLogModel');

const getUserLogs = async (req, res) => {
    const userId = req.params.userId;
    try {
        const logs = await UserLog.find({ userId }).sort({ timestamp: -1 });
        res.json(logs);
    } catch (error) {
        res.status(500).send('Error retrieving logs');
    }
};

module.exports = {
    getUserLogs,
};