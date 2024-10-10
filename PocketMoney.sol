// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract PocketMoney{
    struct Kid{
        uint amount;
        uint maturity;
        bool paid;
    }
    address public admin;
    mapping(address => Kid) public kids;

    constructor(){
        admin = msg.sender;
    }

    function addkids(address _kid, uint maturityInDays) external payable  {
        require(msg.sender == admin, "Only admin can add kids.");
        require(kids[_kid].amount == 0, "Kid already exist.");

        kids[_kid] = Kid(msg.value,block.timestamp + (maturityInDays * 1 days),false);

    }

    function withdraw() external {
        Kid storage kid = kids[msg.sender];
        require(kid.amount > 0,"only kid can withdraw");
        require(kid.maturity >= block.timestamp,"too early");
        require(kid.paid == false, "Already withdrawn.");
        kid.paid = true;
        payable(msg.sender).transfer(kid.amount);
    }

}
