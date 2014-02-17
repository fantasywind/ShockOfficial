'use strict'

angular.module('shockApp')
  .directive('tagSelector', () ->
    templateUrl: "/partials/tagselector"
    restrict: 'E'
    controller: ($scope, newArticle) ->
      _commaMatcher = /,/

      $scope.tags = []

      newArticle.setTags $scope.tags

      $scope.removeTag = (tag)->
        idx = $scope.tags.indexOf tag
        $scope.tags.splice idx, 1

      $scope.$watch 'tagList', (tagInput)->
        return false if tagInput is undefined or !_commaMatcher.test tagInput
        parseTag tagInput

      $scope.blurTag = (e)->
        parseTag e.target.value + ','

      parseTag = (tagInput)->
        tags = tagInput.split ','
        for tag in tags
          continue if tag is '' or $scope.tags.indexOf(tag) isnt -1
          $scope.tags.push tag.trim()
        $scope.tagList = undefined
  )
