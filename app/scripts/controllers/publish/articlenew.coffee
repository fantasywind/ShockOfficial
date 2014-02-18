'use strict'

angular.module('shockApp')
  .controller 'PublishArticlenewCtrl', ($scope, $http, $timeout, $location, newArticle, errorMessage)->
    $scope.isInterview = true
    $scope.errorMessage = false
    $scope.successPost = false
    $scope.categories = []

    _submitting = false

    # Watch title, category and content
    $scope.$watch 'title', (newVal)->
      newArticle.setTitle newVal
    $scope.$watch 'category', (newVal)->
      newArticle.setCategory newVal
    $scope.$watch 'mainContent', (newVal)->
      newArticle.setContent newVal

    $scope.$watch 'isInterview', (newStatus)->
      newArticle.setIsInterview newStatus

    # Fetch Article Category
    reqCategory = $http
      method: 'GET'
      url: '/api/article/category'
      cache: true

    reqCategory.success (categories)->
      $scope.categories.push c for c in categories
      $scope.category = categories[0]._id if !!categories.length

    # Error Message
    newArticle.whenError (code, msg)->
      _submitting = false
      $scope.errorMessage = errorMessage.getMessage code

    newArticle.whenSuccess ->
      $scope.successPost = true
      $timeout ->
        $location.path('/publish/article').search
          msg: 'SUCCESS_ADD_ARTICLE'
          type: 'success'
      , 800

    # Submit
    $scope.submit = ->
      return false if _submitting
      _submitting = true
      $scope.successPost = false
      newArticle.submit()