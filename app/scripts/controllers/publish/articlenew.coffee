'use strict'

angular.module('shockApp')
  .controller 'PublishArticlenewCtrl', ($scope, $http, newArticle)->
    $scope.isInterview = true

    $scope.categories = []

    $scope.$watch 'isInterview', (newStatus)->
      newArticle.setIsInterview newStatus

    # Fetch Article Category
    reqCategory = $http
      method: 'GET'
      url: '/api/article/category'
      cache: true

    reqCategory.success (categories)->
      $scope.categories = categories
      console.log categories