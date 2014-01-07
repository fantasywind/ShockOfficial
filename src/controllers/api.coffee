mongoose = require('mongoose')
Member = mongoose.model('Member')
async = require('async')
crypto = require('crypto')
CONFIG = require(__dirname + '/../../config.json')

exports.publishLogin = (req, res)->
  if !req.body.email? or !req.body.password?
    return res.json
      status: 'fail'
      code: 1
      msg: 'Invalid Parameter'

  sha1 = crypto.createHash 'sha1'
  sha1.update req.body.password
  firstHash = sha1.digest 'hex'
  sha1 = crypto.createHash 'sha1'
  sha1.update firstHash.substr(0, 20) + CONFIG.ENCRYPTION_SALT + firstHash.substr(20, 20)
  salted = sha1.digest 'hex'

  Member.findOne()
    .where('email', req.body.email)
    .where('type', 'shock')
    .exec (err, member)->
      try
        throw err if err

        if member?
          if member.password is salted
            req.session.uid = member._id

            res.json
              status: 'success'
              member:
                name: member.name
                email: member.email
                title: member.title

          else
            res.json
              status: 'fail'
              code: 200
              msg: 'Password Error'
        else
          res.json
            status: 'fail'
            code: 100
            msg: 'Not Found'

      catch e
        console.error 'Mongo Error: ' + e.toString()
        res.json
          status: 'fail'
          code: 2
          msg: 'Server Error'