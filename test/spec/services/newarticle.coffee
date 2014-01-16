'use strict'

describe 'Service: newArticle', () ->

  # load the service's module
  beforeEach module 'shockApp'

  # instantiate service
  newArticle = {}
  beforeEach inject (_newArticle_) ->
    newArticle = _newArticle_

  it 'should do something', () ->
    expect(!!newArticle).toBe true
