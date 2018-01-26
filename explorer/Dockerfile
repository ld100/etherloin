FROM node:8-alpine

RUN apk add --update git

RUN git clone https://github.com/carsenk/explorer

WORKDIR /explorer

# See details on https://github.com/mhart/alpine-node/issues/27
#RUN apk add --update --no-cache make gcc g++ python && \
#  npm install --production --silent && \
#  apk del make gcc g++ python
RUN apk add --update --no-cache make gcc g++ python && \
  npm install --production --silent

RUN npm install -g bower
RUN bower install --allow-root

EXPOSE 8000

CMD ["npm", "start"]

