'use strict'

angular.module('shockApp')
  .directive('newsSectionMd', () ->
    #template: '<h1>{{articles}}<br>三峽鳶山公共托育中心</h1><p>三峽鳶山公共托育中心，終於正式成立，雖然等到第二十五間才來到三峽，但是公共托育服務的進駐，對於三峽來說一定是地區社會福利的一大佳音...</p'
    template: '<news-section-md-sub class="news-section" ng-repeat="article in articles" article="article"></news-section-md-sub>'
    restrict: 'E'
    scope:
      articles: '='
  )
