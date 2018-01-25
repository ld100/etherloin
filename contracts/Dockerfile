FROM node:8-alpine

RUN apk add -t .gyp --no-cache git python3 g++ make \
    && npm install -g truffle \
    && apk del .gyp

ENV WORKDIR /usr/src/app

RUN mkdir -p ${WORKDIR}
WORKDIR ${WORKDIR}

# Add current codebase to container
COPY . .

RUN apk update && apk upgrade \
    && apk add --no-cache g++ ca-certificates python3 python3-dev bash \
    && pip3 install web3

EXPOSE 8080
CMD /bin/sh ${WORKDIR}/bin/truffle.sh