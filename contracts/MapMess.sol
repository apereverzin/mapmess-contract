pragma solidity ^0.4.17;


import "./SafeMath.sol";


contract MapMess {
    address public owner;

    using SafeMath for uint256;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function kill() public onlyOwner {
        selfdestruct(owner);
    }

    string public name;

    string public symbol;

    uint256 public totalSupply;

    uint8 public constant decimals = 18;

    mapping (address => uint256) balances;

    function MapMess(
    string _name,
    string _symbol,
    uint256 _totalSupply) public {
        owner = msg.sender;
        name = _name;
        symbol = _symbol;
        totalSupply = _totalSupply;
        balances[msg.sender] = _totalSupply;
    }

    function totalSupply() public view returns (uint256) {
        return totalSupply;
    }

    function balanceOf(address _owner) public view returns (uint256){
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value) public returns (bool) {
        require(balances[msg.sender] >= _value && _value > 0);

        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_to] = balances[_to].add(_value);

        Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value)
    public onlyOwner returns (bool) {
        require(balances[_from] >= _value && _value > 0);

        balances[_from] = balances[_from].sub(_value);
        balances[_to] = balances[_to].add(_value);

        Transfer(_from, _to, _value);
        return true;
    }

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
}
