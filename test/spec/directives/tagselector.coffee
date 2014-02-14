'use strict'

describe 'Directive: tagSelector', () ->

  # load the directive's module
  beforeEach module 'shockApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<tag-selector></tag-selector>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the tagSelector directive'
