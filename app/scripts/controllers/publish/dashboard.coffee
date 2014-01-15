'use strict'

angular.module('shockApp')
  .controller 'PublishDashboardCtrl', ($scope, $http, $location, Publishlogin) ->

    console.log 'login check'
    Publishlogin.loginedDo ->
      if Publishlogin.status is Publishlogin.LOGINSTATUS.UNLOGIN
        return $location.path '/'

      console.log 'hahaha logined'