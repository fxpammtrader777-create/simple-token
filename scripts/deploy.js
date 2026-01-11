const hre = require("hardhat");
require("dotenv").config();

async function main() {
  const [deployer] = await hre.ethers.getSigners();
  
  console.log("Deploying contracts with account:", deployer.address);
  console.log("Account balance:", (await hre.ethers.provider.getBalance(deployer.address)).toString());

  // Get configuration from environment variables
  const tokenName = process.env.TOKEN_NAME || "Bird Token";
  const tokenSymbol = process.env.TOKEN_SYMBOL || "BIRD";
  const totalSupply = process.env.TOTAL_SUPPLY 
    ? hre.ethers.parseUnits(process.env.TOTAL_SUPPLY, 18)
    : hre.ethers.parseUnits("10000000", 18); // 10 million default
  
  // Validate wallet addresses - use deployer if invalid
  let marketingWallet = process.env.MARKETING_WALLET || deployer.address;
  let liquidityWallet = process.env.LIQUIDITY_WALLET || deployer.address;
  let publicSaleWallet = process.env.PUBLIC_SALE_WALLET || deployer.address;
  
  // Check if addresses are valid (start with 0x and are 42 chars)
  const isValidAddress = (addr) => {
    return addr && addr.startsWith('0x') && addr.length === 42 && /^0x[a-fA-F0-9]{40}$/.test(addr);
  };
  
  if (!isValidAddress(marketingWallet)) {
    console.log("⚠️  Invalid marketing wallet address, using deployer address");
    marketingWallet = deployer.address;
  }
  
  if (!isValidAddress(liquidityWallet)) {
    console.log("⚠️  Invalid liquidity wallet address, using deployer address");
    liquidityWallet = deployer.address;
  }
  
  if (!isValidAddress(publicSaleWallet)) {
    console.log("⚠️  Invalid public sale wallet address, using deployer address");
    publicSaleWallet = deployer.address;
  }

  console.log("\nDeployment Configuration:");
  console.log("Token Name:", tokenName);
  console.log("Token Symbol:", tokenSymbol);
  console.log("Total Supply:", hre.ethers.formatUnits(totalSupply, 18));
  console.log("Marketing Wallet:", marketingWallet);
  console.log("Liquidity Wallet:", liquidityWallet);
  console.log("Public Sale Wallet:", publicSaleWallet);

  // Deploy Token contract
  console.log("\nDeploying Token contract...");
  const Token = await hre.ethers.getContractFactory("Token");
  const token = await Token.deploy(
    tokenName,
    tokenSymbol,
    totalSupply,
    marketingWallet,
    liquidityWallet,
    publicSaleWallet
  );

  await token.waitForDeployment();
  const tokenAddress = await token.getAddress();

  console.log("Token deployed to:", tokenAddress);

  // Wait for block confirmations
  console.log("\nWaiting for block confirmations...");
  await token.deploymentTransaction().wait(5);

  // Verify contract on Polygonscan
  if (hre.network.name !== "hardhat" && process.env.POLYGONSCAN_API_KEY) {
    console.log("\nVerifying contract on Polygonscan...");
    try {
      await hre.run("verify:verify", {
        address: tokenAddress,
        constructorArguments: [
          tokenName,
          tokenSymbol,
          totalSupply,
          marketingWallet,
          liquidityWallet,
          publicSaleWallet
        ],
      });
      console.log("Contract verified successfully!");
    } catch (error) {
      console.log("Verification failed:", error.message);
    }
  }

  console.log("\n=== Deployment Summary ===");
  console.log("Network:", hre.network.name);
  console.log("Token Address:", tokenAddress);
  console.log("Deployer:", deployer.address);
  console.log("\nNext steps:");
  console.log("1. Add liquidity to DEX (QuickSwap)");
  console.log("2. Set pair address: token.setPairAddress(pairAddress)");
  console.log("3. Lock liquidity");
  console.log("4. Share contract address with community");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
