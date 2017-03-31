var express = require('express');
var app = express();
var bodyParser = require('body-parser');

var port = process.env.PORT || 8080;

app.get('/', function(req, res){
    res.send('Here are the example docs');
});

var project = require('./models/projectModel');
var dockerlandRouter = require('./routes/dockerlandRoutes')(project);

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(dockerlandRouter); 

app.listen(port, function() {
	console.log(`Listening on port ${port}`);
});