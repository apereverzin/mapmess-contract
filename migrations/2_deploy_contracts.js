var MapMess = artifacts.require("./MapMess.sol");

module.exports = function(deployer) {
  deployer.deploy(MapMess, 'Advanced Map Coin', 'AMC', 50000000);
};
