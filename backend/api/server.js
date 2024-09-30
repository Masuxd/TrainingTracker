const express = require('express');
const mongoose = require('mongoose');
const usersRoutes = require('./routes/users');

const app = express();
const port = 3000;

mongoose.connect('mongodb://root:example@mongodb:27017/exampledb?authSource=admin')
  .then(() => console.log('Connected to MongoDB'))
  .catch((error) => console.error('Error connecting to MongoDB:', error));

app.use('/users', usersRoutes);

app.listen(port, () => console.log(`Server running on port ${port}`));