// Contract to be tested
var MapMess = artifacts.require("./MapMess.sol");

// Test suite
contract('MapMess', function(accounts) {
  var chainListInstance;
  var seller = accounts[0];

  // Test case: check initial values
  it("should be initialized", function() {
    return MapMess.deployed().then(function(instance) {
      return instance.getTokenPrice.call();
    }).then(function(data) {
      assert.equal(data, 0x1, "1token price should be ");
    });
  });
});
