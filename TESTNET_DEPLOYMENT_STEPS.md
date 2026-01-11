# Testnet Deployment - Step-by-Step Guide

## 🚀 Deploy to Mumbai Testnet

### Step 1: Create .env File ✅

**Already done!** The `.env` file has been created.

**Next**: You need to edit it with your information.

---

### Step 2: Get Your Private Key

**From MetaMask**:
1. Open MetaMask browser extension
2. Click your account (top right, shows account name)
3. Click "Account Details" (or three dots → Account Details)
4. Click "Show Private Key"
5. Enter your MetaMask password
6. Copy the private key
7. **Remove `0x` from the beginning** if it has one

**Example**: If MetaMask shows `0xabc123...`, use `abc123...`

---

### Step 3: Edit .env File

**Open `.env` file** in the `simple-token` folder.

**Find this line**:
```
PRIVATE_KEY=your_private_key_here
```

**Replace with your actual private key**:
```
PRIVATE_KEY=abc123def456...your_actual_key
```

**Save the file!**

---

### Step 4: Get Testnet MATIC

**Option 1: Polygon Faucet** (Recommended)
1. Open browser
2. Go to: https://faucet.polygon.technology/
3. Select "Mumbai" network
4. Enter your wallet address (from MetaMask)
5. Click "Submit"
6. Wait 10-30 seconds
7. Check MetaMask - you should have testnet MATIC

**Option 2: Alchemy Faucet**
1. Go to: https://mumbaifaucet.com/
2. Enter wallet address
3. Complete captcha
4. Receive MATIC

**You need**: ~0.1 MATIC (faucet gives you enough)

**Your wallet address** (from MetaMask):
- Click account name in MetaMask
- Copy address (starts with 0x)
- Use this at the faucet

---

### Step 5: Verify .env File

**Make sure `.env` has**:
```env
PRIVATE_KEY=your_actual_private_key
MUMBAI_RPC_URL=https://rpc-mumbai.maticvigil.com
POLYGON_RPC_URL=https://polygon-rpc.com
POLYGONSCAN_API_KEY=
```

**Important**:
- ✅ Private key has no `0x` prefix
- ✅ RPC URL is correct
- ✅ File is saved

---

### Step 6: Deploy to Testnet!

**Run this command**:
```bash
npm run deploy:testnet
```

**What happens**:
1. Hardhat compiles contract
2. Connects to Mumbai testnet
3. Deploys your token
4. Shows contract address
5. (Optional) Verifies on Polygonscan

**Expected output**:
```
Deploying contracts with account: 0xYourAddress
Account balance: 100000000000000000

Deployment Configuration:
Token Name: Simple Token
Token Symbol: SIMPLE
Total Supply: 10000000
Marketing Wallet: 0x...
Liquidity Wallet: 0x...

Deploying Token contract...
Token deployed to: 0xContractAddressHere

Waiting for block confirmations...
Contract verified successfully!

=== Deployment Summary ===
Network: mumbai
Token Address: 0xContractAddressHere
Deployer: 0xYourAddress
```

**Save the contract address!**

---

## 📋 Quick Checklist

Before deploying:
- [ ] `.env` file created ✅
- [ ] Private key added to `.env`
- [ ] Testnet MATIC in wallet (~0.1 MATIC)
- [ ] RPC URL correct

Ready to deploy:
- [ ] Run `npm run deploy:testnet`
- [ ] Save contract address
- [ ] Test on Polygonscan

---

## 🔧 Troubleshooting

### Error: "Insufficient funds"
**Solution**: Get more testnet MATIC from faucet

### Error: "Invalid private key"
**Solution**: 
- Check private key is correct
- Remove `0x` prefix if present
- Make sure no extra spaces

### Error: "Network error"
**Solution**: 
- Check internet connection
- Try different RPC URL:
  ```
  MUMBAI_RPC_URL=https://matic-mumbai.chainstacklabs.com
  ```

### Error: "Nonce too high"
**Solution**: Wait a few minutes and try again

---

## ✅ After Deployment

### 1. Save Contract Address
Copy the contract address from the output.

### 2. View on Polygonscan
Go to: https://mumbai.polygonscan.com/
Enter your contract address
View contract details

### 3. Test Functions
- Test transfers
- Test tax collection
- Test owner functions

---

## 🎯 Summary

**To deploy to testnet**:

1. ✅ `.env` file created (done!)
2. ⚠️ Add your private key to `.env`
3. ⚠️ Get testnet MATIC from faucet
4. ⚠️ Run `npm run deploy:testnet`

**That's it!** 🚀

---

**Ready?** Let me know when you've added your private key and got testnet MATIC, then we can deploy!
