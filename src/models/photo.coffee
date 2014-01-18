mongoose = require('mongoose')
Schema = mongoose.Schema

Photo = new mongoose.Schema
  source: String
  description: String
  tag: [{
    type: mongoose.Schema.ObjectId
    ref: 'Tag'
  }]
  uploader:
    type: mongoose.Schema.ObjectId
    ref: 'Member'

mongoose.model 'Photo', Photo