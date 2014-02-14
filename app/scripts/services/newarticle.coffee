'use strict'

angular.module('shockApp')
  .factory 'newArticle', ['Publishlogin', '$http', '$log', '$compile', '$rootScope', (Publishlogin, $http, $log, $compile, $rootScope)->

    _isInterview = true

    _authors = []
    _photos = []
    _modal = null

    # Constant
    SELF = 'self'
    AUTHENTICATE = 'shock'
    GUEST = 'guest'
    UNKNOWN = 'unknown'
    FETCHING = 'fetching'

    _photoSelector = null

    # Get wrapper
    getGalleryWrapper = (photos)->
      wrapper = angular.element '<photo-gallery>'
      wrapper.attr
        photos: JSON.stringify(photos)
        gallerymode: 'block'
        contenteditable: false
      $compile(wrapper)($rootScope)
      return wrapper

    # Check next gallery
    checkNextGallery = (wrapper)->
      checkNext = wrapper.next()
      if !checkNext.length
        newParagraph = angular.element '<p>'
        wrapper.after newParagraph

    # Watch Login Info Self Name
    $rootScope.$watch ->
      Publishlogin.name
    , (newVal)->
      selfAuthor = _.findWhere _authors,
        type: SELF
      selfAuthor.name = newVal if !!selfAuthor

    # Public API here
    {
      injectPhoto: (photos)->
        photos = [photos] if !angular.isArray photos

        selection = window.getSelection()
        focusElem = angular.element selection.focusNode
        focusElem = focusElem.parent() if focusElem.length and focusElem[0].nodeType is 3
        containCheck = !!angular.element('text-angular > div.editor-content').find(focusElem).length
        wrapper = getGalleryWrapper photos
        if selection.type is 'Caret' and focusElem.length and containCheck
          # Add after focue element
          focusElem.after wrapper
        else
          # Add by default position
          angular.element('text-angular > div.editor-content').append wrapper

        checkNextGallery wrapper

        # Change Status
        for photo in photos
          photo.status = 'injected' 
          photo.selected = false

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
          type: SELF

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
        SELF: SELF

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