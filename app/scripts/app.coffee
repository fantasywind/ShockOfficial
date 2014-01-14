'use strict'

angular.module('shockApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute'
])
  .config ($routeProvider, $locationProvider, $httpProvider) ->
    # Set Http Provider Like jQuery
    $httpProvider.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded;charset=utf-8'
    $httpProvider.defaults.transformRequest = [ (data)->
      param = (obj)->
        query = ''
        for name, value of obj
          if value instanceof Array
            for subValue in [0...value.length]
              fullSubName = name + '[' + _i + ']'
              innerObj = {}
              innerObj[fullSubName] = subValue
              query += param(innerObj) + '&'
          else if value instanceof Object
            for subName, subValue of value
              fullSubName = name + '[' + subName + ']'
              innerObj = {}
              innerObj[fullSubName] = subValue
              query += param(innerObj) + '&'
          else if value isnt null and value isnt undefined
            query += encodeURIComponent(name) + '=' + encodeURIComponent(value) + '&'

        returnVal = if query.length then query.substr(0, query.length - 1) else query
        return returnVal
      returnVal = if angular.isObject(data) and String(data) isnt '[object File]' then param data else data
      return returnVal
    ]

    # Set Route
    $routeProvider
      .when '/news',
        templateUrl: 'partials/news.html'
        controller: 'NewsCtrl'
      .when '/publish',
        templateUrl: 'partials/publishdashboard.html'
        controller: 'PublishDashboardCtrl'
      .when '/publish/login',
        templateUrl: 'partials/login.html'
        controller: 'PublishLoginCtrl'
      .otherwise
        redirectTo: '/news'
    $locationProvider.html5Mode(true)