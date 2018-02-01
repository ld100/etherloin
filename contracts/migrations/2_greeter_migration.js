var Greeter = artifacts.require("./greeter.sol");
var nameArg = "World";

module.exports = function (deployer) {
    // deployment steps
    deployer.deploy(Greeter, nameArg);
};