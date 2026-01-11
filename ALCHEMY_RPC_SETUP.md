# Using Your Alchemy RPC

## ✅ You Have an Alchemy RPC!

Your RPC URL: `https://polygon-mainnet.g.alchemy.com/v2/9yZaCrLfaEboDtgob1tal`

**Note**: This is for **Polygon Mainnet**, not Mumbai testnet.

---

## 🎯 For Mumbai Testnet Deployment

You need a **Mumbai testnet** RPC URL. Here's how to get it:

### Step 1: Go to Alchemy Dashboard
1. Visit: **https://dashboard.alchemy.com/**
2. Sign in to your account

### Step 2: Create Mumbai App (or Find Existing)
1. Click **"Create App"** (or find existing Mumbai app)
2. **Network**: Select **"Polygon"**
3. **Chain**: Select **"Polygon Mumbai"** (testnet)
4. Click **"Create App"**

### Step 3: Get Your Mumbai RPC URL
1. Click on your Mumbai app
2. Click **"View Key"** or **"API Key"**
3. Copy the **HTTP URL** (looks like):
   ```
   https://polygon-mumbai.g.alchemy.com/v2/YOUR_API_KEY
   ```

### Step 4: Update .env File
Replace `YOUR_API_KEY` with your actual Mumbai API key:

```env
MUMBAI_RPC_URL=https://polygon-mumbai.g.alchemy.com/v2/YOUR_MUMBAI_API_KEY
```

---

## 🚀 For Mainnet Deployment (If You Want)

If you want to deploy to **Polygon Mainnet** instead of testnet:

### Update .env:
```env
POLYGON_RPC_URL=https://polygon-mainnet.g.alchemy.com/v2/9yZaCrLfaEboDtgob1tal
```

### Deploy to Mainnet:
```bash
npm run deploy:mainnet
```

**⚠️ WARNING**: Mainnet uses real MATIC (real money). Make sure you're ready!

---

## 📋 Current Status

- ✅ You have Alchemy account
- ✅ You have Mainnet RPC
- ⏳ Need Mumbai testnet RPC for test deployment

---

## 💡 Recommendation

**For testing**: Get Mumbai testnet RPC (free, no real money)

**For production**: Use your mainnet RPC (costs real MATIC)

---

**Get your Mumbai RPC URL from Alchemy dashboard, then update `.env` file!**
