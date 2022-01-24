//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract PiggyBank {
    struct Transaction {
        uint256 value;
        address depositorAddress;
        uint256 typeTransaction;
    }

    address public owner;
    mapping(address => uint256) founds;
    mapping(address => Transaction[]) public transactionsHistory;

    // events
    event DepositEvent(uint amount);
    event WithdrawEvent(uint  amount);


    constructor(){
        owner = msg.sender;
    }
    
    modifier verifyBalance(uint256 amount){
        require (
           amount <= founds[msg.sender],
           "non-sufficient funds"
        );
        _;
    }

    function withdraw(uint amount) external payable verifyBalance(amount){
        payable(msg.sender).transfer(amount);
        founds[msg.sender] -= amount;
        transactionsHistory[msg.sender].push(Transaction(amount, msg.sender, 0));
        emit WithdrawEvent(amount);
    }

    function deposit() public payable {
        transactionsHistory[msg.sender].push(Transaction(msg.value, msg.sender, 1));
        founds[msg.sender] += msg.value;
        emit DepositEvent(msg.value);
    }

    function getBalance() public view returns (uint256) {
       return founds[msg.sender];
    }

    function getTransactions() public view returns (Transaction[] memory){
        return transactionsHistory[msg.sender];
    }
} 