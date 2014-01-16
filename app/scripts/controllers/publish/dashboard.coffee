'use strict'

angular.module('shockApp')
  .controller 'PublishDashboardCtrl', ($scope, $http, $location, Publishlogin, $translate) ->

    console.log $translate 'PUBLISH_HEADER_DASHBOARD'

    Publishlogin.loginedDo ->
      console.log 'hahaha logined'