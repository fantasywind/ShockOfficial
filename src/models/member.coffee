mongoose = require 'mongoose'
bcrypt = require 'bcrypt-nodejs'
Schema = mongoose.Schema

Member = new mongoose.Schema
  local:
    email:
      type: String
      unique: true
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
  privileges: [
    type: String
    enum: [
      'global_article_editor'
      'audit_level_1'
      'audit_level_2'
      'audit_level_3'
      'publish_master'
      'publish_level_1'
      'publish_level_2'
      'publish_level_3'
    ]
  ]

# Hash generator
Member.methods.generateHash = (password)->
  bcrypt.hashSync password, bcrypt.genSaltSync(8), null

# Check password

Member.methods.validPassword = (password)->
  bcrypt.compareSync password, @local.password

mongoose.model 'Member', Member