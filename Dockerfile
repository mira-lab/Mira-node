FROM rust
WORKDIR /usr/src/myapp/parity
RUN apt-get update && apt-get install -y apt-utils && apt-get install -y \
	openssl \
	libssl-dev \
	libudev-dev && \
	rm -rf /var/lib/apt/lists/*
RUN cd .. && \
	git init && \
	git clone https://github.com/mira-lab/parity && \
	cd parity &&\
	cargo build --features secretstore --release && \
	cp target/release/parity /usr/local/bin/ && \
	rm -rf /usr/src/myapp/parity
RUN chmod +x /usr/local/bin/parity
EXPOSE 8045 8080 8082 8085 8545 30303
ENTRYPOINT ["/usr/local/bin/parity", "--jsonrpc-interface all",	"--jsonrpc-cors all"]


