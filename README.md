# Etherloin

Hassle-free Ethereum smart contracts development kit, that uses full-fledged Ethereum cluster and does not require heavyweight mining.

The toolset is based on Docker-compose, Truffle framework and Ethermint/Tendermint.

Etherloin provides private Ethereum (Ethermint) network, that you can use both for smart contracts development and any other dapps or blockchain-related operations, e.g. create accounts, transfer funds, etc.

## Motivation

Project is inspired by existing smart contract development toolkits, such as [Ganache](http://truffleframework.com/ganache/)/TestRPC, [geth-truffle-docker](https://github.com/gregbkr/geth-truffle-docker) and [instant-dapp-ide](https://github.com/dominicwilliams/instant-dapp-ide).
All 3 are great starting points for smart contract development, but have significant drawbacks:

* Ganache uses TestRPC instead of normal Ethereum Virtual Machine, so it can be used for deploying smart contracts, but not other related activities like creating accounts and redistributing account funds via those smart contracts. Another drawback is that Ganache is not docker-friendly out of the box, which adds some overhead for docker-based projects.
* geth-truffle-docker and instant-dapp-ide use full-fledged go-Ethereum (AKA geth) clients and Docker, which make it free from Ganache issues but introduce a new one: you have to enable mining in go-ethereum in order to have gas for using smart contracts. Mining takes lot of system resources and makes development process almost impossible on battery-powered laptops.

Etherloin solves both issues by using Ethermint/Tendermint clients instead of go-ethereum. Ethermint is an Ethereum fork, that uses lightweight Tendermint POS consensus engine, while preserving virtually full backward compatibility with Ethereum.


## Usage

### Prerequisites

It is assumed you already have Docker, Docker-compose and familiar with both tools.

### Architecture

Etherloin consists of multiple Docker containers interacting with each other:

- `ethermaster` – main Ethermint node
- `etherslave` – slave Ethermint node, have the same functionality as the main one
- `tendermaster` – Tendermint consensus engine serving `ethermaster` node
- `tenderslave` - Tendermint consensus engine serving `etherslave` node
- `geth` – Ethereum console connected to `ethermaster`. Technically implemented as a vanilla go-ethereum client.
- `ethutils` – vanilla Ethereum client node with additional tools such as bootnode, evm, abigen, swarm, etc. Used for cases you need to access any of those tools.
- `contracts_test` – Truffle-based container that does just 1 thing: runs tests on your Solidity smart contracts.
- `contracts_deploy` – automatically deploys your Truffle-based smart contracts to the private Ethermint network.
- `contracts_console` – interactive Truffle console working with private Ethermint network.
- `explorer` – [Ethereum Block Explorer (ETHExplorer V2)](https://github.com/carsenk/explorer)
- `netstats` – [eth-netstats](https://github.com/cubedro/eth-netstats) server. Disabled by default, see "Known issues" section.
- `master_monitor` – netstats client, monitoring master Ethermint node. Disabled by default, see "Known issues" section.
- `slave_monitor` – netstats client, monitoring slave Ethermint node. Disabled by default, see "Known issues" section.

It is assumed you'll add own containers or enable/disable some of existing ones if needed.

### Typical usage scenarios

- `docker-compose up --build` to start whole development environment
- Create smart contracts in _contracts/contracts_ directory and appropriate Truffle migrations in _contracts/migrations_
- Interact with Ethereum blockchain either programmatically via RPC API or via included geth client: `docker-compose run geth`

### Production usage

Etherloin uses `docker-compose` as one of its main components. However inside it is split into a set of Docker containers, so nothing stops you from using Etherloin-based application in production using docker containers deployment/orchestration tools like Kubernetes, Docker Swarm, etc.

## Directory structure

* `contracts` – [Truffle](http://truffleframework.com/)-based smart contracts development suite.
* `ethereum` — Dockerfile for building classic Ethereum-go client AKA Geth.
* `ethermint` — Dockerfile and start scripts for running actual Ethermint cluster.
* `tendermint` — Dockerfile and start scripts for running Tendermint consensus engine.
* `explorer` — Dockerfile and configuration files for [Ethereum Block Explorer (ETHExplorer V2)](https://github.com/carsenk/explorer)
* `netstats` — Server Dockerfile and client configuration for running [ETH Netstats](https://github.com/cubedro/eth-netstats) tool for each node of Ethermint cluster.
* `setup` — Ethereum genesis file and keystore for Ethermint private cluster, may include other ocnfiguration files.

## Roadmap

- [ ] Include sample data encoding/decoding solidity contract
- [ ] Implement simple switch between local Ethermint cluster and Ethereum Testnet
- [ ] Create single python-script as Truffle-wrapper and account unlocker instead of 4 different python/shell scripts
- [ ] Create a fork of netstats-client that does not break Ethermint

## Known issues

- When netstats monitoring enabled, it causes Golang errors on Ethermint nodes. Not critical for the functionality, but litters log output with errors.
- When netstats monitoring enabled, it increases CPU load dramatically (but very little comparing to classic Ethereum mining), which could cause significantly smaller battery time for laptops running Etherloin.
- Both Tendermint and Ethermint are crashing on Docker for Windows in case their respective data directories are shared with the host OS. Same issue happens with vanilla go-Ethereum since it is not a bug on Ethereum/Ethermint/Tendermint but a bug in Docker for Windows.
