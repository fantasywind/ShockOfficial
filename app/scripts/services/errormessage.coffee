'use strict'

angular.module('shockApp')
  .provider 'errorMessage', ->

    @$get = ->
      return {
        getMessage: (errorCode)->
          errorCode = 0 if !angular.isNumber parseInt(errorCode, 10)
          
          switch
            when 0
              "ERROR_SYSTEM_FAULT"
            when 1
              "ERROR_INVALID_PARAMETER"
            when 2
              "ERROR_DATABASE"
            when 100
              "ERROR_NOT_FOUND"
            when 200
              "ERROR_PASSWORD"
            else
              "ERROR_SYSTEM_FAULT"
      }

    return @