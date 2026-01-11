# How to Deploy - Simple Step-by-Step

## 🚀 Quick Start (5 Steps)

### Step 1: Create .env File

**Option A - Copy example**:
```bash
cp env.example .env
```

**Option B - Create manually**:
1. Create new file named `.env` in `simple-token` folder
2. Copy this content:

```env
PRIVATE_KEY=your_private_key_here
MUMBAI_RPC_URL=https://rpc-mumbai.maticvigil.com
POLYGON_RPC_URL=https://polygon-rpc.com
POLYGONSCAN_API_KEY=
```

---

### Step 2: Get Your Private Key

**From MetaMask**:
1. Open MetaMask extension
2. Click your account (top right)
3. Click "Account Details" (or three dots → Account Details)
4. Click "Show Private Key"
5. Enter your MetaMask password
6. Copy the private key
7. Paste it in `.env` file (replace `your_private_key_here`)

**⚠️ Important**: 
- Remove `0x` from the beginning if it has one
- Keep this secret! Never share it.

**Example**:
```
PRIVATE_KEY=abc123def456... (your actual private key)
```

---

### Step 3: Get Testnet MATIC

**Easy Way**:
1. Open browser
2. Go to: https://faucet.polygon.technology/
3. Select "Mumbai" network
4. Paste your wallet address (from MetaMask)
5. Click "Submit"
6. Wait 10-30 seconds
7. Check MetaMask - you should have testnet MATIC

**Your wallet address** (from MetaMask):
- Click account name in MetaMask
- Copy the address (starts with 0x)
- Use this address at the faucet

**You need**: ~0.1 MATIC (faucet gives you enough)

---

### Step 4: Edit .env File

Open `.env` file and make sure it has:

```env
PRIVATE_KEY=your_actual_private_key_from_metamask
MUMBAI_RPC_URL=https://rpc-mumbai.maticvigil.com
POLYGON_RPC_URL=https://polygon-rpc.com
POLYGONSCAN_API_KEY=
```

**Save the file**

---

### Step 5: Deploy!

```bash
npm run deploy:testnet
```

**That's it!** The contract will deploy.

---

## 📋 What You'll See

When you run `npm run deploy:testnet`, you'll see:

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

=== Deployment Summary ===
Network: mumbai
Token Address: 0xContractAddressHere
```

**Save the contract address!**

---

## 🎯 Visual Guide

### 1. Create .env File
```
simple-token/
  ├── .env          ← Create this file
  ├── contracts/
  ├── scripts/
  └── ...
```

### 2. .env File Contents
```
PRIVATE_KEY=abc123...        ← Your MetaMask private key
MUMBAI_RPC_URL=https://...    ← Already correct
POLYGONSCAN_API_KEY=          ← Leave empty for now
```

### 3. Get MATIC
```
Browser → https://faucet.polygon.technology/
         ↓
    Enter wallet address
         ↓
    Get testnet MATIC
```

### 4. Deploy
```
Terminal → npm run deploy:testnet
         ↓
    Contract deploys
         ↓
    Get contract address
```

---

## ❓ Common Questions

### Q: Where do I find my private key?
**A**: MetaMask → Account Details → Show Private Key

### Q: Where do I find my wallet address?
**A**: MetaMask → Click account name → Copy address (starts with 0x)

### Q: What if I don't have MetaMask?
**A**: Install MetaMask extension, create wallet, then follow steps

### Q: What if deployment fails?
**A**: 
- Check you have testnet MATIC
- Check private key is correct (no 0x prefix)
- Check RPC URL is correct
- Try again

### Q: How long does it take?
**A**: 2-5 minutes

---

## 🔧 Troubleshooting

### Error: "Insufficient funds"
→ Get more testnet MATIC from faucet

### Error: "Invalid private key"
→ Check private key is correct (no 0x prefix)

### Error: "Network error"
→ Check RPC URL or try different one:
```
MUMBAI_RPC_URL=https://matic-mumbai.chainstacklabs.com
```

---

## ✅ Checklist

Before deploying:
- [ ] `.env` file created
- [ ] Private key added to `.env`
- [ ] Testnet MATIC in wallet
- [ ] RPC URL set

Ready to deploy:
- [ ] Run `npm run deploy:testnet`
- [ ] Save contract address
- [ ] Test on Polygonscan

---

## 🚀 Ready?

1. Create `.env` file
2. Add private key
3. Get testnet MATIC
4. Run `npm run deploy:testnet`

**Need help with any step?** Let me know!
