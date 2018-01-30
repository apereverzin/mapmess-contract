// Contract to be tested
var MapMess = artifacts.require("./MapMess.sol");

contract('MapMess', function(accounts) {
  var chainListInstance;
  var seller = accounts[0];

  it("contract should be initialized", function() {
    var contractInstance;

    return MapMess.deployed().then(function(instance) {
      contractInstance = instance;
      return contractInstance.getOwner.call();
    }).then(function(data) {
      assert.equal(data, accounts[0], "owner should be " + accounts[0]);
      return contractInstance.getTokenPrice.call();
    }).then(function(data) {
      assert.equal(data, 0x1, "token price should be 1");
      return contractInstance.totalSupply.call();
    }).then(function(data) {
      assert.equal(data, 10000, "total supply should be 10000");
      return contractInstance.balanceOf(accounts[1]);
    }).then(function(data) {
      assert.equal(data, 0x0, "initial balance should be 0");
      return contractInstance.getBalance.call();
    }).then(function(data) {
      assert.equal(data, 10000, "owner balance should be 10000");
    });
  });
});
