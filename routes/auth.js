var express = require('express');
var router = express.Router();

/* GET auth listing. */
router.get('/', function(req, res, next) {
  res.send('respond auth with a resource');
});

router.post('/login', function(req, res, next){
  res.send('come from auth/login response');
});

router.get('/logout', function(req, res, next){
  res.send('come from auth/logout response');
});
module.exports = router;