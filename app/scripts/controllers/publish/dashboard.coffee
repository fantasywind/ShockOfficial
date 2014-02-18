'use strict'

angular.module('shockApp')
  .controller 'PublishDashboardCtrl', ($scope, $http, $location, Publishlogin, $translate) ->

    Publishlogin.loginedDo ->
      console.log 'logined'