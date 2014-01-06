'use strict'

describe 'Service: Navigation', () ->

  # load the service's module
  beforeEach module 'shockApp'

  # instantiate service
  Navigation = {}
  beforeEach inject (_Navigation_) ->
    Navigation = _Navigation_

  it 'should do something', () ->
    expect(!!Navigation).toBe true
