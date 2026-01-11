# Setup Amoy Testnet - Step by Step

## ✅ Configuration Updated!

I've added Amoy testnet to your `hardhat.config.js`.

---

## 📋 Next Steps

### Step 1: Get Amoy RPC from Alchemy

1. **Go to**: https://dashboard.alchemy.com/
2. **Sign in** to your account
3. **Click**: "Create App" button
4. **Fill out form**:
   - **App Name**: `Bird Token Amoy` (or any name)
   - **Network**: Select **"Polygon"**
   - **Chain**: Select **"Polygon Amoy"** ⚠️ (NOT Mumbai, NOT Mainnet)
5. **Click**: "Create App"
6. **Click** on your new Amoy app
7. **Click**: "View Key" or "API Key"
8. **Copy** the HTTP URL (looks like):
   ```
   https://polygon-amoy.g.alchemy.com/v2/YOUR_API_KEY
   ```

### Step 2: Update .env File

1. **Open** your `.env` file
2. **Add or update** this line:
   ```env
   AMOY_RPC_URL=https://polygon-amoy.g.alchemy.com/v2/YOUR_API_KEY
   ```
   Replace `YOUR_API_KEY` with your actual key from Alchemy

3. **Also keep** (for compatibility):
   ```env
   MUMBAI_RPC_URL=https://polygon-amoy.g.alchemy.com/v2/YOUR_API_KEY
   ```
   (Same URL - we're using it for Amoy now)

### Step 3: Add Amoy to MetaMask

1. **Open MetaMask**
2. **Click** network dropdown (top)
3. **Click** "Add Network" or "Add a network manually"
4. **Enter**:
   - **Network Name**: `Polygon Amoy`
   - **RPC URL**: Your Amoy RPC URL from Alchemy
   - **Chain ID**: `80002`
   - **Currency Symbol**: `MATIC`
   - **Block Explorer**: `https://amoy.polygonscan.com`
5. **Click** "Save"

### Step 4: Get Testnet MATIC

1. **Go to**: https://faucet.polygon.technology/
2. **Select**: "Amoy" testnet
3. **Enter** your wallet address
4. **Request** testnet MATIC (free)

### Step 5: Deploy to Amoy

```bash
npm run deploy:amoy
```

Or if that doesn't work, we can update the script.

---

## 🎯 Quick Checklist

- [ ] Created Amoy app in Alchemy
- [ ] Got Amoy RPC URL
- [ ] Updated `.env` file with `AMOY_RPC_URL`
- [ ] Added Amoy network to MetaMask
- [ ] Got testnet MATIC from faucet
- [ ] Ready to deploy!

---

## 📝 Alternative: Use Infura

If Alchemy doesn't work:

1. **Go to**: https://www.infura.io/
2. **Sign up** (free)
3. **Create project** → **Polygon Amoy**
4. **Get RPC URL**
5. **Update `.env`** with Infura RPC URL

---

## 🚀 After You Get RPC URL

**Share your Amoy RPC URL with me**, and I'll:
1. Update your `.env` file
2. Test the connection
3. Help you deploy!

---

**Go create your Amoy app in Alchemy and get the RPC URL!**
