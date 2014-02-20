'use strict'

angular.module('shockApp')
  .controller 'PublishArticlenewCtrl', ($scope, $http, $timeout, $routeParams, $location, newArticle, errorMessage)->
    $scope.isInterview = true
    $scope.errorMessage = false
    $scope.successPost = false
    $scope.categories = []
    $scope.articleCategory = null

    _submitting = false

    # Mode
    $scope.editorMode = $routeParams.mode
    $scope.editArticleId = $routeParams.articleId

    $scope.mainContent = '<p></p>'
    _editor = null

    switch $routeParams.mode
      when 'edit'
        $scope.modeTitle = 'EDIT_ARTICLE'
      else
        $scope.modeTitle = "ADD_ARTICLE"

    if $scope.editorMode is 'edit'
      $location.path '/publish/article' if !$routeParams.articleId

      req = $http
        method: 'GET'
        url: "/api/article/edit/#{$routeParams.articleId}"

      req.error (error, status)->
        console.error error.toString()

      req.success (resp)->
        if resp.status
          console.log 'Ready to edit article.'
          $scope.title = resp.article.title
          if $scope.categories.length
            # Direct select category
            $scope.category = resp.article.category
          else
            # Cache for waiting categories loaded
            $scope.articleCategory = resp.article.category
          $scope.mainContent = resp.article.content
          console.log resp.article.content
        else
          console.error "Get edit auth fail."
          $location.path('/publish/article').search
            msg: 'ERROR_EDIT_ARTICLE'
            type: 'danger'

    # Watch title, category and content
    $scope.$watch 'title', (newVal)->
      newArticle.setTitle newVal
    $scope.$watch 'category', (newVal)->
      newArticle.setCategory newVal
    $scope.$watch 'mainContent', (newVal)->
      _editor = angular.element 'div.editor-content' if _editor is null or _editor.length is 0
      newArticle.setContent _editor.html()

    $scope.$watch 'isInterview', (newStatus)->
      newArticle.setIsInterview newStatus

    # Fetch Article Category
    reqCategory = $http
      method: 'GET'
      url: '/api/article/category'
      cache: true

    reqCategory.success (categories)->
      $scope.categories.push c for c in categories
      if !!categories.length 
        $scope.category = if !$scope.articleCategory then categories[0]._id else $scope.articleCategory

    # Error Message
    newArticle.whenError (code, msg)->
      _submitting = false
      $scope.errorMessage = errorMessage.getMessage code

    newArticle.whenSuccess ->
      $scope.successPost = true
      $timeout ->
        $location.path('/publish/article').search
          msg: 'SUCCESS_ADD_ARTICLE'
          type: 'success'
      , 800

    # Submit
    $scope.submit = ->
      return false if _submitting

      # Refresh main content
      _editor = angular.element 'div.editor-content' if _editor is null or _editor.length is 0
      newArticle.setContent _editor.html()

      _submitting = true
      $scope.successPost = false
      newArticle.submit()