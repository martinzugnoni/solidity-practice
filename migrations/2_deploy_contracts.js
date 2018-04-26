var TokenPiggybank = artifacts.require("./TokenPiggybank.sol");
var MZToken = artifacts.require("./tokens/MZToken.sol");

module.exports = function(deployer, network, accounts) {
  deployer.deploy(MZToken).then(function() {
    return deployer.deploy(TokenPiggybank, MZToken.address);
  });
};
