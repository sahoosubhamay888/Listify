<img width="1920" height="1020" alt="Contract" src="https://github.com/user-attachments/assets/d7925fcd-5034-480d-8ecc-0fb3e7f912a8" />
# 🪙 CoinFlip Smart Contract  

A simple **decentralized coin flip betting game** built with Solidity.  
This project demonstrates core blockchain and smart contract concepts in an easy-to-understand way — including bets, payouts, randomness, and on-chain event logging.  

> ⚠️ This project is for **educational purposes only** and **not secure for real betting** — it uses pseudo-randomness that can be manipulated on mainnet.  

---

## 📜 Project Description  

The **CoinFlip** contract allows users to place a bet on a virtual coin toss.  
- Players guess **Heads (true)** or **Tails (false)** and send some ETH.  
- If their guess is correct, they **win double** their bet.  
- If not, they lose the bet.  
- Winnings can be withdrawn at any time.  

This project is a great starting point to learn:  
- How Solidity manages **Ether transfers**  
- How to use **events** for tracking results  
- How **pseudo-randomness** works in simple demos  
- The structure of a **beginner-friendly dApp smart contract**

---

## 💡 What It Does  

1. Accepts ETH bets from players.  
2. Generates a pseudo-random outcome (“coin flip”).  
3. Rewards winners with double their wager.  
4. Keeps track of player balances.  
5. Lets players safely withdraw winnings anytime.  

---

## ✨ Features  

✅ **Easy to Use** — Players just send a bet and a guess (`true` or `false`).  
✅ **Transparent Results** — Every bet and outcome is logged on-chain via events.  
✅ **Owner Controls** — The contract owner can withdraw or deposit funds.  
✅ **Withdraw Anytime** — Players can claim their winnings anytime.  
✅ **Beginner-Friendly Solidity** — Clean, commented, and readable code.  

---

## 🔗 Deployed Smart Contract  

The CoinFlip contract is deployed on **Celo Sepolia Testnet**.  

🔹 **Transaction / Deployment Link:**  
[https://celo-sepolia.blockscout.com/tx/0x07f820098f4106317bd643d35cdb6da11eb5737e9847c3337c02fe54e5155d33](https://celo-sepolia.blockscout.com/tx/0x07f820098f4106317bd643d35cdb6da11eb5737e9847c3337c02fe54e5155d33)

---

## 🧩 Smart Contract Code  

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/*
 * Simple decentralized coin flip betting game.
 * ⚠️ Educational only — not secure for real ETH betting.
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
<img width="1920" height="1020" alt="Contract" src="https://github.com/user-attachments/assets/04c35969-77c9-47e6-bc50-054c5179be1b" />
