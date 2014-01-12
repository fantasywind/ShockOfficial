mongoose = require 'mongoose'
path = require 'path'
fs = require 'fs'
Member = mongoose.model 'Member'

folders = ['publish', 'article']

for folder in folders
	# 讀取 Controller
	tmp = {}
	publishPath = path.join __dirname, folder
	fs.readdirSync(publishPath).forEach (file)->
	  fn = require publishPath + '/' + file
	  for key, value of fn
	    tmp[key] = value
  exports[folder] = tmp