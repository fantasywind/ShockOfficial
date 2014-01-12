'use strict'

angular.module('shockApp')
  .controller 'NewsCtrl', ($scope, Navigation, $http) ->
    Navigation.page = 'news'
    $scope.articles = {}
    $scope.counter =
      sanxia: 0
      yingge: 0
      shulin: 0
      tucheng: 0

    newsReq = $http
      method: 'GET'
      url: '/api/news'

    newsReq.success (data)->
      $scope.articles = data
      return

    return