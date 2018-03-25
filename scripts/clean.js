const mongoose = require('mongoose');

const config = require('../config/config');

// use global promise
mongoose.Promise = Promise;

// only affecting test database
const mongoUri = config.mongo.test;
mongoose.connect(mongoUri, () => {
  mongoose.connection.dropDatabase(() => {
    process.exit(0);
  });
});
