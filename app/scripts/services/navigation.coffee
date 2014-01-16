'use strict'

angular.module('shockApp')
  .service 'Navigation', ($translate) ->
    # AngularJS will instantiate a singleton by calling "new" on this function

    @pageList = [
      {
        name: 'HEADER_NEWS'
        ns: 'news'
        url: '/news'
      }
      {
        name: 'HEADER_LOCAL_VIEWS'
        ns: 'views'
        url: '/views'
      }
    ]

    @page = 'news'

    @