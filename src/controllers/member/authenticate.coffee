exports.signupFailed = (req, res)->
  res.json
    status: 'fail'
    msg: "#{req.flash('signupMessage')}"

exports.signupSuccess = (req, res)->
  res.json
    status: 'success'
    msg: 'Signed up.'

exports.loginFailed = (req, res)->
  res.json
    status: 'fail'
    msg: "#{req.flash('loginMessage')}"

exports.loginSuccess = (req, res)->
  res.cookie 'access_token', req.session.access_token, 
    path: '/'
    expires: new Date(Date.now() + 604800000)

  res.json
    status: 'success'
    msg: 'Logined.'
    name: req.user.name
    accountType: req.user.type
    privileges: req.user.privileges

exports.logout = (req, res)->
  res.clearCookie 'access_token',
    path: '/'

  req.logout()

  res.json
    status: 'success'
    msg: 'Logout.'