#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
from web3 import Web3, HTTPProvider, IPCProvider

host = os.environ["ETHEREUM_RPC_HOST"]
port = int(os.environ["ETHEREUM_RPC_PORT"])
address = os.environ["ETHEREUM_DEPLOYER_ADDRESS"]
passphrase = os.environ["ETHEREUM_DEPLOYER_PASSPHRASE"]
duration = int(os.environ["ETHEREUM_UNLOCK_DURATION"])
network_name = os.environ["ETHEREUM_NETWORK"]

# We do not need unlocks on TESTRPC
if network_name != "testrpc":
    connection = Web3(HTTPProvider("http://%s:%i" % (host, port)))
    unlock = connection.personal.unlockAccount(address, passphrase, duration)
