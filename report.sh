#!/bin/bash

docker logs node1
docker logs node2
docker logs node3

if docker logs node1 2>&1 | grep -q MQIsdp
    then { echo "DETECTED on node1"; }
    else echo "node1 OK"
fi

if docker logs node2 2>&1 | grep -q MQIsdp
    then { echo "DETECTED on node2"; }
    else echo "node2 OK"
fi

if docker logs node3 2>&1 | grep -q MQIsdp
    then { echo "DETECTED on node3"; }
    else echo "node3 OK"
fi
