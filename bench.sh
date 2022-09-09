#!/bin/bash

TEST_PIDS=""

runBench() {
    local port=$1
    local idx=$2
    ./mqtt-benchmark --broker "tcp://127.0.0.1:${port}" \
        --client-prefix "client-${idx}" \
        --qos 0 \
        --count 300 \
        --size 10 \
        --clients 10 \
        --topic "/topic-${idx}" \
        --format text >client-node${idx}.log 2>client-node${idx}-error.log &

    local CON_PID=$!
    echo "Test count=300, size=10, client=10: $CON_PID"

    TEST_PIDS="$TEST_PIDS $CON_PID"
}

runBench 10001 1
runBench 10002 2
runBench 10003 3

echo "Wait test pids: $TEST_PIDS kill timeout: 30s"
sleep 30

kill -9 $TEST_PIDS

echo "Tests finished"

cat client-node1.log
cat client-node1-error.log

cat client-node2.log
cat client-node2-error.log

cat client-node3.log
cat client-node3-error.log


if docker logs node1 2>&1 | grep -q MQIsdp
    then { echo "FOUND"; docker logs node1; }
    else echo "NOT FOUND"
fi

if docker logs node2 2>&1 | grep -q MQIsdp
    then { echo "FOUND"; docker logs node2; }
    else echo "NOT FOUND"
fi

if docker logs node3 2>&1 | grep -q MQIsdp
    then { echo "FOUND"; docker logs node3; }
    else echo "NOT FOUND"
fi
