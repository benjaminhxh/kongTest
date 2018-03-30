var express = require('express');
var router = express.Router();
var jwt = require('jwt-simple');
var secret = 't4rGKecds7gZtrZRRxWpHPD8q09ElXNa';// jwt插件创建consumer分配的key和secret
var key = 'CgM4qgM3wLyBlFsiAI4jOU4Dh2TcTCGr';

router.post('/login', function(req, res, next){
  var uname = req.body.username;
  var pwd = req.body.password;
  console.log('uname:%s ,pwd:%s',uname,pwd);
  //判空
  if(!uname||!pwd){
    res.json({
      resultcode:-1,
      errorcode:'username or password cannot be null',
      error:'用户名或密码不能为空'
    });
    return;
  }
  //TODO 数据库查询用户名密码

  //生成jwt，返回
  var payload = {'iss':key};
  var token = jwt.encode(payload, secret);
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
});

router.get('/logout', function(req, res, next){
  res.send('come from auth/logout response');
});
module.exports = router;