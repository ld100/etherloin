#!/bin/sh
echo "Waiting Ethereum to start..."
while ! nc -z ${ETHEREUM_RPC_HOST} ${ETHEREUM_RPC_PORT}; do
  sleep 0.1
done

echo "Ethereum started, running truffle on network: ${ETHEREUM_NETWORK}"

echo "Unlocking ethereum deployer account"
/usr/bin/python3 bin/unlock.py

# Truffle console on private network
truffle console --network ${ETHEREUM_NETWORK}