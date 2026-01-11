# MetaMask Setup Guide

## 🦊 How to Install MetaMask

I can't install it for you, but here's how you can do it yourself:

---

## 📥 Step 1: Download MetaMask

### For Chrome/Brave/Edge:
1. Go to: https://metamask.io/
2. Click "Download"
3. Click "Install MetaMask for Chrome" (or your browser)
4. Click "Add to Chrome" (or your browser)
5. Click "Add Extension"

### For Firefox:
1. Go to: https://metamask.io/
2. Click "Download"
3. Click "Install MetaMask for Firefox"
4. Click "Add to Firefox"
5. Click "Add"

### For Mobile:
1. Go to App Store (iOS) or Google Play (Android)
2. Search "MetaMask"
3. Install the official MetaMask app

---

## 🔧 Step 2: Set Up MetaMask

### First Time Setup:
1. Click MetaMask extension icon
2. Click "Get Started"
3. Click "Create a Wallet"
4. Create password
5. **Save your Secret Recovery Phrase** (12 words)
6. Confirm recovery phrase

**⚠️ Important**: Save your recovery phrase securely! Write it down, don't screenshot it.

---

## 🌐 Step 3: Add Polygon Network

### For Testnet (Mumbai):
1. Open MetaMask
2. Click network dropdown (top, shows "Ethereum Mainnet")
3. Click "Add Network" or "Add a network manually"
4. Enter these details:

**Network Name**: Mumbai Testnet
**RPC URL**: https://rpc-mumbai.maticvigil.com
**Chain ID**: 80001
**Currency Symbol**: MATIC
**Block Explorer**: https://mumbai.polygonscan.com

5. Click "Save"

### For Mainnet (Polygon):
1. Open MetaMask
2. Click network dropdown
3. Click "Add Network" or "Add a network manually"
4. Enter these details:

**Network Name**: Polygon Mainnet
**RPC URL**: https://polygon-rpc.com
**Chain ID**: 137
**Currency Symbol**: MATIC
**Block Explorer**: https://polygonscan.com

5. Click "Save"

---

## 🔑 Step 4: Get Your Private Key

**For deployment**, you'll need your private key:

1. Open MetaMask
2. Click account icon (top right, shows account name)
3. Click "Account Details"
4. Click "Show Private Key"
5. Enter your MetaMask password
6. Copy the private key
7. **Remove `0x` from beginning** if it has one

**⚠️ Security**: 
- Never share your private key
- Only use it in `.env` file
- Keep `.env` file secure

---

## 💰 Step 5: Get Testnet MATIC

1. Make sure you're on "Mumbai Testnet" network
2. Copy your wallet address (click account name)
3. Go to: https://faucet.polygon.technology/
4. Select "Mumbai" network
5. Paste your wallet address
6. Click "Submit"
7. Wait 10-30 seconds
8. Check MetaMask - you should have testnet MATIC

---

## ✅ Quick Checklist

- [ ] MetaMask installed
- [ ] Wallet created
- [ ] Recovery phrase saved
- [ ] Polygon network added (Mumbai for testnet)
- [ ] Private key copied (for .env file)
- [ ] Testnet MATIC received

---

## 🎯 What You Need

**For deployment**:
1. ✅ MetaMask installed
2. ✅ Private key (for `.env` file)
3. ✅ Testnet MATIC (from faucet)

---

## 📝 Next Steps

After MetaMask is set up:
1. Copy your private key
2. Add to `.env` file: `PRIVATE_KEY=your_key_here`
3. Get testnet MATIC from faucet
4. Deploy: `npm run deploy:testnet`

---

## 🔒 Security Tips

1. **Never share**:
   - Private key
   - Recovery phrase
   - `.env` file

2. **Always verify**:
   - You're on correct network (Mumbai for testnet)
   - Website URLs are correct
   - You're using official MetaMask

3. **For testnet**:
   - Use separate wallet (not your main wallet)
   - Testnet tokens are worthless (safe to test)

---

## 🆘 Troubleshooting

### MetaMask not showing?
- Check browser extensions are enabled
- Refresh browser
- Reinstall if needed

### Can't add network?
- Make sure you're using correct RPC URL
- Check Chain ID is correct
- Try different RPC URL if one doesn't work

### No testnet MATIC?
- Make sure you're on Mumbai network
- Try different faucet
- Wait a few minutes and try again

---

## 🎉 Ready?

Once MetaMask is set up:
1. Get your private key
2. Add to `.env` file
3. Get testnet MATIC
4. Deploy your token!

---

**Need help with any step?** Let me know!
