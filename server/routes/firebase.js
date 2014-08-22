
var FIREBASE_SECRET = 'iR8xBCJ7HdmnK3KGGyXdm9dOSsTkxoqs11WvbkHY';

var FirebaseTokenGenerator = require('firebase-token-generator'),
    tokenGenerator = new FirebaseTokenGenerator(FIREBASE_SECRET);

var express = require('express');
var router = express.Router();

/* GET firebase token */
router.get('/token', function(req, res) {
  var token = tokenGenerator.createToken({'hackdayOne': true});
  res.send({token: token});
});

module.exports = router;


