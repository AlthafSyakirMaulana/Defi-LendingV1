require("@nomiclabs/hardhat-ethers");
require("dotenv").config();

module.exports = {
  solidity: "0.8.19",
  networks: {
    sepolia: {
      url: `https://sepolia.infura.io/v3/${process.env.INFURA_API_KEY}`, // Menggunakan INFURA API dari .env
      accounts: [`0x${process.env.SEPOLIA_PRIVATE_KEY}`] // Menggunakan Sepolia Private Key dari .env
    },
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY // Untuk verifikasi kontrak jika diperlukan
  }
};
