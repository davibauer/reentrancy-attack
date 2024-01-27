// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../src/Vulnerable.sol";
import "../src/NonVulnerable.sol";
import "../src/Attacker.sol";

contract AttackTests is Test {
    Vulnerable vulnerable;
    NonVulnerable nonVulnerable;
    Attacker attackerVulnerable;
    Attacker attackerNonVulnerable;

    function setUp() public {
        vulnerable = new Vulnerable();
        nonVulnerable = new NonVulnerable();

        payable(address(vulnerable)).transfer(10 ether);
        payable(address(nonVulnerable)).transfer(10 ether);

        attackerVulnerable = new Attacker(payable(address(vulnerable)));
        attackerNonVulnerable = new Attacker(payable(address(nonVulnerable)));
    }

    function testAttackOnVulnerableContract() public {
        console.log("Start attack on vulnerable contract");
        console.log("Initial vulnerable balance:", address(vulnerable).balance);
        console.log(
            "Initial attacker balance:",
            address(attackerVulnerable).balance
        );

        attackerVulnerable.attack{value: 1 ether}();

        console.log(
            "Vulnerable balance after attack:",
            address(vulnerable).balance
        );
        console.log(
            "Attacker balance after attack:",
            attackerVulnerable.getBalance()
        );

        assertGt(
            attackerVulnerable.getBalance(),
            1 ether,
            "Attacker should have more than 1 ether"
        );
        assertLt(
            address(vulnerable).balance,
            10 ether,
            "Vulnerable should have less than 10 ether"
        );
    }

    function testAttackOnNonVulnerableContract() public {
        console.log("Start attack on non-vulnerable contract");
        console.log(
            "Initial non-vulnerable balance:",
            address(nonVulnerable).balance
        );
        console.log(
            "Initial attacker balance:",
            address(attackerNonVulnerable).balance
        );

        vm.expectRevert();
        attackerNonVulnerable.attack{value: 1 ether}();

        console.log(
            "Non-vulnerable balance after attack:",
            address(nonVulnerable).balance
        );
        console.log(
            "Attacker balance after attack:",
            address(attackerNonVulnerable).balance
        );

        assertEq(
            address(attackerNonVulnerable).balance,
            0,
            "Attacker should have 0 ether"
        );

        assertEq(
            address(nonVulnerable).balance,
            10 ether,
            "Non-vulnerable should have 10 ether"
        );
    }
}
