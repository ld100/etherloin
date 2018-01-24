FROM alpine:3.6

ENV DATA_ROOT /ethermint
# ENV TENDERMINT_ADDR tcp://0.0.0.0:46657

RUN addgroup emuser && \
    adduser -S -G emuser emuser

RUN mkdir -p $DATA_ROOT && \
    chown -R emuser:emuser $DATA_ROOT

RUN apk add --no-cache bash

# Installing eth-net-intelligence-api depencencies and bash
RUN apk add --update git bash nodejs nodejs-npm perl

# Installing eth-net-intelligence client
RUN cd /root &&\
    git clone https://github.com/cubedro/eth-net-intelligence-api &&\
    cd eth-net-intelligence-api &&\
    npm install &&\
    npm install -g pm2

# Setting GOlang paths
ENV GOPATH /go
ENV PATH "$PATH:/go/bin"

# Installing Ethermint from source
RUN mkdir -p /go/src/github.com/tendermint/ethermint && \
    apk add --no-cache go build-base git linux-headers && \
    cd /go/src/github.com/tendermint/ethermint && \
    git clone https://github.com/tendermint/ethermint . && \
    git checkout develop && \
    make get_vendor_deps && \
    make install && \
    glide cc && \
    cd - && \
    rm -rf /go/src/github.com/tendermint/ethermint && \
    apk del go build-base git

# Putting eth-net-intelligence client configuration into container
ADD app.json /root/eth-net-intelligence-api/app.json

VOLUME $DATA_ROOT

EXPOSE 46658
EXPOSE 8545
EXPOSE 8546

#ENTRYPOINT ["ethermint"]

CMD ethermint --datadir $DATA_ROOT --tendermint_addr $TENDERMINT_ADDR
