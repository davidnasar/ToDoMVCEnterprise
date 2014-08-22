var express         = require('express');
var path            = require('path');
var favicon         = require('static-favicon');
var logger          = require('morgan');
var cookieParser    = require('cookie-parser');
var bodyParser      = require('body-parser');
var passport        = require('passport');
var GoogleStrategy  = require('passport-google-oauth').OAuth2Strategy;


var routes          = require('./routes/index');
var users           = require('./routes/users');

var app             = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

app.use(favicon());
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded());
app.use(cookieParser());
app.use(passport.initialize());
app.use(express.static(path.join(__dirname, '..', 'client')));



/* 
 {"web":{
    "auth_uri":                     "https://accounts.google.com/o/oauth2/auth",
    "client_secret":                "sDmFUgAzUx6srCNgEc6N1_CK",
    "token_uri":                    "https://accounts.google.com/o/oauth2/token",
    "client_email":                 "621475068728-hj8v7i58buo567i440gg1t512m23bkjc@developer.gserviceaccount.com",
    "redirect_uris":                ["http://todomvc.fusionalliance.com:3000/auth/google/return"],
    "client_x509_cert_url":         "https://www.googleapis.com/robot/v1/metadata/x509/621475068728-hj8v7i58buo567i440gg1t512m23bkjc@developer.gserviceaccount.com",
    "client_id":                    "621475068728-hj8v7i58buo567i440gg1t512m23bkjc.apps.googleusercontent.com",
    "auth_provider_x509_cert_url":  "https://www.googleapis.com/oauth2/v1/certs",
    "javascript_origins":           ["http://todomvc.localhost:3000"]
  }}
*/

passport.use(new GoogleStrategy({
    clientID:       "621475068728-hj8v7i58buo567i440gg1t512m23bkjc.apps.googleusercontent.com",
    clientSecret:   "sDmFUgAzUx6srCNgEc6N1_CK",
    callbackURL:    "http://todomvc.fusionalliance.com:3000/auth/google/return",
    scope:          ["email","profile"]
  },
  function(accessToken, refreshToken, profile, done) {
    return done(null,profile);
  }
));

app.use('/users', users);

app.get('/auth/google', passport.authenticate('google'));

app.get('/auth/google/return',
    passport.authenticate('google', {
        session:            false,
        failureRedirect:    '/auth/login' 
    }),
    function(req, res) {
        // req.user is the user as returned by the provider
        console.log(req.user)
    
        res.redirect('/');
 });
  
app.get('/auth/login',function(){
    console.log('this thing failed');
});


/// catch 404 and forward to error handler
app.use(function(req, res, next) {
    var err = new Error('Not Found');
    err.status = 404;
    next(err);
});

/// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
    app.use(function(err, req, res, next) {
        res.status(err.status || 500);
        res.render('error', {
            message: err.message,
            error: err
        });
    });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
        message: err.message,
        error: {}
    });
});

module.exports = app;
