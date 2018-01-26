# Build Ethermint
FROM golang:1.9-alpine as builder

ENV EM_VERSION v0.5.4

ENV GOPATH /go
ENV PATH "$PATH:/go/bin"

# Install dependencies
RUN apk update && \
    apk add --no-cache make gcc musl-dev linux-headers go build-base git

# Install Golang's dependency manager
RUN go-wrapper download -u github.com/Masterminds/glide && \
    go-wrapper install github.com/Masterminds/glide && \
    rm -rf /usr/lib/go /go/src /go/pkg /var/cache/*

# Get the source code
RUN mkdir -p /go/src/github.com/tendermint/ethermint && \
    cd /go/src/github.com/tendermint/ethermint && \
    git clone https://github.com/tendermint/ethermint . && \
    git checkout ${EM_VERSION}

# Build ethermint and all tools
RUN cd /go/src/github.com/tendermint/ethermint && \
    make get_vendor_deps && make install && glide cc && cd - && \
    rm -rf /go/src/github.com/tendermint/ethermint && \
    apk del go build-base git


# Pull all binaries into a second stage deploy alpine container
FROM alpine:latest

# The /ethermint/data dir is used by ethermint to store state.
ENV DATA_ROOT /ethermint
#ENV TENDERMINT_ADDR tcp://0.0.0.0:46657

# Create directory for persistence and give our user ownership
RUN mkdir -p $DATA_ROOT

RUN apk add --no-cache ca-certificates bash
COPY --from=builder /go/bin/* /usr/local/bin/

# Expose the data directory as a volume since there's mutable state in there
VOLUME $DATA_ROOT

EXPOSE 46658
EXPOSE 8545
EXPOSE 8546

# Using entrypoint is never a good idea unless you're using docker image as CLI
# ENTRYPOINT ["ethermint"]

CMD ethermint --datadir $DATA_ROOT --tendermint_addr $TENDERMINT_ADDR
