'use strict'

angular.module('shockApp')
  .directive('photoGallery', () ->
    templateUrl: '/partials/photogallery'
    restrict: 'E'
    scope:
      photos: '='
      gallerymode: '@'
  )
