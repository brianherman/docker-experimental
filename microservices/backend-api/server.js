// This service calls an external API and dumps the data to a mongodb
// Also using a local mongodb for test data that mocks the api

var express = require('express');
var app = express();
var bodyParser = require('body-parser');
var mongoose = require('mongoose');

var port = process.env.PORT || 8080;

//var db = mongoose.connect('mongodb://docker.local/v1');
var db = mongoose.connect('mongodb://172.23.3.1/v1');

app.get('/', function(req, res){
    res.send('Here are the example docs');
});

var project = 		require('./models/basketModel');

var basketRouter = require('./routes/basketRouter')(basket);


app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

app.use('/b', basketRouter);

app.listen(port, function() {
	console.log(`Listening on port ${port}`);
});