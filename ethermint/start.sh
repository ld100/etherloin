#!/bin/sh

# Exit if any command return non-zero exitcode
set -e

# Initialize working directory
ethermint --datadir ${DATA_ROOT} init ${DATA_ROOT}/genesis.json
sleep 3

# Run Ethermint/Geth
ethermint --tendermint_addr ${TENDERMINT_ADDR} --datadir ${DATA_ROOT} --rpc --rpcaddr=0.0.0.0 --rpccorsdomain "*" --ws --wsaddr=0.0.0.0 --rpcapi eth,net,web3,personal,admin
