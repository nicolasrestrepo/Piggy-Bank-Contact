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

    modifier verifyBalance(uint256 amount){
        require (
           msg.value <= amount,
           "non-sufficient funds"
        );
        _;
    }

    function deposit() public payable {
        transactionsHistory.push(Transaction(msg.value, msg.sender, 1));
        emit DepositEvent(msg.value);
        balance += msg.value;
    }

    function getBalance() public view returns (uint256) {
        return balance;
    }

    function getTransactions() public view returns (Transaction[] memory){
        return transactionsHistory;
    }

    function withdraw(uint amount) external payable onlyOwner verifyBalance(amount){
        payable(msg.sender).transfer(amount);
        balance -= amount;
        transactionsHistory.push(Transaction(amount, msg.sender, 0));
        emit WithdrawEvent(msg.value);
    }
}