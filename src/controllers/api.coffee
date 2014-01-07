mongoose = require 'mongoose'
path = require 'path'
fs = require 'fs'
Member = mongoose.model 'Member'

# 讀取出版系統 Controller
publish = {}
publishPath = path.join __dirname, 'publish'
fs.readdirSync(publishPath).forEach (file)->
  fn = require publishPath + '/' + file
  for key, value of fn
    publish[key] = value

exports.publish = publish