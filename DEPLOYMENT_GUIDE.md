# Step-by-Step Deployment Guide

## 🚀 How to Deploy to Testnet

### Step 1: Create Environment File

```bash
# Copy the example file
cp env.example .env
```

**Or create `.env` file manually** with this content:

```env
# Deployer Wallet Private Key (without 0x prefix)
PRIVATE_KEY=your_private_key_here

# Mumbai Testnet RPC URL (free options)
MUMBAI_RPC_URL=https://rpc-mumbai.maticvigil.com
# Alternative: https://matic-mumbai.chainstacklabs.com

# Polygon Mainnet RPC URL (for later)
POLYGON_RPC_URL=https://polygon-rpc.com

# Polygonscan API Key (optional, for contract verification)
POLYGONSCAN_API_KEY=your_api_key_here

# Optional: Token Configuration
TOKEN_NAME=Simple Token
TOKEN_SYMBOL=SIMPLE
TOTAL_SUPPLY=10000000
MARKETING_WALLET=0xYourMarketingWallet
LIQUIDITY_WALLET=0xYourLiquidityWallet
```

**⚠️ Important**: 
- Never share your `.env` file
- Never commit it to git
- Keep your private key secure

---

### Step 2: Get Your Private Key

**If using MetaMask**:
1. Open MetaMask
2. Click account icon (top right)
3. Click "Account Details"
4. Click "Show Private Key"
5. Enter password
6. Copy private key (remove `0x` if present)

**⚠️ Security Warning**: 
- This is your deployer wallet
- Keep it secure
- Use a separate wallet for deployment (not your main wallet)

---

### Step 3: Get Testnet MATIC

**Option 1: Polygon Faucet** (Recommended)
1. Go to https://faucet.polygon.technology/
2. Select "Mumbai" network
3. Enter your wallet address
4. Click "Submit"
5. Wait for MATIC (usually instant)

**Option 2: Alchemy Faucet**
1. Go to https://mumbaifaucet.com/
2. Enter your wallet address
3. Complete captcha
4. Receive testnet MATIC

**Option 3: QuickNode Faucet**
1. Go to https://faucet.quicknode.com/polygon/mumbai
2. Enter your wallet address
3. Receive testnet MATIC

**You need**: ~0.1 MATIC (enough for deployment)

---

### Step 4: Set Up RPC URL

**Free RPC URLs for Mumbai Testnet**:
```
https://rpc-mumbai.maticvigil.com
https://matic-mumbai.chainstacklabs.com
https://rpc.ankr.com/polygon_mumbai
```

**Add to `.env`**:
```env
MUMBAI_RPC_URL=https://rpc-mumbai.maticvigil.com
```

---

### Step 5: (Optional) Get Polygonscan API Key

**For contract verification**:
1. Go to https://polygonscan.com/
2. Create account (free)
3. Go to API-KEYs section
4. Create new API key
5. Copy to `.env`

**Not required** - Contract will deploy without it, just won't auto-verify

---

### Step 6: Deploy to Testnet

```bash
# Make sure you're in the project directory
cd simple-token

# Deploy to Mumbai testnet
npm run deploy:testnet
```

**What happens**:
1. Hardhat compiles contract
2. Connects to Mumbai testnet
3. Deploys contract
4. Shows contract address
5. (Optional) Verifies on Polygonscan

**Expected output**:
```
Deploying contracts with account: 0xYourAddress
Account balance: 100000000000000000 (0.1 MATIC)

Deployment Configuration:
Token Name: Simple Token
Token Symbol: SIMPLE
Total Supply: 10000000
Marketing Wallet: 0x...
Liquidity Wallet: 0x...

Deploying Token contract...
Token deployed to: 0xContractAddress

Waiting for block confirmations...
Contract verified successfully!

=== Deployment Summary ===
Network: mumbai
Token Address: 0xContractAddress
Deployer: 0xYourAddress
```

---

### Step 7: Verify Contract (If Not Auto-Verified)

```bash
npx hardhat verify --network mumbai \
  0xContractAddress \
  "Simple Token" \
  "SIMPLE" \
  10000000000000000000000000 \
  0xMarketingWallet \
  0xLiquidityWallet
```

**Replace**:
- `0xContractAddress` with your contract address
- `"Simple Token"` with your token name
- `"SIMPLE"` with your token symbol
- `10000000000000000000000000` with total supply (in wei)
- `0xMarketingWallet` with marketing wallet address
- `0xLiquidityWallet` with liquidity wallet address

---

### Step 8: Test on Testnet

**Using Hardhat Console**:
```bash
npx hardhat console --network mumbai
```

**Then in console**:
```javascript
// Get contract instance
const Token = await ethers.getContractFactory("Token");
const token = await Token.attach("0xContractAddress");

// Check balance
const balance = await token.balanceOf("0xYourAddress");
console.log("Balance:", ethers.formatUnits(balance, 18));

// Test transfer
await token.transfer("0xRecipientAddress", ethers.parseUnits("100", 18));

// Check tax
const tax = await token.transactionTax();
console.log("Tax:", tax.toString(), "basis points (", tax/100, "%)");
```

**Or use Polygonscan**:
1. Go to https://mumbai.polygonscan.com/
2. Enter contract address
3. Use "Write Contract" tab
4. Connect wallet
5. Test functions

---

## 🔧 Troubleshooting

### Error: "Insufficient funds"
**Solution**: Get more testnet MATIC from faucet

### Error: "Nonce too high"
**Solution**: Wait a few minutes and try again

### Error: "Contract verification failed"
**Solution**: 
- Check API key is correct
- Verify constructor arguments match
- Try manual verification on Polygonscan

### Error: "Network error"
**Solution**: 
- Try different RPC URL
- Check internet connection
- Wait and retry

---

## 📋 Deployment Checklist

Before deploying:
- [ ] `.env` file created
- [ ] Private key added (without 0x)
- [ ] RPC URL configured
- [ ] Testnet MATIC in wallet (~0.1 MATIC)
- [ ] (Optional) Polygonscan API key added

After deploying:
- [ ] Contract address saved
- [ ] Contract verified on Polygonscan
- [ ] Tested basic functions
- [ ] Tested transfers
- [ ] Tested tax collection

---

## 🎯 Quick Command Reference

```bash
# Compile contract
npm run compile

# Run tests
npm test

# Deploy to testnet
npm run deploy:testnet

# Deploy to mainnet (after audit)
npm run deploy:mainnet

# Verify contract
npx hardhat verify --network mumbai <ADDRESS> <ARGS>
```

---

## 💡 Tips

1. **Use separate wallet** for deployment (not your main wallet)
2. **Save contract address** immediately after deployment
3. **Test everything** on testnet before mainnet
4. **Keep `.env` secure** - never share or commit
5. **Start with small amounts** when testing

---

## 🚀 Ready to Deploy?

1. Create `.env` file
2. Add your private key
3. Get testnet MATIC
4. Run `npm run deploy:testnet`

**Need help?** Let me know which step you're on!
