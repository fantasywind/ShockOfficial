'use strict'

angular.module('shockApp')
  .controller 'PublishArticlenewCtrl', ($scope, $http) ->
    $http.get('/api/awesomeThings').success (awesomeThings) ->
      $scope.awesomeThings = awesomeThings