db = db.getSiblingDB('exampledb'); // Create or switch to the exampledb database

db.createCollection('exampleCollection'); // Create a collection

db.exampleCollection.insertMany([
  { name: 'Item 1', description: 'Description for Item 1' },
  { name: 'Item 2', description: 'Description for Item 2' },
  { name: 'Item 3', description: 'Description for Item 3' }
]);
