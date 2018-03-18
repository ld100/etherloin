FROM node:8-alpine

ENV WORKDIR /usr/src/app

RUN mkdir -p ${WORKDIR}
WORKDIR ${WORKDIR}

# Add current codebase to container
COPY . .

RUN apk update && apk upgrade \
    && apk add --no-cache g++ ca-certificates python3 python3-dev bash yarn \
    && pip3 install --upgrade pip && pip3 install web3==4.0.0b11 \
    && yarn global add truffle
    # && yarn global add truffle zeppelin-solidity ganache-cli

EXPOSE 8080
CMD /bin/sh ${WORKDIR}/bin/truffle.sh