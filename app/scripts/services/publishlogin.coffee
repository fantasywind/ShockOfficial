'use strict'

angular.module('shockApp')
  .service 'Publishlogin', ($http, $location, $cookieStore, $cookies, errorAuthenticate) ->
    # AngularJS will instantiate a singleton by calling "new" on this function

    @LOGINSTATUS = 
      LOGINED: 'logined'
      UNLOGIN: 'unlogin'

    @status = @LOGINSTATUS.UNLOGIN
    @shockMember = false
    @name = null
    @uid = null

    # 暫存登入後執行函式
    checked = false
    loginedCallback = []
    cleanLoginDo = ->
      while fn = loginedCallback.shift()
        fn()
      checked = true

    #######################
    # LoginDo 登入後執行函式#
    #######################

    @loginedDo = ->
      if checked
        fn() for fn in arguments
      else
        loginedCallback.push fn for fn in arguments

    @logout = ->
      conn = $http
        url: '/api/logout'
        method: 'POST'

      conn.success (result)=>
        if result.status is 'success'
          @status = @LOGINSTATUS.UNLOGIN
          $location.path '/'

    @doLogin = (options)->
      options ?= {}
      {email, password, success, error} = options

      success ?= ->
      error ?= ->
      if email? and password?
        conn = $http
          url: '/api/login'
          method: 'POST'
          data: 
            email: email
            password: password
      else if $cookies.access_token?
        conn = $http
          url: '/api/login/access_token'
          method: 'POST'
          data: 
            email: 'email'
            password: 'password'
            access_token: $cookies.access_token
      else
        @errorMessage = errorAuthenticate.INVALID_INPUT
        return @loginFailed()

      conn.success (result)=>
        if result.status is 'success'
          @name = result.name or ''
          result.accountType ?= 'guest'
          @shockMember = if result.accountType is 'shock' then true else false
          @uid = result.user_id
          @loginSuccess()
          success()
        else
          error result.code, result.msg
          @loginFailed()

      conn.error (error)=>
        @errorMessage = error
        @loginFailed()

    @errorMessage = ''

    @loginFailed = ->
      @shockMember = false
      $cookieStore.remove 'access_token'
      @status = @LOGINSTATUS.UNLOGIN
      path = $location.path().split('/')
      if path[1] is 'publish'
        $location.path '/login'

    @loginSuccess = ->
      @errorMessage = ''
      @status = @LOGINSTATUS.LOGINED
      cleanLoginDo()

    # Auto Login
    if $cookies.access_token?
      @doLogin()
    else
      path = $location.path().split('/')
      if path[1] is 'publish'
        $location.path '/login'

    return @