#!/bin/sh

# Exit if any command return non-zero exitcode
set -e

# cd /root/eth-net-intelligence-api
# perl -pi -e "s/XXX/$(hostname)/g" app.json
# /usr/bin/pm2 start ./app.json
# sleep 3

# Initialize working directory
tendermint init
sleep 3

# BOOTSTRAP_IP=`getent hosts bootstrap | cut -d" " -f1`
# GETH_OPTS=${@/XXX/$BOOTSTRAP_IP}
# geth $GETH_OPTS
tendermint node --proxy_app=${ETHERMINT_ADDR}
