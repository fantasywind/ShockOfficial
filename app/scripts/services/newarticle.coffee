'use strict'

angular.module('shockApp')
  .factory 'newArticle', ['Publishlogin', '$http', '$log', '$compile', '$rootScope', (Publishlogin, $http, $log, $compile, $rootScope)->

    _isInterview = true

    _authors = []
    _photos = []
    _modal = null

    # Constant
    AUTHENTICATE = 'shock'
    GUEST = 'guest'
    UNKNOWN = 'unknown'
    FETCHING = 'fetching'

    _photoSelector = null

    # Public API here
    {
      injectPhoto: (photos)->
        photos = [photos] if !angular.isArray photos

        # Add after focue element
        selection = window.getSelection()
        focusElem = angular.element selection.focusNode
        focusElem = focusElem.parent() if focusElem[0].nodeType is 3
        containCheck = !!angular.element('text-angular > div.editor-content').find(focusElem).length
        if selection.type is 'Caret' and containCheck
          wrapper = angular.element '<photo-gallery>'
          wrapper.attr
            photos: JSON.stringify(photos)
            gallerymode: 'block'
            contenteditable: false
          $compile(wrapper)($rootScope)
          focusElem.after wrapper
        else
          # Add by default position
          target = 'DEFAULT'
        return true

      showPhotoSelector: ->
        if _photoSelector?
          _photoSelector.show()
        else
          console.error "Unknown Photo Selector Module."

      setPhotoSelector: (selectorControl)->
        _photoSelector = selectorControl

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