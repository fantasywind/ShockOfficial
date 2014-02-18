'use strict'

angular.module('shockApp')
  .directive('publishHeader', ['$location', 'Publishlogin', 'Navigation', ($location, Publishlogin, Navigation) ->
    templateUrl: '/partials/publishHeader.html'
    restrict: 'E'
    link: ($scope, elem, attrs)->

      # 檢查權限
      Publishlogin.loginedDo ->
        if !Publishlogin.shockMember
          return $location.path '/'
        else
          Navigation.page = ''

      $scope.moveTo = (target)->
        $location.path target

      $scope.page = attrs.page
      $scope.navs = [{
        name: 'PUBLISH_HEADER_DASHBOARD'
        src: '/publish'
      },{
        name: 'PUBLISH_HEADER_ARTICLE'
        src: '/publish/article'
        children: [{
          name: 'PUBLISH_HEADER_ARTICLE_NEW'
          src: '/publish/article/new'
        },{
          name: 'PUBLISH_HEADER_ARTICLE_LIST'
          src: '/publish/article'
        }]
      },{
        name: 'PUBLISH_HEADER_DISCUSS'
        src: '/publish/discuss'
      },{
        name: 'PUBLISH_HEADER_MARKETING'
        src: '/publish/marketing'
      },{
        name: 'PUBLISH_HEADER_MEMBER'
        src: '/publish/member'
      }]
  ])
