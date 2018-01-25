module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  networks: {
    development: {
      host: process.env.ETHEREUM_RPC_HOST,
      port: process.env.ETHEREUM_RPC_PORT,
      network_id: "*",
      gas: 4029024,
      from: process.env.ETHEREUM_DEPLOYER_ADDRESS,
    }
  },
  solc: {
    optimizer: {
      enabled: true,
      runs: 200
    }
  },
  rpc: {
    host: process.env.ETHEREUM_RPC_HOST,
    port: process.env.ETHEREUM_RPC_PORT
  }
};