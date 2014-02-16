'use strict'

angular.module('shockApp')
  .directive('photoGallery', () ->
    templateUrl: '/partials/photogallery'
    restrict: 'E'
    scope:
      photos: '='
      gallerymode: '@'
    controller: ($scope, newArticle, $element)->
      $scope.removeAllInjected = ->
        newArticle.removeInjectedPhotos $scope.photos
        $element.remove()
        return true
  )
