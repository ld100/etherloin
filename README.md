# Tenderloin
Ethereum smart contracts development environment based on Ethermint/Tendermint

## Motivation

TBD


## Usage

TBD

## Directory structure

* `contracts` – [Truffle](http://truffleframework.com/)-based smart contracts development suite.
* `ethereum` — Dockerfile for building classic Ethereum-go client AKA Geth.
* `ethermint` — Dockerfile and start scripts for running actual Ethermint cluster.
* `tendermint` — Dockerfile and start scripts for running Tendermint consensus engine.
* `netstats` — Server Dockerfile and client configuration for running [ETH Netstats](https://github.com/cubedro/eth-netstats) tool for each node of Ethermint cluster.
* `setup` — Ethereum genesis file and keystore for Ethermint private cluster, may include other ocnfiguration files.

## Roadmap

- [x] Add sample contracts subproject with truffle and autodeployment
- [ ] Build Tendermint from source instead of downloading prepackaged version
- [ ] Add usage docs
- [ ] Include sample data encoding/decoding solidity contract
- [ ] Add visual block explorer
- [ ] Create a fork of netstats-client that does not break Ethermint

## Known issues

- When netstats monitoring enabled, it causes Golang errors on Ethermint nodes. Not critical for the functionality, but litters log output with errors.
- When netstats monitoring enabled, it increases CPU load dramatically (but very little comparing to classic Ethereum mining), which could cause significantly smaller battery time for laptops running Tenderloin.
- Both Tendermint and Ethermint are crashing on Docker for Windows in case their respective data directories are shared with the host OS. Same issue happens with vanilla go-Ethereum since it is not a bug on Ethereum/Ethermint/Tendermint but a bug in Docker for Windows.