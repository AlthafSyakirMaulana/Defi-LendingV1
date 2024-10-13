const hre = require("hardhat");

async function main() {
  // Ambil kontrak MyToken yang ada di dalam folder contracts
  const MyToken = await hre.ethers.getContractFactory("MyToken");

  // Tentukan jumlah supply awal, misalnya 1 juta token
  const initialSupply = hre.ethers.utils.parseEther("1000000"); // 1 juta token

  // Deploy kontrak token dengan supply yang sudah ditentukan
  const myToken = await MyToken.deploy(initialSupply);

  // Tunggu hingga kontrak berhasil di-deploy
  await myToken.deployed();

  // Tampilkan alamat kontrak token yang sudah di-deploy
  console.log("Token ERC20 berhasil di-deploy ke alamat:", myToken.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
