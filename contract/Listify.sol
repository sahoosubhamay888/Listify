// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/*
 * Simple decentralized coin flip betting game.
 * Demonstrates:
 *  - Mapping player bets
 *  - Pseudo-randomness (for demo)
 *  - Payout mechanism
 */

contract CoinFlip {
    address public owner;

    // Track total bets and player balances
    mapping(address => uint256) public playerBalances;

    event BetPlaced(address indexed player, uint256 amount, bool guess);
    event BetResult(address indexed player, bool won, uint256 payout);

    constructor() {
        owner = msg.sender;
    }

    // Allow players to place a bet
    // guess: true for Heads, false for Tails
    function placeBet(bool guess) external payable {
        require(msg.value > 0, "Bet must be greater than 0 ETH");

        emit BetPlaced(msg.sender, msg.value, guess);

        // Pseudo-random "coin flip"
        bool coinFlipResult = _flipCoin();

        if (coinFlipResult == guess) {
            uint256 payout = msg.value * 2;
            playerBalances[msg.sender] += payout;
            emit BetResult(msg.sender, true, payout);
        } else {
            emit BetResult(msg.sender, false, 0);
        }
    }

    // Player can withdraw winnings anytime
    function withdraw() external {
        uint256 amount = playerBalances[msg.sender];
        require(amount > 0, "No winnings to withdraw");
        playerBalances[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }

    // Owner can deposit or withdraw contract funds
    function ownerWithdraw(uint256 amount) external {
        require(msg.sender == owner, "Only owner");
        payable(owner).transfer(amount);
    }

    // --- INTERNAL FUNCTIONS ---

    // Generate a pseudo-random result (not secure!)
    function _flipCoin() internal view returns (bool) {
        // Uses blockhash and timestamp — predictable on mainnet!
        uint256 random = uint256(
            keccak256(abi.encodePacked(block.timestamp, block.prevrandao, msg.sender))
        );
        return (random % 2 == 0);
    }

    // Fallback: allow contract to receive ETH
    receive() external payable {}
}
