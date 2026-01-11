# Troubleshooting - What's Not Working?

## 🔍 Let's Figure Out What's Wrong

Tell me which part isn't working, and I'll help fix it!

---

## ❓ Common Issues & Solutions

### Issue 1: Can't Get Testnet MATIC from Faucet

**Symptoms**:
- Faucet says "already claimed"
- Faucet doesn't respond
- MATIC never arrives

**Solutions**:

**Option A: Try Different Faucets**
1. **Alchemy Faucet**: https://mumbaifaucet.com/
2. **QuickNode Faucet**: https://faucet.quicknode.com/polygon/mumbai
3. **Polygon Faucet**: https://faucet.polygon.technology/

**Option B: Wait and Retry**
- Wait 24 hours and try again
- Faucets have daily limits

**Option C: Use Different Wallet**
- Create new MetaMask wallet
- Get testnet MATIC for new wallet
- Use new wallet's private key

---

### Issue 2: Mumbai Network Not Showing

**Symptoms**:
- Can't find Mumbai in network list
- "Add Network" doesn't work

**Solutions**:

**Option A: Use Chainlist (Easiest)**
1. Go to: https://chainlist.org/
2. Connect MetaMask
3. Search "Mumbai"
4. Click "Add to MetaMask"
5. Done!

**Option B: Manual Add**
1. MetaMask → Settings → Networks
2. Click "Add Network"
3. Click "Add a network manually"
4. Enter:
   - Name: Mumbai Testnet
   - RPC: https://rpc-mumbai.maticvigil.com
   - Chain ID: 80001
   - Symbol: MATIC

---

### Issue 3: Balance Still Shows 0

**Symptoms**:
- Got MATIC from faucet
- Balance still 0
- Can't deploy

**Solutions**:

**Check These**:
1. ✅ Are you on "Mumbai Testnet" network? (not mainnet!)
2. ✅ Did you wait 5-10 minutes? (faucets can be slow)
3. ✅ Refresh MetaMask (switch networks, then back)
4. ✅ Check Polygonscan: https://mumbai.polygonscan.com/
   - Enter your wallet address
   - See if transaction is pending

**Try**:
- Different faucet
- Wait longer
- Check transaction on Polygonscan

---

### Issue 4: Deployment Fails

**Symptoms**:
- Error when running `npm run deploy:testnet`
- "Insufficient funds" error
- Network error

**Solutions**:

**Check**:
1. ✅ Private key in `.env` file? (no `0x` prefix)
2. ✅ On Mumbai Testnet network?
3. ✅ Have testnet MATIC? (> 0.01 MATIC)
4. ✅ RPC URL correct in `.env`?

**Try**:
- Different RPC URL:
  ```
  MUMBAI_RPC_URL=https://matic-mumbai.chainstacklabs.com
  ```

---

### Issue 5: MetaMask Not Working

**Symptoms**:
- Extension not showing
- Can't connect
- Errors in MetaMask

**Solutions**:

**Check**:
1. ✅ MetaMask extension enabled?
2. ✅ Browser refreshed?
3. ✅ MetaMask updated? (latest version)
4. ✅ Try different browser?

**Fix**:
- Reinstall MetaMask extension
- Update browser
- Try Chrome/Brave/Firefox

---

## 🎯 Quick Diagnostic

**Answer these to help me help you**:

1. **What exactly isn't working?**
   - [ ] Can't get testnet MATIC
   - [ ] Can't add Mumbai network
   - [ ] Balance still 0
   - [ ] Deployment fails
   - [ ] Something else?

2. **What error message do you see?**
   - Copy/paste the exact error

3. **What step are you on?**
   - [ ] Setting up MetaMask
   - [ ] Adding Mumbai network
   - [ ] Getting testnet MATIC
   - [ ] Deploying contract
   - [ ] Something else?

---

## 💡 Alternative: Skip Testnet for Now

**If testnet is too complicated**, you can:

1. **Wait and deploy to mainnet later** (after audit)
2. **Use a different testnet** (if available)
3. **Get help from someone** who has testnet MATIC

**But testnet is recommended** - it's free and safe to test!

---

## 🆘 Still Not Working?

**Tell me**:
1. What step you're on
2. What error you see (if any)
3. What you've tried

**I'll help you fix it!**

---

## 📋 Quick Checklist

**Before deploying, make sure**:
- [ ] MetaMask installed
- [ ] Mumbai Testnet network added
- [ ] On Mumbai Testnet network (not mainnet)
- [ ] Have testnet MATIC (> 0.01 MATIC)
- [ ] Private key in `.env` file
- [ ] RPC URL correct in `.env`

**If all checked, deployment should work!**

---

**What specifically isn't working? Let me know and I'll help fix it!**
