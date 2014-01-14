'use strict'

angular.module('shockApp')
  .directive('newsSectionMd', () ->
    template: '<news-section-md-sub class="news-section" ng-repeat="article in articles" article="article"></news-section-md-sub>'
    restrict: 'E'
    scope:
      articles: '='
  )
