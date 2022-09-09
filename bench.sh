#!/bin/bash

./mqtt-benchmark --broker "tcp://127.0.0.1:10001" \
    --client-prefix "*service*client-1" \
    --username="service:100" \
    --password="*service_secret*" \
    --qos 0 \
    --count 300 \
    --size 10 \
    --clients 10 \
    --topic "topic/client1" \
    --message-interval 100 \
    --format text > client-node1.log 2>client-node1-error.log &

CON_PID=$!
log "Test: $CON_PID"

log "Wait test pids: $CON_PID kill timeout: 30s"
sleep 30

kill -9 $CON_PID

log "Tests finished"


