const { expect } = require("chai");

describe("SimpleLendingProtocol", function () {
  let token, lendingProtocol;
  let owner;

  beforeEach(async function () {
    // Deploy ERC20 token
    const MyToken = await ethers.getContractFactory("MyToken");
    token = await MyToken.deploy(ethers.utils.parseEther("1000000")); // 1 mil token

    // Deploy lending protocol
    const SimpleLendingProtocol = await ethers.getContractFactory("SimpleLendingProtocol");
    lendingProtocol = await SimpleLendingProtocol.deploy(token.address);

    // Get the owner address
    [owner] = await ethers.getSigners();
  });

  it("Should deploy the SimpleLendingProtocol correctly", async function () {
    expect(lendingProtocol.address).to.be.a('string');
    expect(lendingProtocol.address).to.have.lengthOf(42);
  });

  it("Should set the correct token address", async function () {
    expect(await lendingProtocol.token()).to.equal(token.address);
  });

  it("Should allow deposits of tokens", async function () {
    // Approve token and make a deposit
    await token.approve(lendingProtocol.address, ethers.utils.parseEther("1000"));
    await lendingProtocol.deposit(ethers.utils.parseEther("1000"));

    // Check the user's deposit balance
    const balance = await lendingProtocol.getDepositBalance(owner.address);
    expect(balance.eq(ethers.utils.parseEther("1000"))).to.be.true; // Use eq for BigNumber comparison
  });

  it("Should allow withdrawals of tokens", async function () {
    // First, make a deposit
    await token.approve(lendingProtocol.address, ethers.utils.parseEther("1000"));
    await lendingProtocol.deposit(ethers.utils.parseEther("1000"));

    // Perform a partial withdrawal
    await lendingProtocol.withdraw(ethers.utils.parseEther("500"));

    // Check the balance after withdrawal
    const balance = await lendingProtocol.getDepositBalance(owner.address);
    expect(balance.eq(ethers.utils.parseEther("500"))).to.be.true; // Gunakan eq untuk perbandingan BigNumber
  });
});
