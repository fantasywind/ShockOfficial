mongoose = require 'mongoose'
Member = mongoose.model 'Member'
_ = require 'underscore'

exports.typeCheck = (req, res)->
  if _.isString req.params.memberName
    Member.findOne()
      .where('name', req.params.memberName)
      .where('type', 'shock')
      .select('name type')
      .exec (err, member)->
        throw err if err

        if member?
          res.json
            status: 'success'
            memberType: member.type
            memberId: member._id
        else
          res.json
            status: 'success'
            memberType: 'UNKNOWN'
            memberId: null
  else
    res.json
      status: 'fail'
      code: 1
      msg: 'Invalid Parameter'