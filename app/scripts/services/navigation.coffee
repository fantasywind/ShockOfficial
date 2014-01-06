'use strict'

angular.module('shockApp')
  .service 'Navigation', () ->
    # AngularJS will instantiate a singleton by calling "new" on this function
    @pageList = [
      {
        name: '新聞'
        ns: 'news'
        url: '/news'
      }
      {
        name: '在地景點'
        ns: 'views'
        url: '/views'
      }
    ]

    @page = 'news'

    @