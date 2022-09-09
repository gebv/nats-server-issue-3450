BENCHBIN ?= ./mqtt-benchmark

download-mqtt-benchmark-linux:
	curl -SL https://github.com/gebv/mqtt-benchmark/releases/download/v0.2.1/mqtt-bench-linux-amd64.bin -o $(BENCHBIN)
	chmod +x $(BENCHBIN)
	$(BENCHBIN) --help

download-mqtt-benchmark-darwin:
	curl -SL https://github.com/gebv/mqtt-benchmark/releases/download/v0.2.1/mqtt-bench-darwin-amd64.bin -o $(BENCHBIN)
	chmod +x $(BENCHBIN)
	$(BENCHBIN) --help

setup-docker:
	docker-compose up -d nats-server-node1
	docker-compose up -d nats-server-node2
	docker-compose up -d nats-server-node3
	sleep 10

# run: setup-darwin setup-docker
run:
	./bench.sh

