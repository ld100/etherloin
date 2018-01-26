#!/bin/sh

# Exit if any command return non-zero exitcode
set -e

# Initialize working directory
ethermint --datadir ${DATA_ROOT} init ${DATA_ROOT}/genesis.json
sleep 3

# Setting allowed CORS domains
# It is a good idea to load them via environment variables instead
CORSDOMAINS="http://localhost:8000,localhost,explorer"
readonly CORSDOMAINS

# Run Ethermint/Geth
ethermint --tendermint_addr ${TENDERMINT_ADDR} --datadir ${DATA_ROOT} --rpc --rpcaddr=0.0.0.0 --rpccorsdomain ${CORSDOMAINS} --ws --wsaddr=0.0.0.0 --rpcapi eth,net,web3,personal,admin
