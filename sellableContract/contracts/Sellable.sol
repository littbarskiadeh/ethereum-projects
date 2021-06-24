// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Sellable {
    // owner of contract
    address public owner;

    // current sale status
    bool public selling = false;

    // buyer of contract
    address public buyer;
    // price in ether(wei)
    uint256 public price;

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    // applied to functions should not be called while contract is for sale
    modifier ifNotLocked {
        require(!selling);
        _;
    }
    event Transfer(
        uint256 _saleDate,
        address _from,
        address _to,
        uint256 _salePrice
    );

    constructor() {
        owner = msg.sender;
        emit Transfer(block.timestamp, address(0), owner, 0);
    }

    function initiateSale(uint256 _price, address _to) public onlyOwner {
        require(_to != address(this) && _to != owner);
        require(!selling);

        selling = true;
        buyer = _to;
        price = _price;
    }

    // cancel sale of a contract
    function cancelSale() onlyOwner public{
        require(selling);

        resetSale();
    }

// Called by the buyer of the contract. Value sent must match the asking price
    function completeSale(uint valued) public payable {
        require(selling);
        require(msg.sender != owner);
        require(msg.sender == buyer || buyer == address(0));
        require(valued == price);

        // swap ownership
        address prevOwner = owner;
        address newOwner = msg.sender;
        uint salePrice = price;

        owner = newOwner;

        emit Transfer(block.timestamp, prevOwner, newOwner, salePrice);
        resetSale();
    }
 

//  resets variables to initial values
    function resetSale() internal {
        selling = false;
        buyer = address(0);
        price = 0;
    }
}
