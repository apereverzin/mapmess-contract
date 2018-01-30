pragma solidity ^0.4.17;

contract MapMess {
    address public owner = msg.sender;

    modifier onlyOwner {
        if (msg.sender != owner) revert();
        _;
    }

    function changeOwner(address _newOwner) public
    onlyOwner
    {
        if (_newOwner == 0x0) revert();
        owner = _newOwner;
    }

    function kill() public {
        if (msg.sender == owner)
        selfdestruct(owner);
    }

    event tokensBought(address indexed addr, uint256 amount);

    event tokensTransferred(address indexed from, address indexed to, uint256 amount);

    mapping (address => uint256) public balances;

    string public name;

    string public symbol;

    uint8 public decimals;

    uint256 public totalSupply;

    uint8 public tokenPriceEther;

    function MapMess(
    string _name,
    string _symbol,
    uint8 _decimals,
    uint256 _totalSupply,
    uint8 _tokenPriceEther) public {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _totalSupply;
        balances[msg.sender] = _totalSupply;
        tokenPriceEther = _tokenPriceEther;
    }

    function() public payable {

    }

    function getOwner() public constant returns (address) {
        return owner;
    }

    function totalSupply() public constant returns (uint _totalSupply) {
        return totalSupply;
    }

    function buyTokens() public payable {
        uint numberOfTokens = msg.value / tokenPriceEther;
        require(balances[owner] >= numberOfTokens);

        balances[msg.sender] += numberOfTokens;
        balances[owner] -= numberOfTokens;

        tokensBought(msg.sender, numberOfTokens);
    }

    function getTokenPrice() public constant returns (uint8) {
        return tokenPriceEther;
    }

    function getBalance() public constant returns (uint256 balance) {
        return balanceOf(msg.sender);
    }

    function balanceOf(address _owner) public constant returns (uint256 balance) {
        return balances[_owner];
    }

    function transfer(address _to, uint256 _amount) public returns (bool success) {
        if (balances[msg.sender] >= _amount
        && _amount > 0
        && balances[_to] + _amount > balances[_to]) {
            balances[msg.sender] -= _amount;
            balances[_to] += _amount;
            tokensTransferred(msg.sender, _to, _amount);
            return true;
        }
        else {
            return false;
        }
    }
}
