BENCHBIN ?= ./mqtt-benchmark

download-mqtt-benchmark-linux:
	curl -SL https://github.com/gebv/mqtt-benchmark/releases/download/v0.2.2/mqtt-bench-linux-amd64.bin -o $(BENCHBIN)
	chmod +x $(BENCHBIN)
	$(BENCHBIN) --help

download-mqtt-benchmark-darwin:
	curl -SL https://github.com/gebv/mqtt-benchmark/releases/download/v0.2.2/mqtt-bench-darwin-amd64.bin -o $(BENCHBIN)
	chmod +x $(BENCHBIN)
	$(BENCHBIN) --help

run:
	docker-compose up --detach --force-recreate --renew-anon-volumes --remove-orphans \
        nats-server-node1 nats-server-node2 nats-server-node3

	sleep 30

	./bench.sh
	./report.sh
