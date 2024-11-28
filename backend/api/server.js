const express = require('express');
const session = require('express-session');
const mongoose = require('mongoose');
const cors = require('cors');
const fs = require('fs');
const https = require('https');
const authRoutes = require('./routes/auth');
const userRoutes = require('./routes/user');
const exerciseRoutes = require('./routes/exercise');
const trainingPlanRoutes = require('./routes/trainingPlan');
const trainingSessionRoutes = require('./routes/trainingSession');

require('dotenv').config();


const app = express();
const port = 3000;

const isProduction = process.env.NODE_ENV === 'production';

const allowedWebOrigin = 'http://0.0.0.0:8080';

// Dynamic CORS configuration
const corsOptions = (req, callback) => {
  let corsOptions;
  const origin = req.header('Origin');

  if (origin === allowedWebOrigin) {
    // Allow requests from the specific web origin
    corsOptions = { origin: true, credentials: true, exposedHeaders: ['Set-Cookie'] };
  } else if (!origin || origin.startsWith('http://') || origin.startsWith('https://')) {
    // Allow requests from any origin (for mobile apps)
    corsOptions = { origin: true, credentials: true, exposedHeaders: ['Set-Cookie'] };
  } else {
    // Disallow other origins
    corsOptions = { origin: false };
  }

  callback(null, corsOptions);
};

// Use the dynamic CORS configuration
app.use(cors(corsOptions));


/*
app.use(cors({
  origin: 'http://0.0.0.0:8080',
  methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
  credentials: true
}));
*/

const mongoUrl = 'mongodb://root:example@mongodb:27017/exampledb?authSource=admin';

// connect to the database
mongoose.connect(mongoUrl, {
  useUnifiedTopology: true,
})
  .then(async () => {
    console.log('Connected to MongoDB')
    //destroy all data in the database for testing purposes
    await nukeDatabase();
  })
  .catch((error) => console.error('Error connecting to MongoDB:', error));

app.use(express.json());

// Session middleware
app.use(session({
  secret: 'your-secret-key',
  resave: false,
  saveUninitialized: true,
  cookie: { secure: true, httpOnly: true, sameSite: 'None' }
}));

// Add logging middleware
app.use((req, res, next) => {
  console.log('Request received:', req.method, req.url);
  console.log('Request headers:', req.headers);
  next();
});


// set routes
app.use('/auth', authRoutes);
app.use('/user', userRoutes);
app.use('/exercise', exerciseRoutes);
app.use('/trainingPlan', trainingPlanRoutes);
app.use('/trainingSession', trainingSessionRoutes);


if (isProduction) {
  const options = {
    key: fs.readFileSync('./https-dev/server.key'),
    cert: fs.readFileSync('./https-dev/server.cert')
  };

  https.createServer(options, app).listen(port, () => {
    console.log(`Server running on https://localhost:${port}`);
  });
} else {
  app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
  });
}

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

      try {
        const bcrypt = require('bcrypt');
        const User = require('./models/userModel');
        const testUsername = 'test';
        const testEmail = 'test@test.com';
        const testPassword = 'test123';
    
        // Check if the test user already exists
        const existingUser = await User.findOne({ email: testEmail });
        if (existingUser) {
          console.log('Test user already exists');
          return;
        }
    
        // Hash the test user's password
        const hashedTestPassword = await bcrypt.hash(testPassword, 10);
    
        // Create the test user
        const testUser = new User({
          username: testUsername,
          email: testEmail,
          password: hashedTestPassword,
        });
    
        // Save the test user to the database
        await testUser.save();
        console.log('Test user created successfully');
      } catch (error) {
        console.error('Error creating test user:', error);
      }
  } catch (error) {
    console.error('Error initializing database:', error);
  }
}