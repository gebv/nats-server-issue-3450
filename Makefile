
setup:
	curl -SL https://github.com/krylovsk/mqtt-benchmark/releases/download/v0.2.0/mqtt-benchmark-linux-amd64 -o mqtt-benchmark
	chmod +x mqtt-benchmark
	./mqtt-benchmark --help

setup-darwin:
	curl -SL https://github.com/krylovsk/mqtt-benchmark/releases/download/v0.2.0/mqtt-benchmark-darwin-amd64 -o mqtt-benchmark
	chmod +x mqtt-benchmark
	./mqtt-benchmark --help

setup-docker:
	docker-compose up -d nats-server-node1
	docker-compose up -d nats-server-node2
	docker-compose up -d nats-server-node3
	sleep 10

# run: setup-darwin setup-docker
run-test: setup setup-docker
	./bench.sh
	docker logs node1
	docker logs node2
	docker logs node3

	# ./mqtt-benchmark --broker "tcp://127.0.0.1:10001" \
    #         --client-prefix "connect-to-node-1" \
    #         --qos 0 \
    #         --count 300 \
    #         --size 10 \
    #         --clients 10 \
    #         --topic "topic/client1" \
    #         --message-interval 100 \
    #         --format text

	# ./mqtt-benchmark --broker "tcp://127.0.0.1:10002" \
    #         --client-prefix "connect-to-node-2" \
    #         --username="service:100" \
    #         --password="*service_secret*" \
    #         --qos 0 \
    #         --count 300 \
    #         --size 10 \
    #         --clients 10 \
    #         --topic "topic/client1" \
    #         --message-interval 100 \
    #         --format text

	# ./mqtt-benchmark --broker "tcp://127.0.0.1:10003" \
    #         --client-prefix "connect-to-node-3" \
    #         --username="service:100" \
    #         --password="*service_secret*" \
    #         --qos 0 \
    #         --count 300 \
    #         --size 10 \
    #         --clients 10 \
    #         --topic "topic/client1" \
    #         --message-interval 100 \
    #         --format text
