mongoose = require('mongoose')
Schema = mongoose.Schema

Print = new mongoose.Schema
  name: String
  release:
    type: Boolean
    default: false

mongoose.model 'Print', Print