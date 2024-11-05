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

app.use(cors({
  origin: 'http://localhost:8080',
  credentials: true
}));

const mongoUrl = 'mongodb://root:example@mongodb:27017/exampledb?authSource=admin';

// connect to the database
mongoose.connect(mongoUrl, {
  useUnifiedTopology: true,
})
  .then(() => console.log('Connected to MongoDB'))
  .catch((error) => console.error('Error connecting to MongoDB:', error));

app.use(express.json());

// Session middleware
app.use(session({
  secret: 'your-secret-key',
  resave: false,
  saveUninitialized: true,
  cookie: {
    secure: isProduction, // Set to true if using HTTPS
    sameSite: isProduction ? 'None' : 'Lax'
  }
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