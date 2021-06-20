// SPDX-License-Identifier: MITp
pragma solidity ^0.8.0;

// Caller of this contract is made the admin/owner for HCoin
// this contract allows us transfer ownership to another account (transferAdminship)
contract admined {
    address public admin;

    // constructor ??
    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin);
        _;
    }

    function transferAdminship(address newAdmin) public onlyAdmin {
        admin = newAdmin;
    }
}

contract HCoin {
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    string public standard = "HCoin v1.0";
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;

    event Transfer(address indexed from, address indexed to, uint256 value);

    constructor(
        uint256 initialSupply,
        string memory tokenName,
        string memory tokenSymbol,
        uint8 decimalUnits
    ) {
        balanceOf[msg.sender] = initialSupply;
        totalSupply = initialSupply;
        decimals = decimalUnits;
        symbol = tokenSymbol;
        name = tokenName;
    }

    function transfer(address _to, uint256 _value) public {
        //the following require statements are checking for overflows/underflows
        require(balanceOf[msg.sender] > _value);
        require(balanceOf[_to] + _value > balanceOf[_to]);

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
    }

    // owner of tokens can approve amount of tokens another address can spend on their behalf
    function approve(address _spender, uint256 _value) public returns (bool _success) {
        allowance[msg.sender][_spender] = _value;
        return true;
    }
    // Transfer tokens from one address to another, from 
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool _success){
        require(balanceOf[_from] > _value);
        require(balanceOf[_to] + _value > balanceOf[_to]);
        require(_value < allowance[_from][msg.sender]);
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

}
