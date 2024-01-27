# Smart Contract Vulnerability: Reentrancy Attack

## Overview

This repository demonstrates a smart contract vulnerability with reentrancy attack, using Solidity. It includes a contract that is vulnerable to reentrancy (`Vulnerable.sol`) and an attacker contract (`Attacker.sol`) designed to exploit this vulnerability. As well as a non vulnerable contract (`NonVulnerable.sol`) with the fix implemented.

## Prevention Measures for Deployed Contracts

Once a smart contract is deployed, it is immutable and cannot be changed. Therefore, the following measures can be taken to prevent attacks:

### 1. Monitoring and Response

Monitoring the contract for suspicious activity and responding to it by pausing the contract or draining its funds can prevent further exploitation.

### 2. White-Hat Countermeasures

A white-hat attack could be employed to drain the funds from the vulnerable contract to a secure account to prevent malicious actors from exploiting the vulnerability.

### 3. Using Proxies for Upgradeability

If the contract was designed with upgradeability in mind the logic contract can be upgraded to a new version with the vulnerability fixed.

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test -vv
```

## Evidences

The tests in `test/` demonstrate the reentrancy attack and the fix.
