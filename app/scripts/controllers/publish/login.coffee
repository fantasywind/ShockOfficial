'use strict'

angular.module('shockApp')
  .controller 'PublishLoginCtrl', ($scope, $http, $location, Publishlogin, errorAuthenticate, $translate) ->

    $scope.$watch ->
      Publishlogin.status
    , (now, previus)->
      if now is Publishlogin.LOGINSTATUS.LOGINED
        $location.path '/publish'

    $scope.errorMsg = null

    $scope.login = ->
      if $scope.publishLogin.$valid
        $scope.errorMsg = null
        Publishlogin.doLogin
          email: $scope.email
          password: $scope.password
          success: ->
            console.log 'Login Success'
          error: (code, message)->
            switch message
              when errorAuthenticate.NOT_FOUND
                $scope.errorMsg = $translate 'LOGIN_NOT_FOUND'
              when errorAuthenticate.WRONG_PASSWORD
                $scope.errorMsg = $translate 'LOGIN_PASSWORD_FAILED'
              when errorAuthenticate.INVALID_INPUT
                $scope.errorMsg = $translate 'LOGIN_EMPTY_FIELD'
              else
                $scope.errorMsg = $translate 'SYSTEM_FAILED'

