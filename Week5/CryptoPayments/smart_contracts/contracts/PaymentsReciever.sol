// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

contract PaymentsReciever {
    address public owner = msg.sender;
    uint public last_completed_migration;

    bool private withdraw_inactive = false;

    struct Payment {
        uint amount;
        string shopHash;
        uint price;
    }

    mapping(address => Payment) payments;

    modifier restricted() {
        require(
            msg.sender == owner,
            "This function is restricted to the contract's owner"
        );
        _;
    }

    function pay(string memory shopHash, uint shopPrice) public payable {
        payments[msg.sender] = Payment(msg.value, shopHash, shopPrice);
    }

    function getPayment(address payer) public view restricted returns (uint amount, string memory shopHash, uint price) {
        Payment memory payment = payments[payer];
        amount = payment.amount;
        shopHash = payment.shopHash;
        price = payment.price;
    }

    function withdraw(uint amount, address payable reciever) public payable restricted {
        require(
            payments[msg.sender].amount >= amount,
            "Not enough money"
        );
        require(withdraw_inactive == false, "Withdraw is inactive");

        withdraw_inactive = true;
        payments[msg.sender].amount -= amount;
        reciever.transfer(amount);
        withdraw_inactive = false;
    }

    function setCompleted(uint completed) public restricted {
        last_completed_migration = completed;
    }

    function repairWithdraw() public restricted {
        withdraw_inactive = false;
    }
}