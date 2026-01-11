# You Need a Separate Amoy App

## ⚠️ Important: Different Apps = Different API Keys

Your API key `9yZaCrLfaEboDtgob1tal` is for **Polygon Mainnet**.

**Amoy testnet requires a separate app with a different API key.**

---

## ✅ Create Amoy App in Alchemy

### Step 1: Go to Alchemy Dashboard
1. Visit: **https://dashboard.alchemy.com/**
2. Sign in

### Step 2: Create NEW App (Separate from Mainnet)
1. Click **"Create App"** button
2. **App Name**: `Bird Token Amoy` (or any name - different from mainnet app)
3. **Network**: Select **"Polygon"**
4. **Chain**: Select **"Polygon Amoy"** ⚠️ (NOT Mainnet!)
5. Click **"Create App"**

### Step 3: Get Amoy API Key
1. Click on your **new Amoy app** (separate from mainnet app)
2. Click **"View Key"** or **"API Key"**
3. Copy the **HTTP URL**
4. It will look like:
   ```
   https://polygon-amoy.g.alchemy.com/v2/YOUR_AMOY_API_KEY
   ```
   **This will be DIFFERENT from your mainnet key!**

### Step 4: Update .env File
Add the Amoy RPC URL:
```env
AMOY_RPC_URL=https://polygon-amoy.g.alchemy.com/v2/YOUR_AMOY_API_KEY
```

Replace `YOUR_AMOY_API_KEY` with the actual key from your Amoy app.

---

## 📋 Summary

- **Mainnet App**: Uses key `9yZaCrLfaEboDtgob1tal`
- **Amoy App**: Needs NEW app with DIFFERENT key
- **Each network needs its own app!**

---

## 🎯 Quick Steps

1. **Alchemy Dashboard** → Create App
2. **Select**: Polygon Amoy (NOT mainnet)
3. **Get**: New API key (different from mainnet)
4. **Update**: `.env` file with Amoy RPC URL
5. **Deploy**: `npm run deploy:amoy`

---

**Create a separate Amoy app in Alchemy to get your Amoy API key!**
