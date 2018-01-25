# Tenderloin
Ethereum smart contracts development environment based on Ethermint/Tendermint

## Motivation

TBD


## Usage

TBD

## Directory structure

* `ethereum` — Dockerfile for building classic Ethereum-go client AKA Geth
* `ethermint` — Dockerfile and start scripts for running actual Ethermint cluster
* `tendermint` — Dockerfile and start scripts for running Tendermint consensus engine
* `netstats` — Server Dockerfile and client configuration for running [ETH Netstats](https://github.com/cubedro/eth-netstats) tool for each node of Ethermint cluster
* `setup` — Ethereum genesis file and keystore for Ethermint private cluster, may include other ocnfiguration files

## Roadmap

- [ ] Build Tenderming from source instead of downloading prepackaged version
- [ ] Add sample contracts subproject with truffle and autodeployment
- [ ] Add usage docs
- [ ] Include sample data encoding/decoding solidity contract

## Known issues

- When netstats monitoring enabled, it causes Golang errors on Ethermint nodes. Not critical for the functionality, but litters log output with errors.
- When netstats monitoring enabled, it increases CPU load dramatically (but very little comparing to classic Ethereum mining), which could cause significantly smaller battery time for laptops running Tenderloin.