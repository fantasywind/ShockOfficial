'use strict'

describe 'Directive: newsSectionMd', () ->

  # load the directive's module
  beforeEach module 'shockApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<news-section-md></news-section-md>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the newsSectionMd directive'
