var express = require('express');
var async = require('async');
var request = require('request').defaults({ json: true });
var redis = require('redis').createClient(6379, 'redis-middle-api-1');

var routes = function(project) {

  var router = express.Router();

  router.route('/project/:projectName')

  .get(function(req, res) {

    // console.log(req.body);
    // console.log(req.params);
    // console.log(req.query);

    async.parallel({

      someService: function(callback) {

        var key = 'http://node-4:8080/b/project/' + req.params.projectName;
        // console.log(`key: ${key}`);

        redis.get(key, function(error, results) {

          if (error) { console.error(error.message); };
          //if (error) { throw error; };

          if (results) {
            console.log('HIT');
            callback(null, JSON.parse(results));            
          } else {
            console.log("MISS");
            request({ uri: key }, function(error, response, body) {

              if (error) {
                callback({ service: 'someService', error: error });
                return;
              };

              if (response.statusCode === 200) {
                callback(null, body);
                redis.setex(key, 5, JSON.stringify(body), function(error) {
                  if (error) { throw error; };
                  console.log("CACHED");
                });
              } else {
                callback(response.statusCode);
              }
            });
          }

        });

      },
      // parallel request example
      anotherService: function(callback) {
        callback(null, 'data2');
      }
    }, function(error, results) {
      if (error) {
        console.error(error);
        res.send(results.statusCode);
      }
      res.send(results);
    });

  })

  .put(function(req, res) {
    console.log(req.params);
  });


  router.route('/projects')

  // Get all the projects
  // single request example
  .get(function(req, res) {

    var key = 'http://node-4:8080/b/projects/';
    console.log(key);

    redis.get(key, function(err, projects) {

      if (err) { console.error(err); };

      if (projects) {
        console.log("HIT");
        res.send(projects);
      } else {
        console.log("MISS");
        request({ uri: key }, function(error, response, body) {
          if (error) {
            res.status(response.statusCode);
            return;
          }

          if (response.statusCode === 200) {
            res.send(body);
            console.log("Caching Response");
            redis.setex(key, 10, JSON.stringify(body), function(error) {
              if (error) { console.error(error); };
            });
          } else {
            res.status(response.statusCode);
          }
        });
      }
    });

  })

  // Create all the projects
  .put(function(req, res) {
    console.log(req.params);
  });

  return router;

};

module.exports = routes;
