db = db.getSiblingDB('exampledb'); // Create or switch to the exampledb database

db.dropDatabase(); // Drop the database to start fresh

db.exercise.insertMany([
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
]);