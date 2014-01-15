mongoose = require 'mongoose'
Schema = mongoose.Schema
crypto = require 'crypto'

Token = new mongoose.Schema
  access_token:
    type: String
    default: ->
      crypto.randomBytes(64).toString('hex')
    index:
      unique: true
  expired:
    type: Date
    default: ->
      new Date(Date.now() + 604800000)
    index: -1
  _member:
    type: Schema.Types.ObjectId
    ref: 'Member'

t = mongoose.model 'Token', Token

# Auto Clean Token
t.remove {}, (err)->
  throw err if err
  console.info 'Clean Access Token Collection.'