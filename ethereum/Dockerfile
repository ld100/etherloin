# Build Geth in a stock Go builder container
FROM golang:1.9-alpine as builder

ENV GETH_VERSION v1.8.2

# Install dependencies
RUN apk update && \
    apk add --no-cache make gcc musl-dev linux-headers go build-base git

# Get the source code
RUN git clone https://github.com/ethereum/go-ethereum /go-ethereum && \
    cd /go-ethereum && \
    git checkout ${GETH_VERSION}

# Build geth and all tools
ADD . /go-ethereum
RUN cd /go-ethereum && make all

# Pull all binaries into a second stage deploy alpine container
FROM alpine:latest

# Create directory for persistence
ENV DATA_ROOT /root/.ethereum
RUN mkdir -p $DATA_ROOT

RUN apk add --no-cache ca-certificates bash
COPY --from=builder /go-ethereum/build/bin/* /usr/local/bin/

# Expose the data directory as a volume since there's mutable state in there
VOLUME $DATA_ROOT

EXPOSE 8545 8546 30303 30303/udp 30304/udp

CMD ["geth", "--help"]