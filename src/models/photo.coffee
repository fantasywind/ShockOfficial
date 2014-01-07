mongoose = require('mongoose')
Schema = mongoose.Schema

Photo = new mongoose.Schema
  source: String
  description: String
  uploader:
    type: mongoose.Schema.ObjectId
    ref: 'Member'

mongoose.model 'Photo', Photo