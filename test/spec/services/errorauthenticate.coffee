'use strict'

describe 'Service: errorAuthenticate', () ->

  # load the service's module
  beforeEach module 'shockApp'

  # instantiate service
  errorAuthenticate = {}
  beforeEach inject (_errorAuthenticate_) ->
    errorAuthenticate = _errorAuthenticate_

  it 'should do something', () ->
    expect(!!errorAuthenticate).toBe true
