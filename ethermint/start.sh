#!/bin/sh

# Exit if any command return non-zero exitcode
set -e

# cd /root/eth-net-intelligence-api
# perl -pi -e "s/XXX/$(hostname)/g" app.json
# /usr/bin/pm2 start ./app.json
# sleep 3

# Initialize working directory
ethermint --datadir ${DATA_ROOT} init ${DATA_ROOT}/genesis.json
sleep 3

# BOOTSTRAP_IP=`getent hosts bootstrap | cut -d" " -f1`
# GETH_OPTS=${@/XXX/$BOOTSTRAP_IP}
# geth $GETH_OPTS
ethermint --tendermint_addr ${TENDERMINT_ADDR} --datadir ${DATA_ROOT} --rpc --rpcaddr=0.0.0.0 --ws --wsaddr=0.0.0.0 --rpcapi eth,net,web3,personal,admin
