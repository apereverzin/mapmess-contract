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

    string public name;

    string public symbol;

    uint256 public totalSupply;

    uint8 public constant decimals = 18;

    mapping (address => uint256) balances;

    mapping (address => mapping (address => uint256)) allowed;

    function MapMess(
    string _name,
    string _symbol,
    uint256 _totalSupply) public {
        name = _name;
        symbol = _symbol;
        totalSupply = _totalSupply;
        balances[msg.sender] = _totalSupply;
    }

    function() public payable {
        //
    }

    function totalSupply() constant public returns (uint256) {
        return totalSupply;
    }

    function balanceOf(address _owner) constant public returns (uint256){
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value) public returns (bool) {
        require(balances[msg.sender] >= _value && _value > 0);

        balances[msg.sender] = balances[msg.sender] - _value;
        balances[_to] = balances[_to] + _value;

        tokensTransferred(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value)
    public onlyOwner returns (bool) {
        balances[_from] = balances[_from] - _value;
        balances[_to] = balances[_to] + _value;
        allowed[_from][msg.sender] = allowed[_from][msg.sender] - _value;

        tokensTransferred(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool){
        allowed[msg.sender][_spender] = _value;

        tokensTransferApproved(msg.sender, _spender, _value);
        return true;
    }

    event tokensTransferred(address indexed _from, address indexed _to, uint256 _value);

    event tokensTransferApproved(address indexed _owner, address indexed _spender, uint256 _value);
}
