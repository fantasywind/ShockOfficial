'use strict'

describe 'Service: errorMessage', () ->

  # load the service's module
  beforeEach module 'shockApp'

  # instantiate service
  errorMessage = {}
  beforeEach inject (_errorMessage_) ->
    errorMessage = _errorMessage_

  it 'should do something', () ->
    expect(!!errorMessage).toBe true
