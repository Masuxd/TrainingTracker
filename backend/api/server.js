const express = require('express');
const session = require('express-session');
const MongoStore = require('connect-mongo');
const mongoose = require('mongoose');

const authRoutes = require('./routes/auth');
const userRoutes = require('./routes/user');
const exerciseRoutes = require('./routes/exercise');
const trainingPlanRoutes = require('./routes/trainingPlan');
const trainingSessionRoutes = require('./routes/trainingSession');

const app = express();
const port = 3000;

const mongoUrl = 'mongodb://root:example@mongodb:27017/exampledb?authSource=admin';

// connect to the database
mongoose.connect(mongoUrl, {
  useUnifiedTopology: true,
})
  .then(() => {
    console.log('Connected to MongoDB')
    //destroy all data in the database for testing purposes
    nukeDatabase();
  })
  .catch((error) => console.error('Error connecting to MongoDB:', error));

app.use(express.json());

// Session middleware
app.use(session({
  secret: 'yourSecretKey',
  resave: false,
  saveUninitialized: false,
  store: MongoStore.create({ mongoUrl }),
  cookie: { maxAge: 1000 * 60 * 60 * 24 } // 1 day
}));


// set routes
app.use('/auth', authRoutes);
app.use('/user', userRoutes);
app.use('/exercise', exerciseRoutes);
app.use('/trainingPlan', trainingPlanRoutes);
app.use('/trainingSession', trainingSessionRoutes);


app.listen(port, () => console.log(`Server running on port ${port}`));

async function nukeDatabase() {
  try {
    const db = mongoose.connection;
    await db.dropDatabase();
    console.log('Database dropped successfully');

    const exercises = [
      { "name": "Bench Press", "weight": true, "distance": false, "duration": false, "speed": false },
      { "name": "Squat", "weight": true, "distance": false, "duration": false, "speed": false },
      { "name": "Deadlift", "weight": true, "distance": false, "duration": false, "speed": false },
      { "name": "Overhead Press", "weight": true, "distance": false, "duration": false, "speed": false },
      { "name": "Bicep Curl", "weight": true, "distance": false, "duration": false, "speed": false },
      { "name": "Tricep Extension", "weight": true, "distance": false, "duration": false, "speed": false },
      { "name": "Leg Press", "weight": true, "distance": false, "duration": false, "speed": false },
      { "name": "Lat Pulldown", "weight": true, "distance": false, "duration": false, "speed": false },
      { "name": "Seated Row", "weight": true, "distance": false, "duration": false, "speed": false },
      { "name": "Plank", "weight": false, "distance": false, "duration": true, "speed": false },
      { "name": "Wall Sit", "weight": false, "distance": false, "duration": true, "speed": false },
      { "name": "Static Lunge", "weight": false, "distance": false, "duration": true, "speed": false },
      { "name": "Isometric Hold", "weight": false, "distance": false, "duration": true, "speed": false }
    ];

    const Exercise = require('./models/exerciseModel');
    await Exercise.insertMany(exercises);
    console.log('Exercise data inserted successfully');
  } catch (error) {
    console.error('Error initializing database:', error);
  }
}