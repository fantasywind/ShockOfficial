'use strict'

angular.module('shockApp')
  .controller 'PublishLoginCtrl', ($scope, $http) ->
    $scope.login = ->
      if $scope.publishLogin.$valid
        conn = $http
          url: '/api/publish/login'
          method: 'POST'
          data: 
            email: $scope.email
            password: $scope.password
        conn.success (result)->
          console.dir result