# Build Tendermint
FROM golang:1.9-alpine as builder

# Somehow Tendermint v0.15.0 does not work with Ethermint v0.5.4
#ENV TM_VERSION v0.15.0
ENV TM_VERSION v0.13.0

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
RUN mkdir -p /go/src/github.com/tendermint/tendermint && \
    cd /go/src/github.com/tendermint/tendermint && \
    git clone https://github.com/tendermint/tendermint . && \
    git checkout ${TM_VERSION}

# Build tendermint and all tools
RUN cd /go/src/github.com/tendermint/tendermint && \
    make get_vendor_deps && make install && glide cc && cd - && \
    rm -rf /go/src/github.com/tendermint/tendermint && \
    apk del go build-base git


# Pull all binaries into a second stage deploy alpine container
FROM alpine:latest

# The /tendermint/data dir is used by tendermint to store state.
ENV DATA_ROOT /tendermint
ENV TMHOME $DATA_ROOT

# Create directory for persistence and give our user ownership
RUN mkdir -p $DATA_ROOT

RUN apk add --no-cache ca-certificates bash
COPY --from=builder /go/bin/* /usr/local/bin/

# Expose the data directory as a volume since there's mutable state in there
VOLUME $DATA_ROOT

# p2p port
EXPOSE 46656
# rpc port
EXPOSE 46657

ENTRYPOINT ["tendermint"]

CMD ["node", "--moniker=`hostname`"]
