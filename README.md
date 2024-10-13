# DeFi-LendingV1

## Overview
DeFi-LendingV1 is a decentralized finance (DeFi) lending protocol that allows users to deposit, borrow, and repay ERC-20 tokens in a permissionless and decentralized manner. The project aims to provide a transparent and secure platform for lending and borrowing assets, featuring collateral management, interest rate calculation, and liquidation.

## Features
- **Deposit & Withdraw**: Earn interest by depositing ERC-20 tokens, and withdraw your funds at any time.
- **Borrow & Repay**: Borrow tokens by providing collateral and repay them with interest.
- **Collateral Factor**: Borrowing is limited to a percentage of the collateral value (e.g., 75%).
- **Interest Rates**: Calculated dynamically based on the utilization rate of the protocol.
- **Liquidation**: Positions can be liquidated if collateral value falls below a defined threshold.

## Technologies Used
- **Solidity**: Smart contracts written in Solidity (v0.8.19).
- **OpenZeppelin**: Security features (e.g., ReentrancyGuard, Ownable) using OpenZeppelin v4.7.3.
- **Hardhat**: Development environment for compiling, deploying, and testing smart contracts.
- **JavaScript**: Scripting for deployment and testing.

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
To run the tests, use the command:
```sh
npx hardhat test
```

### Deployment
#### 1. Deploy ERC-20 Token
Deploy the ERC-20 token contract with:
```sh
npx hardhat run scripts/deployToken.js --network <network>
```
Replace `<network>` with your desired network (e.g., `localhost` or `sepolia`).

#### 2. Deploy Lending Protocol
After deploying the token, update `deployLendingProtocol.js` with the token address, then deploy the lending protocol:
```sh
npx hardhat run scripts/deployLendingProtocol.js --network <network>
```

## Project Structure
- **contracts/**: Smart contracts.
  - **MyToken.sol**: ERC-20 token contract.
  - **SimpleLendingProtocol.sol**: Main lending protocol contract.
- **scripts/**: Deployment scripts.
  - **deployToken.js**: Deploys ERC-20 token.
  - **deployLendingProtocol.js**: Deploys lending protocol.
- **test/**: Test files for the contracts.

## Configuration
Create a `.env` file in the root directory with the following variables:
```
INFURA_API_KEY=<Your Infura API Key>
SEPOLIA_RPC_URL=https://sepolia.infura.io/v3/<Your Infura API Key>
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

---

Feel free to explore, contribute, or provide feedback!

