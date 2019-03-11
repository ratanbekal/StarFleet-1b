var express = require('express');
var app = express();
app.get('/', function (req, res) {
  res.send('Hello World! from NodeJS App - Build 1.0.0.30');
});
app.listen(3000, function () {
  console.log('Example app listening on port 3000!');
});