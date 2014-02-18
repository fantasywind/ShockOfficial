'use strict'

angular.module('shockApp')
  .controller 'PublishArticleeditCtrl', ($scope, $http, $routeParams, $location)->
    $location.path '/publish/article' if !$routeParams.articleId

    req = $http
      method: 'GET'
      url: "/api/article/edit/#{$routeParams.articleId}"

    req.error (error, status)->
      console.error error.toString()

    req.success (resp)->
      if resp.status
        console.log 'Ready to edit article.'
      else
        console.error "Get edit auth fail."
        $location.path('/publish/article').search
          msg: 'ERROR_EDIT_ARTICLE'
          type: 'error'