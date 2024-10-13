const hre = require("hardhat");

async function main() {
  const SimpleLendingProtocol = await hre.ethers.getContractFactory("SimpleLendingProtocol");
  const tokenAddress = "0xb308c308EDF35A7F31CF69689A7140997B7E5611"; // Ganti dengan alamat token ERC20
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
