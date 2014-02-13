mongoose = require('mongoose')
Schema = mongoose.Schema

ArticleCategory = new mongoose.Schema
  name: String
  allowNew:
    type: Boolean
    default: true

mongoose.model 'ArticleCategory', ArticleCategory