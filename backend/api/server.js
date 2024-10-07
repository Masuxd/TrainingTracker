const express = require('express');
const mongoose = require('mongoose');
const userRoutes = require('./routes/users');
const exerciseRoutes = require('./routes/exercises');
const trainingPlanRoutes = require('./routes/trainingPlans');
const trainingSessionRoutes = require('./routes/trainingSessions');

const app = express();
const port = 3000;

mongoose.connect('mongodb://root:example@mongodb:27017/exampledb?authSource=admin')
  .then(() => console.log('Connected to MongoDB'))
  .catch((error) => console.error('Error connecting to MongoDB:', error));

app.use('/user', userRoutes);
app.use('/exercise', exerciseRoutes);
app.use('/trainingPlan', trainingPlanRoutes);
app.use('/trainingSession', trainingSessionRoutes);

app.listen(port, () => console.log(`Server running on port ${port}`));