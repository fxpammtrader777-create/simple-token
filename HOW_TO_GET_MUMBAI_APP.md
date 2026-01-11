# How to Get Mumbai App in Alchemy

## Step-by-Step Guide

### Step 1: Go to Alchemy Dashboard
1. Visit: **https://dashboard.alchemy.com/**
2. Sign in to your account (or create free account if needed)

### Step 2: Create New App
1. Click the **"Create App"** button (usually top right or in the apps list)
2. You'll see a form to fill out

### Step 3: Fill Out the Form
1. **App Name**: Enter any name (e.g., "Bird Token Mumbai" or "Mumbai Testnet")
2. **Description**: Optional - can leave blank or add description
3. **Network**: Select **"Polygon"** from the dropdown
4. **Chain**: Select **"Polygon Mumbai"** from the dropdown
   - ⚠️ Make sure it says "Mumbai" not "Mainnet"
   - If you don't see "Mumbai" option, see troubleshooting below

### Step 4: Create the App
1. Click **"Create App"** button
2. Wait a few seconds for it to be created

### Step 5: Get Your RPC URL
1. Click on your newly created Mumbai app
2. You'll see an **"API Key"** or **"View Key"** button
3. Click it to reveal your API key
4. Copy the **HTTP URL** - it looks like:
   ```
   https://polygon-mumbai.g.alchemy.com/v2/YOUR_API_KEY_HERE
   ```

### Step 6: Update Your .env File
1. Open your `.env` file
2. Find or add: `MUMBAI_RPC_URL=...`
3. Replace with your Mumbai RPC URL:
   ```env
   MUMBAI_RPC_URL=https://polygon-mumbai.g.alchemy.com/v2/YOUR_API_KEY_HERE
   ```
4. Replace `YOUR_API_KEY_HERE` with the actual key from Alchemy
5. Save the file

---

## 🆘 Troubleshooting

### "Mumbai" Not Showing in Chain Dropdown?

**Possible reasons:**
1. **Alchemy may have deprecated Mumbai** - Polygon is moving to Amoy testnet
2. **UI might be different** - look for "Testnet" options
3. **Try different network selection** - sometimes it's under "Polygon Testnet"

**Solutions:**
1. **Look for "Amoy"** - Polygon's new testnet (replaces Mumbai)
2. **Check if Mumbai is still supported** - may need to use different provider
3. **Use mainnet** - if you're ready for production

### Can't Find "Create App" Button?

1. Look in the **top navigation bar**
2. Or check the **"Apps"** section
3. Or try: **https://dashboard.alchemy.com/apps** and click **"Create App"**

### Already Have Apps But No Mumbai?

1. Go to your apps list
2. Check if any app is for Mumbai
3. If not, create a new one following steps above

---

## 📋 Alternative: Use Amoy Testnet

If Mumbai is not available, Polygon has moved to **Amoy testnet**:

1. Create app with:
   - Network: **Polygon**
   - Chain: **Polygon Amoy** (or "Amoy Testnet")
2. Get RPC URL (will be different format)
3. Update `hardhat.config.js` to use Amoy instead of Mumbai

---

## ✅ Quick Checklist

- [ ] Signed in to Alchemy
- [ ] Clicked "Create App"
- [ ] Selected "Polygon" network
- [ ] Selected "Polygon Mumbai" chain
- [ ] Copied the HTTP RPC URL
- [ ] Updated `.env` file with Mumbai RPC URL

---

## 🎯 After Getting Mumbai RPC URL

1. Update `.env` file
2. Run: `npm run deploy:testnet`
3. Your token will deploy to Mumbai testnet!

---

**Go to https://dashboard.alchemy.com/ and create a new app with Polygon Mumbai!**
