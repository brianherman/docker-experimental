console.log('testing..');
//Lets require/import the HTTP module
var http = require('http');

//Lets define a port we want to listen to
const PORT=8080; 

//We need a function which handles requests and send response
function handleRequest(request, response){

	// forward the request
	http.get('http://docker.local:8080', (res) => {
		console.log(`Got response: ${res.statusCode}`);

		response.end('whatever. data blah.');

		// consume response body
		res.resume();
	}).on('error', (e) => {
		console.log(`Got error: ${e.message}`);
	});
}

//Create a server
var server = http.createServer(handleRequest);

//Lets start our server
server.listen(PORT, function(){
    //Callback triggered when server is successfully listening. Hurray!
    console.log("Server listening on: http://localhost:%s", PORT);
});

