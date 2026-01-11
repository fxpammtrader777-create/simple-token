# Mumbai Deprecated - Use Amoy Testnet

## ⚠️ Important: Mumbai Testnet Deprecated

**Polygon Mumbai testnet was deprecated in April 2024.**

Polygon has moved to **Amoy testnet** as the replacement.

---

## ✅ Solution: Use Amoy Testnet

### Option 1: Get Amoy RPC from Alchemy

1. **Go to**: https://dashboard.alchemy.com/
2. **Click**: "Create App"
3. **Network**: Select "Polygon"
4. **Chain**: Select **"Polygon Amoy"** (NOT Mumbai)
5. **Click**: "Create App"
6. **Get RPC URL**: `https://polygon-amoy.g.alchemy.com/v2/YOUR_API_KEY`
7. **Update `.env`**:
   ```env
   MUMBAI_RPC_URL=https://polygon-amoy.g.alchemy.com/v2/YOUR_API_KEY
   ```

### Option 2: Get Amoy RPC from Infura

1. **Go to**: https://www.infura.io/
2. **Sign up** (free)
3. **Create project**
4. **Select**: "Polygon Amoy"
5. **Get RPC URL**
6. **Update `.env`**

---

## 🔧 Update Hardhat Config for Amoy

Update `hardhat.config.js` to use Amoy:

```javascript
amoy: {
  url: process.env.MUMBAI_RPC_URL || "https://polygon-amoy.g.alchemy.com/v2/YOUR_KEY",
  accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
  chainId: 80002,  // Amoy Chain ID
},
```

**Amoy Chain ID**: 80002 (different from Mumbai's 80001)

---

## 📋 Update MetaMask for Amoy

Add Amoy network to MetaMask:

- **Network Name**: Polygon Amoy
- **RPC URL**: Your Amoy RPC URL
- **Chain ID**: 80002
- **Currency Symbol**: MATIC
- **Block Explorer**: https://amoy.polygonscan.com/

---

## 🎯 Quick Setup Steps

1. **Get Amoy RPC** from Alchemy or Infura
2. **Update `.env`** with Amoy RPC URL
3. **Update `hardhat.config.js`** (add Amoy network, Chain ID 80002)
4. **Update MetaMask** to Amoy network
5. **Get testnet MATIC** from Amoy faucet
6. **Deploy**: `npm run deploy:testnet` (after updating config)

---

## 💡 Alternative: Deploy to Mainnet

If you're ready for production:

- Your mainnet RPC already works
- Deploy to Polygon Mainnet
- Uses real MATIC (real money)

---

## 📊 Summary

- ❌ **Mumbai**: Deprecated (April 2024)
- ✅ **Amoy**: New Polygon testnet
- ✅ **Mainnet**: Ready to use (your RPC works)

**Recommendation**: Use Amoy for testing, or deploy to mainnet if ready!

---

**Get Amoy RPC from Alchemy (select "Polygon Amoy" not Mumbai)!**
