imagemagick = require 'imagemagick-native'
fs = require 'fs'
path = require 'path'
crypto = require 'crypto'
poolPath = path.resolve __dirname, '../../../uploads/photos'
mongoose = require('mongoose')
Photo = mongoose.model 'Photo'

# Check permission
try
  # Check Uploads Folder
  if fs.existsSync path.resolve(poolPath, '../')
    stat = fs.statSync path.resolve(poolPath, '../')
    if !stat.isDirectory()
      throw new Error('Uploads path is a file.')
  else
    fs.mkdirSync path.resolve(poolPath, '../')
    console.info 'Make upload folder.'

  # Check Photo Pool
  if fs.existsSync poolPath
    stat = fs.statSync poolPath
    if !stat.isDirectory()
      throw new Error('Photo pool path is a file.')
  else
    fs.mkdirSync poolPath
    console.info 'Make Photo Pool'

  # Write Test
  fs.writeFile poolPath + '/permissionTest', 'test', (err)->
    throw err if err
    console.info 'Checked Upload Path Permission.'
    fs.unlink poolPath + '/permissionTest'
catch ex
  console.error "Upload Path Error: #{ex}"

getHashName = ->
  hash = crypto.randomBytes 32
  hash = hash.toString 'hex'
  if fs.existsSync "#{poolPath}/#{hash}"
    return getHashName()
  else
    return hash

exports.upload = (req, res)->
  hash = getHashName()

  fs.renameSync req.files.file.path, "#{poolPath}/#{hash}"

  buf = fs.readFileSync "#{poolPath}/#{hash}"

  # Resize to 1280px width
  buf1280 = imagemagick.convert
    srcData: buf
    width: 1280
    height: 720
    resizeStyle: 'aspectfit'
    format: "PNG"

  fs.writeFile "#{poolPath}/#{hash}_1280.png", buf1280, (err)->
    throw err if err

  # Resize to 200px width
  buf200 = imagemagick.convert
    srcData: buf
    width: 200
    height: 133
    resizeStyle: 'aspectfit'
    format: "PNG"

  fs.writeFileSync "#{poolPath}/#{hash}_200.png", buf200

  # Resize to 120px width
  buf120 = imagemagick.convert
    srcData: buf
    width: 120
    height: 80
    resizeStyle: 'aspectfit'
    format: "PNG"

  fs.writeFileSync "#{poolPath}/#{hash}_120.png", buf120

  photo = new Photo
    description: req.files.file.name
    source: "/photos/#{hash}"
    uploader: req.user._id
  photo.save()

  res.json
    status: 'ok'
    photo_id: photo._id
    thumb: "/photos/#{hash}_120.png"
    src: "/photos/#{hash}"
    name: req.files.file.name