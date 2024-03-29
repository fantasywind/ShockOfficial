'use strict'

angular.module('shockApp')
  .directive 'authorSelector', ->
    templateUrl: '/partials/authorselector.html'
    restrict: 'E'
    require: 'ngModel'
    controller: ($rootScope, $scope, $timeout, newArticle, $element)->

      # Listener for return
      $input = $element.find('input')

      $input.on 'blur', ->
        spliter @value + ','

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