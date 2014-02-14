'use strict'

angular.module('shockApp')
  .directive('tagSelector', () ->
    templateUrl: "/partials/tagselector"
    restrict: 'E'
    controller: ($scope, $element) ->
      console.dir $element
      #element.text 'this is the tagSelector directive'
  )
