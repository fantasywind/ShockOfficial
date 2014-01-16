'use strict'

angular.module('shockApp')
  .controller 'PublishDashboardCtrl', ($scope, $http, $location, Publishlogin) ->

    Publishlogin.loginedDo ->
      console.log 'hahaha logined'