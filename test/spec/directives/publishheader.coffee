'use strict'

describe 'Directive: publishHeader', () ->

  # load the directive's module
  beforeEach module 'shockApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<publish-header></publish-header>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the publishHeader directive'
