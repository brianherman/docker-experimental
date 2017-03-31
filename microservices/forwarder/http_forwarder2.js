var http = require('http');

var server = http.createServer();

const outsidePort = 8080;
server.listen(outsidePort, function(){
    //Callback triggered when server is successfully listening. Hurray!
    console.log("Server listening on: 0.0.0.0:%s", outsidePort);
});

const baseUrl = 'localhost';
const port = 80;
server.on('request', (req, res) => {
  var connector = http.request({
    host: baseUrl,
    port: port,
    path: req.url,
    method: req.method
  }, (resp) => {
    console.log(res);
    resp.pipe(res);
  });

  req.pipe(connector);
});
