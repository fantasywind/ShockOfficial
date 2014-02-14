'use strict'

angular.module('shockApp')
  .directive('tagSelector', () ->
    templateUrl: "/partials/tagselector"
    restrict: 'E'
    link: (scope, element, attrs) ->
      #element.text 'this is the tagSelector directive'
  )
