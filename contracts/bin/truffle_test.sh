#!/bin/sh
echo "Waiting Ethereum to start..."
while ! nc -z ${ETHEREUM_RPC_HOST} ${ETHEREUM_RPC_PORT}; do
  sleep 0.1
done

echo "Ethereum started, running truffle on network: ${ETHEREUM_NETWORK}"

echo "Installing dependencies..."
truffle install zeppelin

echo "Unlocking account for tests"
/usr/bin/python3 bin/unlock.py

# Test on private network
echo "Testing on network: ${ETHEREUM_NETWORK}"
truffle test --network ${ETHEREUM_NETWORK}
