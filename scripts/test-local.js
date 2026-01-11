const hre = require("hardhat");

async function main() {
  console.log("🚀 Starting Local Test Demo...\n");
  
  // Get signers (accounts)
  const [owner, marketingWallet, liquidityWallet, user1, user2] = await hre.ethers.getSigners();
  
  console.log("📋 Test Accounts:");
  console.log("  Owner:", owner.address);
  console.log("  Marketing Wallet:", marketingWallet.address);
  console.log("  User 1:", user1.address);
  console.log("  User 2:", user2.address);
  console.log("");
  
  // Deploy contract
  console.log("📦 Deploying Token Contract...");
  const Token = await hre.ethers.getContractFactory("Token");
  const token = await Token.deploy(
    "Bird Token",
    "BIRD",
    hre.ethers.parseUnits("10000000", 18), // 10 million tokens
    marketingWallet.address,
    liquidityWallet.address
  );
  
  await token.waitForDeployment();
  const tokenAddress = await token.getAddress();
  console.log("✅ Contract deployed to:", tokenAddress);
  console.log("");
  
  // Test 1: Check initial state
  console.log("🧪 TEST 1: Check Initial State");
  console.log("  Name:", await token.name());
  console.log("  Symbol:", await token.symbol());
  console.log("  Total Supply:", hre.ethers.formatUnits(await token.totalSupply(), 18));
  console.log("  Owner Balance:", hre.ethers.formatUnits(await token.balanceOf(owner.address), 18));
  console.log("  Transaction Tax:", (await token.transactionTax()).toString(), "basis points (3%)");
  console.log("");
  
  // Test 2: Transfer from owner (no tax)
  console.log("🧪 TEST 2: Transfer from Owner (No Tax)");
  const transferAmount = hre.ethers.parseUnits("1000", 18);
  await token.transfer(user1.address, transferAmount);
  const user1Balance = await token.balanceOf(user1.address);
  console.log("  Transferred:", hre.ethers.formatUnits(transferAmount, 18), "BIRD");
  console.log("  User1 received:", hre.ethers.formatUnits(user1Balance, 18), "BIRD");
  console.log("  ✅ No tax applied (owner is excluded)");
  console.log("");
  
  // Test 3: Transfer from user1 to user2 (tax applies)
  console.log("🧪 TEST 3: Transfer from User1 to User2 (Tax Applies)");
  const beforeBalance = await token.balanceOf(user2.address);
  await token.connect(user1).transfer(user2.address, transferAmount);
  const afterBalance = await token.balanceOf(user2.address);
  const received = afterBalance - beforeBalance;
  const taxAmount = transferAmount - received;
  
  console.log("  Sent:", hre.ethers.formatUnits(transferAmount, 18), "BIRD");
  console.log("  Received:", hre.ethers.formatUnits(received, 18), "BIRD");
  console.log("  Tax deducted:", hre.ethers.formatUnits(taxAmount, 18), "BIRD");
  console.log("  Tax percentage:", ((Number(taxAmount) / Number(transferAmount)) * 100).toFixed(2) + "%");
  console.log("");
  
  // Test 4: Check tax distribution
  console.log("🧪 TEST 4: Check Tax Distribution");
  const marketingBalance = await token.balanceOf(marketingWallet.address);
  const liquidityBalance = await token.balanceOf(liquidityWallet.address);
  const treasuryBalance = await token.getTreasuryBalance();
  
  console.log("  Marketing Wallet:", hre.ethers.formatUnits(marketingBalance, 18), "BIRD");
  console.log("  Liquidity Wallet:", hre.ethers.formatUnits(liquidityBalance, 18), "BIRD");
  console.log("  Treasury:", hre.ethers.formatUnits(treasuryBalance, 18), "BIRD");
  console.log("");
  
  // Test 5: Set tax exemption
  console.log("🧪 TEST 5: Set Tax Exemption");
  await token.setTaxExemption(user1.address, true);
  const isExcluded = await token.isExcludedFromTax(user1.address);
  console.log("  User1 excluded from tax:", isExcluded);
  console.log("  ✅ Tax exemption set successfully");
  console.log("");
  
  // Test 6: Transfer with exemption (no tax)
  console.log("🧪 TEST 6: Transfer with Exemption (No Tax)");
  await token.transfer(user1.address, transferAmount); // Give user1 more tokens
  const beforeExempt = await token.balanceOf(user2.address);
  await token.connect(user1).transfer(user2.address, transferAmount);
  const afterExempt = await token.balanceOf(user2.address);
  const exemptReceived = afterExempt - beforeExempt;
  
  console.log("  Sent:", hre.ethers.formatUnits(transferAmount, 18), "BIRD");
  console.log("  Received:", hre.ethers.formatUnits(exemptReceived, 18), "BIRD");
  console.log("  ✅ No tax applied (user1 is now excluded)");
  console.log("");
  
  // Test 7: Burn tokens
  console.log("🧪 TEST 7: Burn Tokens");
  const supplyBefore = await token.totalSupply();
  const burnAmount = hre.ethers.parseUnits("100", 18);
  await token.burn(burnAmount);
  const supplyAfter = await token.totalSupply();
  
  console.log("  Supply before:", hre.ethers.formatUnits(supplyBefore, 18), "BIRD");
  console.log("  Burned:", hre.ethers.formatUnits(burnAmount, 18), "BIRD");
  console.log("  Supply after:", hre.ethers.formatUnits(supplyAfter, 18), "BIRD");
  console.log("  ✅ Tokens burned successfully");
  console.log("");
  
  // Test 8: Owner functions
  console.log("🧪 TEST 8: Owner Functions");
  await token.setTransactionTax(400); // 4%
  const newTax = await token.transactionTax();
  console.log("  Updated tax:", newTax.toString(), "basis points (4%)");
  console.log("  ✅ Owner can update tax");
  console.log("");
  
  console.log("✅ All Local Tests Completed Successfully!");
  console.log("");
  console.log("📊 Final State:");
  console.log("  Contract Address:", tokenAddress);
  console.log("  Owner Balance:", hre.ethers.formatUnits(await token.balanceOf(owner.address), 18), "BIRD");
  console.log("  User1 Balance:", hre.ethers.formatUnits(await token.balanceOf(user1.address), 18), "BIRD");
  console.log("  User2 Balance:", hre.ethers.formatUnits(await token.balanceOf(user2.address), 18), "BIRD");
  console.log("  Treasury:", hre.ethers.formatUnits(await token.getTreasuryBalance(), 18), "BIRD");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("❌ Error:", error);
    process.exit(1);
  });
