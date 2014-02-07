'use strict'

describe 'Service: Uploadphoto', () ->

  # load the service's module
  beforeEach module 'shockApp'

  # instantiate service
  Uploadphoto = {}
  beforeEach inject (_Uploadphoto_) ->
    Uploadphoto = _Uploadphoto_

  it 'should do something', () ->
    expect(!!Uploadphoto).toBe true
