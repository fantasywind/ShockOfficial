'use strict'

angular.module('shockApp')
  .factory 'newArticle', ['Publishlogin', '$http', '$log', '$compile', '$rootScope', '$location', (Publishlogin, $http, $log, $compile, $rootScope, $location)->

    _isInterview = true

    _authors = []
    _photos = []
    _tags = []
    _category = null
    _title = null
    _modal = null
    _content = null
    _injectedPhotos = []
    
    window.s = _photos

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
      setTitle: (title)->
        return false if !angular.isString title
        _title = title

      setCategory: (category)->
        return false if !angular.isString category
        _category = category

      setContent: (content)->
        return false if !angular.isString content
        _content = content

      uploadedPhoto: (photo)->
        _photos.push photo

      injectPhoto: (photos)->
        photos = [photos] if !angular.isArray photos

        _injectedPhotos.push photo for photo in photos
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

      removeInjectedPhotos: (photos)->
        return false if !angular.isArray photos

        for photo in photos
          for p, idx in _injectedPhotos
            if p.source is photo.source and p.$$hashKey is photo.$$hashKey
              p.status = 'success'
              _injectedPhotos.splice idx, 1
              break

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
            newAuthor.member_id = result.memberId

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

      setTags: (tags)->
        return false if !angular.isArray tags
        _tags = tags

      submit: (e)->

        # Simplize
        _a = []
        for author in _authors
          _a.push
            name: author.name
            type: author.type

        _t = []
        _t.push tag for tag in _tags

        _p = []
        for photo in _photos
          _p.push photo.photo_id

        # Serialize
        data =
          title: _title
          category_id: _category
          authors: _a
          tags: _t
          content: _content
          photos: _p

        # Send
        req = $http
          url: '/api/article'
          method: 'POST'
          data: $.param data

        req.error (data, status, headers, config)->
          console.error "Post article error: #{data.toString()}"

        req.success (resp)->
          if resp.status
            console.log "Posted Article: #{_title}"
            $location.path '/publish/article?status=success'
          else
            console.error "Post article error: (#{resp.code}) #{resp.msg}"
    }
  ]