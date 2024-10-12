const hre = require("hardhat");

async function main() {
  const SimpleLendingProtocol = await hre.ethers.getContractFactory("SimpleLendingProtocol");
  const tokenAddress = "0xYourTokenAddressHere"; // Ganti dengan alamat token ERC20
  const lendingContract = await SimpleLendingProtocol.deploy(tokenAddress);

  await lendingContract.deployed();

  console.log("SimpleLendingProtocol deployed to:", lendingContract.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
