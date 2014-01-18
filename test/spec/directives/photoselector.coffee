'use strict'

describe 'Directive: photoSelector', () ->

  # load the directive's module
  beforeEach module 'shockApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<photo-selector></photo-selector>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the photoSelector directive'
