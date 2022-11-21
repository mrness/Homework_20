//Joint Savings Account


pragma solidity ^0.5.0;

contract JointSavings {

    address payable accountOne;
    address payable accountTwo;
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance;

    function withdraw(uint amount, address payable recipient) public {

        
        require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");
        require(amount <= contractBalance, "Insufficient Funds!");

        if (lastToWithdraw != recipient) {
            lastToWithdraw = recipient;
        }
    
        recipient.transfer(amount);

        lastWithdrawAmount = amount;

        contractBalance = address(this).balance;
    }

    function deposit() public payable {

        contractBalance = address(this).balance;
    }

    function setAccounts(address payable account1, address payable account2) public {

        accountOne = account1;
        accountTwo = account2;
    }

    /*
    Finally, add the **default fallback function** so that your contract can store Ether sent from outside the deposit function.
    */
    function() external payable {
        contractBalance = address(this).balance;
    }
}