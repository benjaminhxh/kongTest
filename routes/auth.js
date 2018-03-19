var express = require('express');
var router = express.Router();
var jwt = require('jwt-simple');
var secret = 't4rGKecds7gZtrZRRxWpHPD8q09ElXNa';

/* GET auth listing. */
router.get('/', function(req, res, next) {
  res.send('respond auth with a resource');
});

router.post('/login', function(req, res, next){
  var uname = req.body.username;
  var pwd = req.body.password;
  console.log('uname:%s ,pwd:%s',uname,pwd);
  if(!uname||!pwd){
    res.json({
      resultcode:-1,
      errorcode:'username or password cannot be null',
      error:'用户名或密码不能为空'
    });
    return;
  }
  //TODO 数据库查询用户名密码

  //jwt
  var playload = {'name':uname};
  var token = jwt.encode(playload, secret);
  console.log('token:',token);
  var decoded = jwt.decode(token, secret);
  console.log('decoded:',decoded);
  req.header.token = token;
  res.json({
    resultcode:0,
    data:{
      token:token,
      username:uname
    }
  });
  // res.send('come from auth/login response');
});

router.get('/logout', function(req, res, next){
  res.send('come from auth/logout response');
});
module.exports = router;