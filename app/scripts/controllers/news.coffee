'use strict'

angular.module('shockApp')
  .controller 'NewsCtrl', ($scope, Navigation) ->
    Navigation.page = 'news'
    return