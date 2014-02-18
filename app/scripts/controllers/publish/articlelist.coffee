'use strict'

angular.module('shockApp')
  .controller 'PublishArticlelistCtrl', ($scope, $http, $routeParams, $location, Publishlogin) ->

    Publishlogin.loginedDo ->
      $scope.userID = Publishlogin.uid

    page = parseInt $routeParams.p or 1, 10
    $scope.articles = []

    listReq = $http
      method: 'GET'
      url: '/api/article'
      data:
        page: page

    listReq.error (data, status, headers, config)->
      console.error "Get List Error: #{status.toString()}"

    listReq.success (resp)->
      if resp.status
        article.dateStr = new XDate(article.create_date).toString('yyyy-MM-dd (HH 時)') for article in resp.articles
        $scope.articles = $scope.articles.concat resp.articles
      else
        console.error "Get List Failed: #{resp.msg}"