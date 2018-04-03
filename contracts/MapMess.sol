pragma solidity ^0.4.17;


contract MapMess {
    address public owner;

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

        balances[msg.sender] = sub(balances[msg.sender], _value);
        balances[_to] = add(balances[_to], _value);

        Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value)
    public onlyOwner returns (bool) {
        require(balances[_from] >= _value && _value > 0);

        balances[_from] = sub(balances[_from], _value);
        balances[_to] = add(balances[_to], _value);

        Transfer(_from, _to, _value);
        return true;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
}
