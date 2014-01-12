'use strict'

describe 'Directive: newsSectionMdSub', () ->

  # load the directive's module
  beforeEach module 'shockApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<news-section-md-sub></news-section-md-sub>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the newsSectionMdSub directive'
