'use strict'

describe 'Service: Publishlogin', () ->

  # load the service's module
  beforeEach module 'shockApp'

  # instantiate service
  Publishlogin = {}
  beforeEach inject (_Publishlogin_) ->
    Publishlogin = _Publishlogin_

  it 'should do something', () ->
    expect(!!Publishlogin).toBe true
