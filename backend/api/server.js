const express = require('express');
const session = require('express-session');
const mongoose = require('mongoose');
const MongoStore = require('connect-mongo');
const cors = require('cors');
const fs = require('fs');
const https = require('https');
const authRoutes = require('./routes/auth');
const userRoutes = require('./routes/user');
const exerciseRoutes = require('./routes/exercise');
const workoutRoutes = require('./routes/workout');
const logRoutes = require('./routes/userLog');


require('dotenv').config();


const app = express();
const port = process.env.PORT;

const isDevelopment = process.env.NODE_ENV === 'development';


// Middleware to parse JSON and cookies
app.use(express.json());
app.set('trust proxy', true); // Ensures the original request scheme is recognized


// Dynamic CORS configuration
const corsOptions = (req, callback) => {
  let corsOptions;
  const origin = req.header('Origin');

  if (origin && origin.startsWith('https://')) {
    // Allow requests only from HTTPS origins
    corsOptions = {
      origin: true,
      credentials: true, // Allow cookies to be sent
      exposedHeaders: ['Set-Cookie'], // Expose 'Set-Cookie' to the client
    };
  } else {
    // Disallow other origins
    corsOptions = { origin: false };
  }

  callback(null, corsOptions);
};

// Enable CORS with dynamic configuration
app.use(cors(corsOptions));

// Explicitly handle preflight OPTIONS requests
app.options('*', cors(corsOptions));


const mongoURI = process.env.MONGO_URI;

// connect to the database
mongoose.connect(mongoURI, {
  ssl: !isDevelopment,
  serverApi: {
    version: '1',
    strict: true,
    deprecationErrors: true,
  }
})
  .then(async () => {
    console.log('Connected to MongoDB')
    //destroy all data in the database for testing purposes
    if(isDevelopment || process.env.RESET_DB === 'true') {
      await setupDevDatabase();
    }
    await initializeSessionMiddleware();
    await setRoutes();
  })
  .catch((error) => console.error('Error connecting to MongoDB:', error));

app.use(express.json());

// Function to initialize session middleware
async function initializeSessionMiddleware() {
  app.use(session({
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: true,
    store: MongoStore.create({
      mongoUrl: mongoURI,
      collectionName: 'sessions'
    }),
    cookie: { secure: true, httpOnly: true, sameSite: 'None' }
  }));
  console.log('Session middleware initialized');
}


// set routes
async function setRoutes() {
  app.use('/auth', authRoutes);
  app.use('/user', userRoutes);
  app.use('/exercise', exerciseRoutes);
  app.use('/workout', workoutRoutes);
  app.use('/logs', logRoutes);
}



if (isDevelopment) {
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


async function setupDevDatabase() {
  const bcrypt = require('bcrypt');
  const User = require('./models/userModel');
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
        const testUsername = 'test';
        const testEmail = 'test@test.local';
        const testPassword = 'test123';
        const verified = true;
    
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
          verified: verified
        });
    
        // Save the test user to the database
        await testUser.save();
        console.log('Test user created successfully');
      } catch (error) {
        console.error('Error creating test user:', error);
      }

      try {
        const testUsername = 'testadmin';
        const testEmail = 'testadmin@test.local';
        const testPassword = 'testadmin123';
        const testRole = 'admin'; // Admin role
        const verified = true;
    
        // Check if the test admin user already exists
        const existingUser = await User.findOne({ email: testEmail });
        if (existingUser) {
          console.log('Test admin user already exists');
          return;
        }
    
        // Hash the test admin user's password
        const hashedTestPassword = await bcrypt.hash(testPassword, 10);
    
        // Create the test admin user
        const testAdminUser = new User({
          username: testUsername,
          email: testEmail,
          password: hashedTestPassword,
          role: testRole, // Assign the admin role
          verified: verified
        });
    
        // Save the test admin user to the database
        await testAdminUser.save();
        console.log('Test admin user created successfully');
      } catch (error) {
        console.error('Error creating test admin user:', error);
      }

  } catch (error) {
    console.error('Error initializing database:', error);
  }
}

