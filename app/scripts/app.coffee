'use strict'

angular.module('shockApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute'
])
  .config ($routeProvider, $locationProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'partials/main.html'
        controller: 'MainCtrl'
      .when '/news',
        templateUrl: 'partials/news.html'
        controller: 'NewsCtrl'
      .otherwise
        redirectTo: '/'
    $locationProvider.html5Mode(true)
