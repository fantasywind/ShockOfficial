'use strict'

angular.module('shockApp')
  .directive 'authorSelector', ->
    templateUrl: '/partials/authorselector.html'
    restrict: 'E'
    require: 'ngModel'
    controller: ($rootScope, $scope, $timeout, newArticle)->

      spliter = (text)->
        return if !angular.isString text
        splited = text.split ','
        if splited.length > 1
          for author in splited
            newArticle.addAuthor author if author isnt ''
          $scope.inputText = ''
        else
          []

      $scope.authors = newArticle.getAuthors()

      $scope.AUTHOR_TYPE = newArticle.getAuthorTypes()

      $scope.removeThis = (author)->
        newArticle.removeAuthor author

      $scope.$watch 'inputText', (newText)->
        spliter newText
      , true

      # Initial new article
      newArticle.initialAuthor()
      newArticle.addSelfToAuthor()