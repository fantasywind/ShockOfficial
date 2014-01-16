'use strict'

angular.module('shockApp')
  .factory 'newArticle', ['Publishlogin', (Publishlogin)->

    _isInterview = true

    _authors = []

    # Constant
    AUTHENTICATE = 'authenticate'
    GUEST = 'guest'
    UNKNOWN = 'unknown'

    # Public API here
    {
      setIsInterview: (newVal) ->
        _isInterview = newVal

      initialAuthor: ->
        _authors.length = 0

      addSelfToAuthor: ->
        _authors.push
          name: Publishlogin.name
          type: AUTHENTICATE

      getAuthorTypes: ->
        AUTHENTICATE: AUTHENTICATE
        GUEST: GUEST
        UNKNOWN: UNKNOWN

      getAuthors: ->
        _authors
    }
  ]