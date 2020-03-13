#!/bin/bash

set -x

sleep 5
MY_IP=`hostname -i`
ray start --redis-address ray-head:6379 --object-manager-port 12345 --node-manager-port 12346 --node-ip-address $MY_IP --block
