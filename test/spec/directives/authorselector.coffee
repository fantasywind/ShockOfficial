'use strict'

describe 'Directive: authorSelector', () ->

  # load the directive's module
  beforeEach module 'shockApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<author-selector></author-selector>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the authorSelector directive'
