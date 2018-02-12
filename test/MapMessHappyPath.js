var MapMess = artifacts.require('./MapMess.sol');
contract('MapMess', function(accounts) {
  it("should assert true", function(done) {
    var mapMess = MapMess.deployed();
    assert.isTrue(true);
    done();
  });
});
