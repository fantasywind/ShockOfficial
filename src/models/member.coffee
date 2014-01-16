mongoose = require 'mongoose'
bcrypt = require 'bcrypt-nodejs'
Schema = mongoose.Schema

Member = new mongoose.Schema
  local:
    email: String
    password: String
  facebook:
    id: String
    token: String
    email: String
    name: String
  twitter:
    id: String
    token: String
    displayName: String
    username: String
  google:
    id: String
    token: String
    email: String
    name: String
  name: String
  title: String
  create_date:
    type: Date
    default: Date.now
  type:
    type: String
    enum: ['guest', 'shock']
    default: 'guest'
  privileges: [String]

# Hash generator
Member.methods.generateHash = (password)->
  bcrypt.hashSync password, bcrypt.genSaltSync(8), null

# Check password

Member.methods.validPassword = (password)->
  bcrypt.compareSync password, @local.password

mongoose.model 'Member', Member