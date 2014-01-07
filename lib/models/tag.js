(function() {
  var Schema, Tag, mongoose;

  mongoose = require('mongoose');

  Schema = mongoose.Schema;

  Tag = new mongoose.Schema({
    name: String,
    count: {
      type: Number,
      "default": 0
    }
  });

  mongoose.model('Tag', Tag);

}).call(this);
