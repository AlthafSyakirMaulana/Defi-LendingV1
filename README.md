# DeFi-LendingV1

## Overview
DeFi-LendingV1 is a decentralized finance (DeFi) lending protocol that allows users to deposit, borrow, and repay ERC-20 tokens in a permissionless and decentralized way. The project aims to provide users with a transparent and secure platform for lending and borrowing assets, with features like collateral management, interest rate calculation, and liquidation.

## Features
- **Deposit & Withdraw**: Users can deposit ERC-20 tokens to earn interest, and withdraw their funds at any time.
- **Borrow & Repay**: Users can borrow tokens by providing collateral and repay the borrowed amount with interest.
- **Collateral Factor**: Borrowing is limited to a percentage of the collateral value (e.g., 75%).
- **Interest Rates**: Interest rates are calculated based on the utilization rate of the protocol.
- **Liquidation**: Positions can be liquidated if the collateral value falls below a certain threshold.

## Technologies Used
- **Solidity**: Smart contracts are written in Solidity (version 0.8.19).
- **OpenZeppelin**: Version 4.7.3 used for security features like ReentrancyGuard and Ownable.
- **Hardhat**: Development environment for compiling, deploying, and testing smart contracts.
- **JavaScript**: Scripts for deployment and testing.

## Installation
1. Clone the repository:
   ```sh
   git clone <repository-url>
   cd Defi-LendingV1
   ```

2. Install dependencies:
   ```sh
   npm install --legacy-peer-deps
   ```

3. Compile the smart contracts:
   ```sh
   npx hardhat compile
   ```

## Usage
### Running Tests
To run the tests:
```sh
npx hardhat test
```

### Deployment
To deploy the contracts to a local network:
```sh
npx hardhat run scripts/deploy.js --network localhost
```
To deploy to Sepolia testnet, ensure that you have the appropriate API keys set up in your `.env` file:
```sh
npx hardhat run scripts/deploy.js --network sepolia
```

## Project Structure
- **contracts/**: Contains all the smart contracts.
- **scripts/**: Deployment scripts.
- **test/**: Test files for the contracts.

## Configuration
Make sure to create a `.env` file in the root directory and add the following:
```
INFURA_API_KEY=<Your Infura API Key>
SEPOLIA_PRIVATE_KEY=<Your Sepolia Private Key>
ETHERSCAN_API_KEY=<Your Etherscan API Key>
```

## Specifications
- **OpenZeppelin Version**: 4.7.3
- **Solidity Version**: 0.8.19
- **Hardhat Version**: 2.12.13 (or compatible)
- **Node Version**: Recommended v18.x (or compatible)

## License
This project is licensed under the MIT License.