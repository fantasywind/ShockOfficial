mongoose = require('mongoose')
Schema = mongoose.Schema

Article = new mongoose.Schema
  title: String
  author: [{
    type: Schema.ObjectId
    ref: 'Member'
  }]
  author_external: [String]
  content: String
  print:
    type: Schema.ObjectId
    ref: 'Print'
  photo: [
    type: Schema.ObjectId
    ref: 'Photo'
  ]
  gallery: [
    photos: [
      type: Schema.ObjectId
      ref: 'Photo'
    ]
    mode:
      type: String
      enum: ['block', 'slide']
      default: 'block'
    guid: String
  ]
  tag: [{
    type: Schema.ObjectId
    ref: 'Tag'
  }]
  category: 
    type: Schema.ObjectId
    ref: 'ArticleCategory'
  region: String
  release_date:
    type: Date
    default: null
  create_date:
    type: Date
    default: Date.now
  revise: [{
    type: Schema.ObjectId
    ref: 'Revise'
  }]
  audit: [{
    type: Schema.ObjectId
    ref: 'Audit'
  }]

mongoose.model 'Article', Article