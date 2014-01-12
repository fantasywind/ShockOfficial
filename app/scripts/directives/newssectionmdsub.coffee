'use strict'

angular.module('shockApp')
  .directive('newsSectionMdSub', () ->
    template: '<h1>{{article.title}}<br />{{article.subtitle}}</h1><p>{{article.summerize}}</p>'
    restrict: 'E'
    scope:
      article: '='
  )
