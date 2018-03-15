var express = require('express');
var router = express.Router();
var jwt = require('jwt-simple');

/* GET auth listing. */
router.get('/', function(req, res, next) {
  res.send('respond auth with a resource');
});

router.post('/login', function(req, res, next){
  var playload = {'name':'fooke'};
  var secret = 'xZa1234tyubjh';
  var token = jwt.encode(playload, secret);
  console.log('token:',token);
  var decoded = jwt.decode(token, secret);
  console.log('decoded:',decoded);
  res.send('come from auth/login response');
});

router.get('/logout', function(req, res, next){
  res.send('come from auth/logout response');
});
module.exports = router;