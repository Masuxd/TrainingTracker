const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const app = express();
const port = 3000;

app.use(cors());

mongoose.connect('mongodb://root:example@mongodb:27017/exampledb?authSource=admin')
  .then(() => {
    console.log('Connected to MongoDB');
  })
  .catch((error) => {
    console.error('Error connecting to MongoDB:', error);
  });

const exampleSchema = new mongoose.Schema({
  name: String,
  description: String,
}, { collection: 'exampleCollection' }); // Specify the collection name explicitly

const Example = mongoose.model('Example', exampleSchema);

app.get('/examples', async (req, res) => {
  console.log('Received request for /examples'); // Log request received
  try {
    const examples = await Example.find();
    console.log('Fetched examples:', examples); // Log fetched data
    res.json(examples);
  } catch (error) {
    console.error('Error fetching examples:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

app.listen(port, () => {
  console.log(`API server listening at http://localhost:${port}`);
});
