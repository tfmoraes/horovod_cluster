#!/bin/bash

set -x

MY_IP=`hostname -i`
ray start --head --redis-port 6379 --redis-shard-ports 6380,6381 --object-manager-port 12345 --node-manager-port 12346 --node-ip-address $MY_IP --block --include-webui --webui-host 0.0.0.0
