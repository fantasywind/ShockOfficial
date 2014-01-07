(function() {
  var Audit, Schema, mongoose;

  mongoose = require('mongoose');

  Schema = mongoose.Schema;

  Audit = new mongoose.Schema({
    message: String,
    grade: {
      type: String,
      "enum": ['first', 'second', 'third']
    },
    passwd: {
      type: Boolean,
      "default": true
    },
    audit_date: {
      type: Date,
      "default": Date.now
    },
    auditor: {
      type: mongoose.Schema.ObjectId,
      ref: 'Member'
    }
  });

  mongoose.model('Audit', Audit);

}).call(this);
