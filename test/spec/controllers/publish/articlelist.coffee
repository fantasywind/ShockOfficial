'use strict'

describe 'Controller: PublishArticlelistCtrl', () ->

  # load the controller's module
  beforeEach module 'shockApp'

  PublishArticlelistCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    PublishArticlelistCtrl = $controller 'PublishArticlelistCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
