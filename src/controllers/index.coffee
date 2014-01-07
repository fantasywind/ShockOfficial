path = require('path')

exports.partials = (req, res)->
  stripped = req.url.split('.')[0]
  requestedView = path.join('./', stripped)
  res.render requestedView, (err, html)->
    if err
      res.render('404')
    else
      res.send(html)

exports.index = (req, res)->
  res.sendfile path.resolve(__dirname + '/../../app/views/index.html')