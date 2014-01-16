'use strict'

angular.module('shockApp')
  .controller 'PublishArticlenewCtrl', ($scope, $http, newArticle)->
    $scope.isInterview = true

    $scope.$watch 'isInterview', (newStatus)->
      newArticle.setIsInterview newStatus