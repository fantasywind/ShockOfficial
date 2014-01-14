'use strict'

angular.module('shockApp')
  .service 'Publishlogin', ($http, $cookies) ->
    # AngularJS will instantiate a singleton by calling "new" on this function

    @LOGINSTATUS = 
      LOGINED: 'logined'
      UNLOGIN: 'unlogin'

    @status = @LOGINSTATUS.UNLOGIN
    @name = null
    @email = localStorage.email or $cookies.email
    @hashedPassword = localStorage.hashedPassword or $cookies.hashedPassword

    @doLogin = (options)->
      options ?= {}
      {email, password, success, error} = options

      success ?= ->
      error ?= ->
      email ?= @email
      mode = 'plain'

      if !password?
        password = @hashedPassword
        mode = 'hashed'

      conn = $http
        url: '/api/publish/login'
        method: 'POST'
        data: 
          email: email
          password: password
          mode: mode

      conn.success (result)=>
        if result.status is 'success'
          @email = result.member.email
          @hashedPassword = $cookies.hashedPassword
          @name = result.member.name
          @loginSuccess()
          success()
        else
          error result.code, result.msg

      conn.error (error)->
        @errorMessage = error
        error()


    @errorMessage = ''

    @loginError = ->
      localStorage.removeItem 'email'
      localStorage.removeItem 'hashedPassword'
      @email = undefined
      @hashedPassword = undefined
      @status = @LOGINSTATUS.UNLOGIN

    @loginSuccess = ->
      @errorMessage = ''
      localStorage.email = @email
      localStorage.hashedPassword = @hashedPassword
      @status = @LOGINSTATUS.LOGINED

    # Auto Login
    if @status is @LOGINSTATUS.UNLOGIN and @email? and @hashedPassword?
      @doLogin()

    return @