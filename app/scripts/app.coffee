'use strict'

angular.module('shockApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute',
  'pascalprecht.translate',
  'textAngular'
])
  .config(($routeProvider, $locationProvider, $httpProvider, $translateProvider) ->
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

    # Set i18n
    $translateProvider.useStaticFilesLoader
      prefix: '/lang/locale-'
      suffix: '.json'

    $translateProvider.preferredLanguage 'zh-TW'
    $translateProvider.useLocalStorage()

    # Set Route
    $routeProvider
      .when '/news',
        templateUrl: 'partials/news.html'
        controller: 'NewsCtrl'
      .when '/publish',
        templateUrl: 'partials/publishdashboard.html'
        controller: 'PublishDashboardCtrl'
      .when '/publish/article/new',
        templateUrl: 'partials/publisharticlenew.html'
        controller: 'PublishArticlenewCtrl'
      .when '/login',
        templateUrl: 'partials/login.html'
        controller: 'PublishLoginCtrl'
      .otherwise
        redirectTo: '/news'
    $locationProvider.html5Mode(true)
  )
  .run ($rootScope, $document, newArticle)->

    queryFormatBlockState = (command)->
      command = command.toLowerCase()
      val = $document[0].queryCommandValue('formatBlock').toLowerCase()
      val is command or val is command

    # Text Editor
    $rootScope.textAngularTools =
      paragraph:
        display: "<button ng-click='action()' ng-class='displayActiveToolClass(active)'><i class='fa fa-align-justify'></i> 段落</button>"
        action: ->
          @.$parent.wrapSelection 'formatBlock', '<p>'
        activeState: ->
          queryFormatBlockState 'p'
      subtitle:
        display: "<button ng-click='action()' ng-class='displayActiveToolClass(active)'><i class='fa fa-font'></i> 小標</button>"
        action: ->
          @.$parent.wrapSelection 'formatBlock', '<h2>'
        activeState: ->
          queryFormatBlockState 'h2'
      picture:
        display: "<button ng-click='action()' ng-class='displayActiveToolClass(active)'><i class='fa fa-picture-o'></i> 照片</button>"
        action: ->
          @.$parent.wrapSelection 'formatBlock', '<figure>'
          newArticle.showPhotoSelector @
          #newArticle.showModal()
          true
        activeState: ->
          queryFormatBlockState 'figure'
      fit:
        display: "<button ng-click='action()' ng-class='displayActiveToolClass(active)'><i class='fa fa-magic'></i> 自動修正</button>"
        action: ->
          editor = angular.element 'text-angular'
          editor.find('.editor-content p').removeAttr 'style'
          @.$parent.wrapSelection 'formatBlock', '<p>'
        activeState: ->
          false