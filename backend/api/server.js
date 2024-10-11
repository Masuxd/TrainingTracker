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
  .then(() => console.log('Connected to MongoDB'))
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