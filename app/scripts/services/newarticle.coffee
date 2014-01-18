'use strict'

angular.module('shockApp')
  .factory 'newArticle', ['Publishlogin', '$http', '$log', (Publishlogin, $http, $log)->

    _isInterview = true

    _authors = []
    _photos = []
    _modal = null

    # Constant
    AUTHENTICATE = 'shock'
    GUEST = 'guest'
    UNKNOWN = 'unknown'
    FETCHING = 'fetching'
    SELECTED = true
    UNSELECTED = false

    # Tag Parsing
    parseTag = (tag)->
      return tag if angular.iaArray tag
      return [] if !angular.isString tag

    # Public API here
    {
      showModal: ->
        if _modal isnt null
          _modal.modal 'show'
          true
        else
          false

      bindUploadModal: (modal)->
        _modal = modal

      setIsInterview: (newVal) ->
        _isInterview = newVal

      initialAuthor: ->
        _authors.length = 0

      addSelfToAuthor: ->
        _authors.push
          name: Publishlogin.name
          type: AUTHENTICATE

      addAuthor: (newAuthor)->
        for author in _authors
          return false if author.name is newAuthor
        newAuthor = 
          name: newAuthor
          type: UNKNOWN

        # Check Member Status
        request = $http
          method: 'GET'
          url: "/api/member/type/#{newAuthor.name}"

        request.success (result)->
          if result.status is 'success'
            newAuthor.type = result.memberType

        request.error (err)->
          $log.error err

        _authors.push newAuthor

      getAuthorTypes: ->
        AUTHENTICATE: AUTHENTICATE
        GUEST: GUEST
        UNKNOWN: UNKNOWN
        FETCHING: FETCHING

      getSelectedConstant: ->
        SELECTED: SELECTED
        UNSELECTED: UNSELECTED

      getPhotos: ->
        _photos

      addPhoto: (fields)->
        return if fields is undefined
        {source, description, tag} = fields

        try
          description ?= ''
          tag ?= []

          tag = parseTag tag if angular.isString tag
          throw new Error 'Invalid Tag' if !angular.isArray tag

          _photos.push
            source: source
            description: description
            tag: tag
            selected: UNSELECTED

        catch ex
          return false

      getAuthors: ->
        _authors

      removeAuthor: (authorBeRemoved)->
        for author, idx in _authors
          if authorBeRemoved is author
            _authors.splice idx, 1
            return true
        return false
    }
  ]