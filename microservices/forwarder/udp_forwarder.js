/*
    UDP 

    Collects udp stream data from udp site

*/

// testing connection to redis proxy and cluster setup
// docker.local:22121
var Redis = require('ioredis');

var cluster = new Redis.Cluster([
    {
    	host: 'localhost',
        port: 6379,
        password: null
    }
    // {
    // 	host: 'localhost',
    //     port: 6380,
    //     password: null
    // }
], {
    redisOptions: {
        family: 4,
        //password: 'fallback-password',
        db: 0
    }
});

cluster.set('cluster', 'test');

cluster.get('cluster', function (err, res) {
    console.log(`err: ${err}`)
    console.log(`red: ${res}`)
});

cluster.on('error',function(err){
    console.log("REDIS CONNECT error "+ err);
    console.log('node error', err.lastNodeError);
});

// basic client to redis sentinel works

// var redis = new Redis({
//   port: 6379,          // Redis port 
//   host: '127.0.0.1',   // Redis host 
//   family: 4,           // 4 (IPv4) or 6 (IPv6) 
//   //password: 'auth',
//   db: 0
// });

// redis.set('simple','test');


const dgram = require('dgram');
const server = dgram.createSocket('udp4');

server.on('error', (err) => {
    console.log(`server error:\n${err.stack}`);
    server.close();
});


server.on('message', (msg, rinfo) => {



    //console.log(`server got: ${msg} from ${rinfo.address}:${rinfo.port}`);

    // const client = dgram.createSocket('udp4');
    // send to localhost, vm is forwaded to splunk container
    // client.send(msg, 9761, '192.168.99.100', (err) => {
    // 	if (!err) {
    // 		console.log(`sent to container: ${msg}`);
    // 	}
    // 	client.close();
    // });
});

server.on('listening', () => {
    var address = server.address();
    console.log(`dockerland-forwarder listening ${address.address}:${address.port}`);
});

server.bind(9762);
