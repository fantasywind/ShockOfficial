mongoose = require('mongoose')
Schema = mongoose.Schema
CONFIG = require "#{__dirname}/../../config.json"

Member = new mongoose.Schema
  email: String
  password: String
  name: String
  title: String
  create_date:
    type: Date
    default: Date.now
  type:
    type: String
    enum: ['guest', 'shock']
  privileges: [String]
    
# Validate Email
Member.path('email').validate (email)->
  emailRegex = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/
  emailRegex.test(email.text)
, 'Member Email Format Error.'

mongoose.model 'Member', Member