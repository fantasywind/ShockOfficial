'use strict'

angular.module('shockApp')
  .directive('photoSelector', () ->
    templateUrl: '/partials/photoselector'
    restrict: 'E'
    controller: (newArticle, $scope, $element)->
      $scope.photos = newArticle.getPhotos()
      $scope.showModal = ->
        newArticle.showModal()

      SELECTED_CONSTANT = newArticle.getSelectedConstant()

      newArticle.bindUploadModal $element.find '.modal'

      newArticle.addPhoto
        source: '//placehold.it/130x130'
        description: 'aaa'
        tag: []
      newArticle.addPhoto
        source: '//placehold.it/130x130'
        description: 'aaa'
        tag: []
      newArticle.addPhoto
        source: '//placehold.it/130x130'
        description: 'aaa'
        tag: []
      newArticle.addPhoto
        source: '//placehold.it/130x130'
        description: 'aaa'
        tag: []
      newArticle.addPhoto
        source: '//placehold.it/130x130'
        description: 'aaa'
        tag: []
      newArticle.addPhoto
        source: '//placehold.it/130x130'
        description: 'aaa'
        tag: []
      newArticle.addPhoto
        source: '//placehold.it/130x130'
        description: 'aaa'
        tag: []
      newArticle.addPhoto
        source: '//placehold.it/130x130'
        description: 'aaa'
        tag: []
      newArticle.addPhoto
        source: '//placehold.it/130x130'
        description: 'aaa'
        tag: []
      newArticle.addPhoto
        source: '//placehold.it/130x130'
        description: 'aaa'
        tag: []
      newArticle.addPhoto
        source: '//placehold.it/130x130'
        description: 'aaa'
        tag: []
      newArticle.addPhoto
        source: '//placehold.it/130x130'
        description: 'aaa'
        tag: []
  )
