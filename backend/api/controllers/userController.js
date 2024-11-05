const User = require('../models/userModel');


async function getOwnProfile(req, res) {
  try {
    const userId = req.session.userId; // Get user ID from session
    if (!userId) {
      return res.status(401).json({ error: 'Unauthorized: No session found' });
    }

    const user = await User.findById(userId).select('-password'); // Exclude sensitive fields
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

    res.json(user);
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error: get profile' });
  }
};

async function searchUsers(req, res) {
  try {
    const { query } = req.query;
    if (!query) {
      return res.status(400).json({ error: 'Query parameter is required' });
    }

    // Use a regular expression to perform a case-insensitive search
    const regex = new RegExp(query, 'i');
    const users = await User.find({
      $or: [
        { username: regex },
        { firstName: regex },
        { lastName: regex },
        { $expr: { $regexMatch: { input: { $concat: ['$firstName', ' ', '$lastName'] }, regex: query, options: 'i' } } }
      ]
    }).select('username, fname, lname'); // Exclude sensitive fields

    res.json(users);
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error: search user' });
  }
}

async function getUserByUsername(req, res) {
  try {
    const { username } = req.params;
    const user = await User.findOne({ username });
    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }
    res.json(user);
  } catch (error) {
    res.status(500).json({ error: 'Internal Server Error: get user by username' });
  }
}


module.exports = {
  getUserByUsername,
  getOwnProfile,
  searchUsers
};

// Add more controller methods as needed