'use strict';

// Module dependencies.
var express = require('express'),  
    path = require('path'),
    fs = require('fs'),
    passport = require('passport');

var app = express();

// Connect to database
var db = require('./lib/db/mongo');

// Bootstrap models
var modelsPath = path.join(__dirname, 'lib/models');
fs.readdirSync(modelsPath).forEach(function (file) {
  require(modelsPath + '/' + file);
});

// Import Passport Setting
require('./lib/config/passport')(passport);

// Populate empty DB with dummy data
// require('./lib/db/dummydata');


// Express Configuration
require('./lib/config/express')(app);

// Controllers
var api = require('./lib/controllers/api'),
    index = require('./lib/controllers');

// Server Routes

// Photo
app.post('/api/photo', api.photo.upload)

// Article
app.get('/api/news', api.article.newsPage);
app.get('/api/article/category', api.article.categories);
app.get('/api/article', api.article.articleList);
app.post('/api/article', api.article.newArticle);
app.get('/api/article/edit/:articleId', api.article.editArticle)

// Member
app.get('/api/member/type/:memberName', api.member.typeCheck);

// Sign Up / Sign In
app.get('/api/signup/failed', api.member.signupFailed);
app.get('/api/signup/success', api.member.signupSuccess);
app.get('/api/login/failed', api.member.loginFailed);
app.get('/api/login/success', api.member.loginSuccess);
app.post('/api/logout', api.member.logout);

// Passport
app.post('/api/signup', passport.authenticate('local-signup', {
  successRedirect: '/api/signup/success',
  failureRedirect: '/api/signup/failed',
  failureFlash: true
}));

app.post('/api/login', passport.authenticate('local-login', {
  successRedirect: '/api/login/success',
  failureRedirect: '/api/login/failed',
  failureFlash: true
}));

app.post('/api/login/access_token', passport.authenticate('local-login-access-token', {
  successRedirect: '/api/login/success',
  failureRedirect: '/api/login/failed',
  failureFlash: true
}));

// Angular Routes
app.get('/partials/*', index.partials);
app.get('/*', index.index);

// Start server
var port = process.env.PORT || 3000;
app.listen(port, function () {
  console.log('Express server listening on port %d in %s mode', port, app.get('env'));
});

// Expose app
exports = module.exports = app;