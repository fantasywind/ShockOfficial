'use strict'

angular.module('shockApp')
  .controller 'PublishLoginCtrl', ($scope, $http, $location, Publishlogin) ->

    $scope.$watch ->
      Publishlogin.status
    , (now, previus)->
      if now is Publishlogin.LOGINSTATUS.LOGINED
        $location.path '/publish'

    $scope.login = ->
      if $scope.publishLogin.$valid
        Publishlogin.doLogin
          success: ->
            console.log 'Login Success'