'use strict'

angular.module('shockApp')
  .directive('photoSelector', () ->
    templateUrl: '/partials/photoselector'
    restrict: 'E'
    controller: ($rootScope, $scope, $element, $filter, Uploadphoto, newArticle)->
      $scope.photos = []

      injector = if angular.isFunction newArticle.injectPhoto then newArticle.injectPhoto else null
      console.error 'Undefined injector.' if !injector?

      modalDOM = $element.find '.modal'

      # Constant
      $scope.SELECTED = true
      $scope.UNSELECTED = false
      $scope.WAIT = 'wait'
      $scope.LOADING = 'loading'
      $scope.SUCCESS = 'success'
      $scope.ERROR = 'error'

      $scope.showSelector = false

      # Bind PhotoSelector to newArticle Service
      newArticle.setPhotoSelector 
        show: ->
          $scope.showSelector = true
        hide: ->
          $scope.showSelector = false

      # Tag Parsing
      parseTag = (tag)->
        return tag if angular.isArray tag
        return [] if !angular.isString tag

      $scope.showModal = ->
        modalDOM.modal 'show'
        return true

      # Listener for upload
      fileInput = $element.find('.file-selector')[0]
      upload = ->
        if fileInput.files.length
          photoUploading = []

          for photo in fileInput.files
            p = addPhoto
              source: '//placehold.it/120x80'
              thumb200: '//placehold.it/200x133'
              description: '未命名圖片'
              tag: []
              photo_id: null
            photoUploading.push p

          q = Uploadphoto.uploadFiles fileInput.files, ->

            # make thumb 200 link
            thumb200 = @thumb120.replace /([^_]*_)\d*(.*)/g, '$1200$2'

            $scope.$apply =>
              p = photoUploading[@queue._cursor]
              p.status = $scope.SUCCESS
              p.source = @thumb120
              p.thumb200 = thumb200
              p.description = @filename
              p.photo_id = @photo_id
              newArticle.uploadedPhoto p
          q.start_upload()

        # Hide Modal
        modalDOM.modal 'hide'
        return true

      # Listen Selected
      angular.element(fileInput).bind 'change', ->
        if @files.length
          upload()

      # Select Photo
      $scope.selectThis = (photo)->
        if photo.status is 'success'
          photo.selected = !photo.selected

      $scope.injectPhotos = ->
        selected = $filter('filter') $scope.photos, (photo)->
          return photo.selected
        if injector?
          injector selected

      addPhoto = (fields)->
        return if fields is undefined
        {source, description, tag, status} = fields

        try
          description ?= ''
          tag ?= []

          tag = parseTag tag if angular.isString tag
          throw new Error 'Invalid Tag' if !angular.isArray tag

          photo =
            source: source
            description: description
            tag: tag
            selected: $scope.UNSELECTED
            status: status or $scope.WAIT

          $scope.photos.push photo

          return photo

        catch ex
          console.error ex
          return false
  )
