'use strict'

angular.module('shockApp')
  .directive('authorSelector', ->
    templateUrl: '/partials/authorselector.html'
    restrict: 'E'
    controller: ($scope, $timeout, newArticle)->

      $scope.authors = newArticle.getAuthors()

      $scope.AUTHOR_TYPE = newArticle.getAuthorTypes()

      $scope.removeThis = (author)->
        newArticle.removeAuthor author

      # Initial new article
      newArticle.initialAuthor()
      newArticle.addSelfToAuthor()
      newArticle.addSelfToAuthor()
      newArticle.addSelfToAuthor()
      newArticle.addSelfToAuthor()
      newArticle.addSelfToAuthor()
      newArticle.addSelfToAuthor()

      $timeout ->
        newArticle.addSelfToAuthor()
      , 1500

  )
