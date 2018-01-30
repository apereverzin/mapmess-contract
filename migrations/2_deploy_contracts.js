var MapMess = artifacts.require("./MapMess.sol");

module.exports = function(deployer) {
  deployer.deploy(MapMess, 'MapMess', 'MPM', 18, 10000, 1);
};
