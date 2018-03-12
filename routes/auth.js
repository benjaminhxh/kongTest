var express = require('express');
var router = express.Router();

/* GET auth listing. */
router.get('/', function(req, res, next) {
  res.send('respond auth with a resource');
});

module.exports = router;