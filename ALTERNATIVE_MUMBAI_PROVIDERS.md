# Alternative Mumbai Testnet Providers

## 🔍 Mumbai Not Available in Alchemy?

**Yes!** You can get Mumbai RPC from other providers:

---

## ✅ Option 1: Infura (Recommended)

### Get Free Mumbai RPC from Infura:

1. **Go to**: https://www.infura.io/
2. **Sign up** (free account)
3. **Create new project**
4. **Select network**: "Polygon Mumbai"
5. **Copy your RPC URL** (looks like):
   ```
   https://polygon-mumbai.infura.io/v3/YOUR_PROJECT_ID
   ```
6. **Update `.env`**:
   ```env
   MUMBAI_RPC_URL=https://polygon-mumbai.infura.io/v3/YOUR_PROJECT_ID
   ```

**Infura usually has Mumbai available!**

---

## ✅ Option 2: QuickNode

1. **Go to**: https://www.quicknode.com/
2. **Sign up** (free tier available)
3. **Create endpoint**
4. **Select**: Polygon Mumbai
5. **Copy RPC URL**
6. **Update `.env`**

---

## ✅ Option 3: Ankr (Requires API Key)

1. **Go to**: https://www.ankr.com/
2. **Sign up** (free)
3. **Create API key**
4. **Get Mumbai RPC URL**
5. **Update `.env`**

---

## ✅ Option 4: Public RPCs (No Signup)

Try these public endpoints (may be rate-limited):

```env
# Option A: Chainstack
MUMBAI_RPC_URL=https://matic-mumbai.chainstacklabs.com

# Option B: PublicNode (if still working)
MUMBAI_RPC_URL=https://polygon-mumbai-bor.publicnode.com
```

**Note**: Public RPCs may be unreliable or require API keys now.

---

## 🎯 Recommended: Use Infura

**Why Infura?**
- ✅ Usually has Mumbai available
- ✅ Free tier
- ✅ Reliable
- ✅ Easy setup

**Steps:**
1. Go to https://www.infura.io/
2. Sign up (free)
3. Create project → Polygon Mumbai
4. Get RPC URL
5. Update `.env`

---

## 📋 Update Your .env File

Once you have a Mumbai RPC URL from any provider:

1. Open `.env` file
2. Find: `MUMBAI_RPC_URL=...`
3. Replace with your new RPC URL
4. Save file
5. Deploy: `npm run deploy:testnet`

---

## 🔄 Alternative: Use Amoy Testnet

**If Mumbai is completely unavailable**, Polygon has moved to **Amoy testnet**:

1. Get Amoy RPC from any provider
2. Update `hardhat.config.js` to use Amoy (Chain ID: 80002)
3. Update MetaMask to Amoy network

---

## 💡 Quick Decision

**Want easiest option?** → Use **Infura** (usually has Mumbai)

**Want free public RPC?** → Try **Chainstack** (may require API key now)

**Ready for production?** → Use **Mainnet** (your Alchemy RPC works)

---

**Try Infura first - they usually have Mumbai available!**
