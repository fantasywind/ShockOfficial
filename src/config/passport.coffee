LocalStrategy = require('passport-local').Strategy
mongoose = require 'mongoose'
Member = mongoose.model 'Member'
Token = mongoose.model 'Token'

module.exports = (passport)->

  # Passport Session Setup

  passport.serializeUser (member, done)->
    done null, member.id

  passport.deserializeUser (id, done)->
    Member.findById id, (err, member)->
      done err, member

  # Local Sign Up
  passport.use 'local-signup', new LocalStrategy
    usernameField: 'email'
    passwordField: 'password'
    passReqToCallback: true
  , (req, email, password, done)->
    if req.body.name is undefined or typeof req.body.name isnt 'string' or req.body.name is ''
      return done null, false, req.flash('signupMessage', 'Empty name field.')

    if !/^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/.test email
      return done null, false, req.flash('signupMessage', 'Invalid email.')

    Member.findOne
      'local.email': email
    , (err, member)->
      return done err if err

      if member
        done null, false, req.flash('signupMessage', 'That email is already taken.')
      else
        newMember = new Member

        newMember.local.email = email
        newMember.local.password = newMember.generateHash password
        newMember.name = req.body.name

        newMember.save (err)->
          throw err if err

          done null, newMember

  # Local Sign in
  passport.use 'local-login', new LocalStrategy
    usernameField: 'email'
    passwordField: 'password'
    passReqToCallback: true
  , (req, email, password, done)->
    Member.findOne
      'local.email': email
    , (err, member)->
      return done err if err

      if !member
        return done null, false, req.flash('loginMessage', 'No member found.')

      if !member.validPassword password
        return done null, false, req.flash('loginMessage', 'Wrong passeord.')

      token = new Token
        _member: member._id

      token.save()

      req.session.access_token = token.access_token

      done null, member

  # Local Sign in with access_token
  passport.use 'local-login-access-token', new LocalStrategy
    usernameField: 'email'
    passwordField: 'password'
    passReqToCallback: true
  , (req, email, password, done)->
    token = Token.findOne()
    token.where 'access_token', req.body.access_token
    token.where('expired').gt new Date()
    token.populate('_member')
    token.exec (err, token)->
      return done err if err

      if !token or !token._member.local.email
        return done null, false, req.flash('loginMessage', 'No member found.')

      newToken = new Token
        _member: token._member._id

      newToken.save()

      req.session.access_token = newToken.access_token

      done null, token._member