'use strict'

angular.module('shockApp')
  .controller 'HeaderCtrl', ($scope, Navigation) ->
    $scope.navList = Navigation.pageList

    $scope.$watch ->
      Navigation.page
    , (newPage)->
      $scope.nowPage = newPage