#!/bin/sh

# Exit if any command return non-zero exitcode
set -e

# Initialize working directory
tendermint init
sleep 3

# Run tendermint node
tendermint node --proxy_app=${ETHERMINT_ADDR} --p2p.seeds=${SEEDS}
