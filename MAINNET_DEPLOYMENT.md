# Deploy to Polygon Mainnet

## ✅ Setup Complete

Your mainnet RPC is configured and ready!

---

## ⚠️ CRITICAL WARNINGS

**Mainnet uses REAL MATIC (real money):**
- Gas fees are real
- Transactions cost real money
- No way to undo transactions
- Make sure you're ready!

---

## 📋 Pre-Deployment Checklist

### 1. Update `.env` File
Add or update this line:
```env
POLYGON_RPC_URL=https://polygon-mainnet.g.alchemy.com/v2/9yZaCrLfaEboDtgob1tal
```

### 2. Verify Wallet Setup
- ✅ Private key in `.env` file
- ✅ Wallet has MATIC for gas fees (recommend at least 5-10 MATIC)
- ✅ MetaMask connected to **Polygon Mainnet** (Chain ID: 137)

### 3. Verify Token Settings
Check your `.env` file:
```env
TOKEN_NAME=Bird
TOKEN_SYMBOL=BIRD
TOTAL_SUPPLY=10000000
MARKETING_WALLET=your_marketing_wallet_address
LIQUIDITY_WALLET=your_liquidity_wallet_address
```

---

## 🚀 Deploy to Mainnet

```bash
npm run deploy:mainnet
```

---

## 📊 What Happens During Deployment

1. **Compiles** your contract
2. **Deploys** to Polygon Mainnet
3. **Waits** for 5 block confirmations
4. **Verifies** contract on Polygonscan (if API key set)
5. **Shows** contract address

---

## 💰 Estimated Costs

- **Deployment**: ~0.01-0.05 MATIC (gas fees)
- **Verification**: Free (if Polygonscan API key set)

**Total**: ~$0.01-0.05 USD (depending on MATIC price)

---

## ✅ After Deployment

1. **Save contract address** - you'll need it!
2. **Add liquidity** to DEX (QuickSwap, Uniswap V3, etc.)
3. **Set pair address** in contract
4. **Lock liquidity** (recommended)
5. **Share** with community

---

## 🔍 Verify on Polygonscan

After deployment, your contract will be at:
```
https://polygonscan.com/address/YOUR_CONTRACT_ADDRESS
```

---

## 🆘 Troubleshooting

### "Insufficient funds"
- Add more MATIC to your wallet
- Need at least 0.1 MATIC for safety

### "Network mismatch"
- Make sure MetaMask is on Polygon Mainnet
- Chain ID should be 137

### "RPC error"
- Check your `.env` file has correct RPC URL
- Verify API key is correct

---

## 📝 Next Steps After Deployment

1. **Add Liquidity**:
   - Go to QuickSwap or Uniswap V3
   - Add MATIC + BIRD tokens
   - Get pair address

2. **Set Pair Address**:
   ```javascript
   await token.setPairAddress(pairAddress);
   ```

3. **Lock Liquidity** (recommended):
   - Use a liquidity locker service
   - Lock for desired period

4. **Marketing**:
   - Share contract address
   - List on DEX aggregators
   - Build community

---

**Ready to deploy? Make sure you've updated `.env` and have MATIC in your wallet!**
