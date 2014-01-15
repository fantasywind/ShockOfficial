'use strict'

angular.module('shockApp')
  .factory 'errorAuthenticate', () ->
    # Public API here
    {
      EMPTY_NAME: 'Empty name field.'
      INVAILD_EMAIL: 'Invalid email.'
      ALREADY_TAKEN: 'That email is already taken.'
      NOT_FOUND: 'No member found.'
      WRONG_PASSWORD: 'Wrong passeord.'
      LOGINED: 'Logined.'
      SIGNUPED: 'Signed up.'
      INVALID_INPUT: 'Please fulfill form.'
    }
