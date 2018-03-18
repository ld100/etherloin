#!/bin/sh
echo "Waiting Ethereum to start..."
while ! nc -z ${ETHEREUM_RPC_HOST} ${ETHEREUM_RPC_PORT}; do
  sleep 0.1
done

echo "Ethereum started, running truffle on network: ${ETHEREUM_NETWORK}"

# Deploy to private network
echo "Unlocking account for migrations"
/usr/bin/python3 bin/unlock.py

echo "Deployment on network: ${ETHEREUM_NETWORK}"
truffle migrate --network ${ETHEREUM_NETWORK}
