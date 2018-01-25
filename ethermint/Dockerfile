FROM alpine:3.7

ENV DATA_ROOT /ethermint
# ENV TENDERMINT_ADDR tcp://0.0.0.0:46657

RUN addgroup emuser && \
    adduser -S -G emuser emuser

RUN mkdir -p $DATA_ROOT && \
    chown -R emuser:emuser $DATA_ROOT

RUN apk add --no-cache bash

# Setting Golang paths
ENV GOPATH /go
ENV PATH "$PATH:/go/bin"
# ENV ETHERMINT_VERSION develop
# ENV ETHERMINT_VERSION master
ENV ETHERMINT_VERSION v0.5.4

# Installing Ethermint from source
RUN mkdir -p /go/src/github.com/tendermint/ethermint && \
    apk add --no-cache go build-base git linux-headers && \
    cd /go/src/github.com/tendermint/ethermint && \
    git clone https://github.com/tendermint/ethermint . && \
    git checkout ${ETHERMINT_VERSION} && \
    make get_vendor_deps && \
    make install && \
    glide cc && \
    cd - && \
    rm -rf /go/src/github.com/tendermint/ethermint && \
    apk del go build-base git

VOLUME $DATA_ROOT

EXPOSE 46658
EXPOSE 8545
EXPOSE 8546

# Using entrypoint is never a good idea unless you're using docker image as CLI
# ENTRYPOINT ["ethermint"]

CMD ethermint --datadir $DATA_ROOT --tendermint_addr $TENDERMINT_ADDR
