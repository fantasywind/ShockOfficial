'use strict'

angular.module('shockApp')
  .controller 'PublishArticlenewCtrl', ($scope, $http, newArticle)->
    $scope.isInterview = true

    $scope.categories = []

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

    # Submit
    $scope.submit = ->
      newArticle.submit()