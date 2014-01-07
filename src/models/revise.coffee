mongoose = require('mongoose')
Schema = mongoose.Schema

Revise = new mongoose.Schema
  content: String
  commit_date:
    type: Date
    default: Date.now
  commiter:
    type: mongoose.Schema.ObjectId
    ref: 'Member'

mongoose.model 'Revise', Revise