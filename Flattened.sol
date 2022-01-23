// Sources flattened with hardhat v2.8.3 https://hardhat.org

// File contracts/PiggyBank.sol

//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract PiggyBank {
    
    address public owner;
    uint256 balance;

    struct Transaction {
        uint256 value;
        address owner;
        uint256 typeTransaction;
    }

    Transaction[] private transactionsHistory;

    // events
    event DepositEvent(uint amount);
    event WithdrawEvent(uint  amount);


    constructor(){
        owner = msg.sender;
    }
    
     modifier onlyOwner() {
        require(msg.sender == owner, 
            "Only the owner can make this action"
        );
        _;
    }

    modifier verifyBalance(){
        require (
           msg.value <= balance,
           "non-sufficient funds"
        );
        _;
    }
 
    function deposit() public payable {
        balance += msg.value;
    }

    function getBalance() public view returns (uint256) {
        return balance;
    }

    function getTransactions() public view returns (Transaction[] memory){
        return transactionsHistory;
    }

    function withdraw() external payable onlyOwner verifyBalance(){
        payable(msg.sender).transfer(msg.value);
        balance -= msg.value;
        transactionsHistory.push(Transaction(msg.value, msg.sender, 0));
        emit WithdrawEvent(msg.value);
    }
}
