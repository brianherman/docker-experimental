#!/bin/bash
echo 'yes' | ./src/redis-trib.rb create --replicas 1 172.24.1.1:6379 172.24.1.2:6379 172.24.1.3:6379 172.24.2.1:6379 172.24.2.2:6379 172.24.2.3:6379
# ./src/redis-trib.rb add-node 172.24.1.2:6379 172.24.1.1:6379
# ./src/redis-trib.rb add-node 172.24.1.3:6379 172.24.1.1:6379
# ./src/redis-trib.rb add-node --slave 172.24.2.1:6379 172.24.1.1:6379
# ./src/redis-trib.rb add-node --slave 172.24.2.2:6379 172.24.1.2:6379
# ./src/redis-trib.rb add-node --slave 172.24.2.3:6379 172.24.1.3:6379