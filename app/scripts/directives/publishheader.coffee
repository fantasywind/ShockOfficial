'use strict'

angular.module('shockApp')
  .directive('publishHeader', ['$location', ($location) ->
    templateUrl: '/partials/publishHeader.html'
    restrict: 'E'
    link: ($scope, elem, attrs)->

      $scope.moveTo = (target)->
        $location.path target

      $scope.page = attrs.page
      $scope.navs = [{
        name: 'Dashboard'
        src: '/publish'
      },{
        name: '文章'
        src: '/publish/article'
        children: [{
          name: '新增文章'
          src: '/publish/article/new'
        },{
          name: '我的文章'
          src: '/publish/article/me'
        }]
      }]
  ])
