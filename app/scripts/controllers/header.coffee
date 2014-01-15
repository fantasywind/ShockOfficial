'use strict'

angular.module('shockApp')
  .controller 'HeaderCtrl', ($scope, $location, Navigation, Publishlogin) ->
    $scope.navList = Navigation.pageList
    $scope.submenu = false

    $scope.login = ->
      $scope.submenu = false
      $location.path '/login'

    $scope.logout = ->
      $scope.submenu = false
      Publishlogin.logout()

    $scope.$watch ->
      Navigation.page
    , (newPage)->
      $scope.nowPage = newPage
      return

    $scope.$watch ->
      Publishlogin.status
    , (newStatus)->
      $scope.logined = newStatus