#!/bin/sh

# Exit if any command return non-zero exitcode
set -e

# Preparing eth-net-intelligence-api
perl -pi -e "s/XXX/$(hostname)/g" /root/eth-net-intelligence-api/app.json

# Launching eth-net-intelligence-api
cd /root/eth-net-intelligence-api
/usr/bin/pm2 start ./app.json
cd ${DATA_ROOT}
sleep 3

# Initialize working directory
ethermint --datadir ${DATA_ROOT} init ${DATA_ROOT}/genesis.json
sleep 3

ethermint --tendermint_addr ${TENDERMINT_ADDR} --datadir ${DATA_ROOT} --rpc --rpcaddr=0.0.0.0 --ws --wsaddr=0.0.0.0 --rpcapi eth,net,web3,personal,admin
