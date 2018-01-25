var MyContract = artifacts.require("./greeter.sol");

module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(MyContract);
};