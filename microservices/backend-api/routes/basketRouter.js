const express = require('express');
const request = require('request').defaults({ json: true });
const redis = require('redis').createClient(6379, 'redis-backend-api-1');

// web api
// this url and port depends on third party ip address

const address = {
  LOOPBACK: 'http://169.254.77.155:80/b',
  WIRELESS: 'http://169.254.149.228:80/b',
  NIC: 'http://192.168.1.5:80/b'
}

const url = address.LOOPBACK;


var routes = function(basket) {

  var router = express.Router();

  // for basic operations
  // have new identifiers of posts and retrieve top
  // or replace document entirely

  // common routing behavior
  // 1. url (specific to route)

  // universal
  // 2. lookup: findByID()
  // 3. status code and callback
  // 4. version and write to db

  // 1. this api frequently makes 1:1 requests on the third party API and stores json responses in mongo
  // 2. requests on this API get data from the cache using redis
  // 3. if a cached request gets invalidated, then a new request is made

  // checkKeys is not having an effect on BSON serializer
  // NOTE-MAK. manually editing serializer.js for test
  // usr/src/app/node_modules/bson/lib/bson/parser/serializer.js

  // TODO-MAK: get redis.

  router.route('/basket/:basketName')

  // Get a basket
  .get(function(req, res) {

    // console.log(req.body);
    // console.log(req.params);
    // console.log(req.query);

    // basic filter on name property
    var query = {};
    if (req.query.name) {
      query.name = req.query.name;
    }

    const key = url + '/basket/' + req.params.basketName;
    console.log(`key: ${key}`);

    redis.get(key, function(err, basket) {
      if (err) {
        console.error(err);
      };

      setTimeout(function() {
        console.log('timing out for 5 seconds');
      }, 5000);

      if (basket) {
      	console.log('HIT');
        res.send(JSON.parse(basketName));
      } else {
      	console.log("MISS");
        request({ uri: key }, function(error, response, body) {

          if (error) {
            res.status(response.statusCode);
          };

          if (response.statusCode === 200) {
          	res.send(body);
            redis.setex(key, 1, JSON.stringify(body), function(error) {
              if (error) { throw error; };
            });
          } else {
            res.status(response.statusCode);
          }
        });
      }
    });


    // TODO-MAK: mongodb lookup called separately to feed the cache

	/*
    basket.findById(key, function(err, proj) {

      if (err) {

        console.log('MISS');
        // call api
        request({ uri: key }, function(error, response, body) {

          if (error) {
            res.status(response.statusCode);
            // callback({service: 'someService', error: error});
            return;
          };

          const statusCode = response.statusCode;
          console.log(`api returned ${statusCode}`);

          if (response.statusCode === 200) {

            res.send(body);
            //callback(null, body);

            // using a new instance with data field
            m = new basket;
            // m.formatVersionnumber = '1.0.0';

            console.log('saving json');
            m.collection.insert(body, function(err, res) {
              if (err) {
                return console.error(err);
              }
              console.log('saved!');
            });



            //          console.log('saving json. check keys false.');
            // var Db = require('mongodb').Db;
            // var Server = require('mongodb').Server;
            // var db = new Db('protocolB', new Server('172.23.3.1', 27017));

            // var assert = require('assert');
            //          db.open(function(err, db) {
            //            // Fetch a collection to insert document into
            //            var collection = db.collection("Baskets");


            //            var data = JSON.parse(JSON.stringify(body));
            //            collection.insert(data, {w: 1, checkKeys: false}, function(err, result) {
            //              //assert.deepStrictEqual(data, result);
            //              setTimeout(function() {
            //                db.close();
            //              }, 1000);
            //            });
            //          });
          } else {
            res.status(response.statusCode);
            //callback(response.statusCode);
          }
        });
      } else {
        console.log('HIT');
        res.json(proj);
      }
    });
    */
  })

// {
// 	"state": "occupied pirIdle zoneActive",
// 	"version": "0.0.1"
// }

  // Create a basket
  .put(function(req, res) {
    const key = url + req.params.basketName;
    console.log(`key: ${key}`);

    // validate json payload.
    basket.validate(function(error) {
      if (err) {
        res.sendStatus(400); // Bad Request
        return console.error(err);
      }
    });

    // check the database
    basket.findById(key, function(err, proj) {

      if (err) {

        console.log('MISS');

        // call api
        request({ uri: key }, function(error, response, body) {

          m = new basket;
          console.log('saving json');
          m.collection.insert(body, function(err, res) {
            if (err) {
              res.sendStatus(501); // Not Implemented
              return console.error(err);
            }
            res.sendStatus(200);
            console.log('saved!');
            m.close();
          });
        });
      }
    });
  });

};

// universal
// 2. lookup: findByID()
// 3. status code and callback
// 4. version and write to db

module.exports = routes;
