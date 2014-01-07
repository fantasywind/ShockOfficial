(function() {
  var Member, Schema, mongoose;

  mongoose = require('mongoose');

  Schema = mongoose.Schema;

  Member = new mongoose.Schema({
    name: String,
    create_date: {
      type: Date,
      "default": Date.now
    }
  });

  mongoose.model('Member', Member);

}).call(this);
