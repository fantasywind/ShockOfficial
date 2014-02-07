'use strict'

angular.module('shockApp')
  .directive('photoSelector', () ->
    templateUrl: '/partials/photoselector'
    restrict: 'E'
    controller: (newArticle, $scope, $element, Uploadphoto)->
      $scope.photos = []

      modalDOM = $element.find '.modal'

      # Constant
      $scope.SELECTED = true
      $scope.UNSELECTED = false
      $scope.WAIT = 'wait'
      $scope.LOADING = 'loading'
      $scope.SUCCESS = 'success'
      $scope.ERROR = 'error'

      # Tag Parsing
      parseTag = (tag)->
        return tag if angular.iaArray tag
        return [] if !angular.isString tag

      $scope.showModal = ->
        modalDOM.modal 'show'
        return true

      # Listener for upload
      fileInput = $element.find('.file-selector')[0]
      $scope.upload = ->
        if fileInput.files.length
          photoUploading = []

          for photo in fileInput.files
            p = addPhoto
              source: '//placehold.it/120x80'
              description: '未命名圖片'
              tag: []
            photoUploading.push p

          q = Uploadphoto.uploadFiles fileInput.files, ->
            $scope.$apply =>
              p = photoUploading[@queue._cursor]
              p.status = $scope.SUCCESS
              p.source = @thumb120
              p.description = @filename
          q.start_upload()

        # Hide Modal
        modalDOM.modal 'hide'
        return true

      # Select Photo
      $scope.selectThis = (photo)->
        if photo.status is 'success'
          photo.selected = !photo.selected


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

      addPhoto
        source: '//placehold.it/120x80'
        description: 'aaa'
        tag: []
        status: $scope.SUCCESS
      addPhoto
        source: '//placehold.it/120x80'
        description: 'aaa'
        tag: []
        status: $scope.ERROR
      addPhoto
        source: '//placehold.it/120x80'
        description: 'aaa'
        tag: []
        status: $scope.SUCCESS
  )
