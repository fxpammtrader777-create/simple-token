# Get Amoy Testnet MATIC

## ⚠️ Your Balance: 0 MATIC

You need testnet MATIC to deploy. Here's how to get it:

---

## ✅ Step-by-Step: Get Free Testnet MATIC

### Option 1: Polygon Faucet (Recommended)

1. **Go to**: https://faucet.polygon.technology/
2. **Select**: **"Amoy"** testnet (NOT Mumbai!)
3. **Enter your wallet address**:
   ```
   0x38bc73898FbDEEd5140E6933f4503052f5E9F631
   ```
4. **Click**: "Submit" or "Request"
5. **Wait**: 1-5 minutes for MATIC to arrive
6. **Check balance**: Run deployment again

---

### Option 2: Alchemy Faucet

1. **Go to**: https://www.alchemy.com/faucets/polygon-amoy
2. **Connect wallet** or enter address
3. **Request MATIC**
4. **Wait** for it to arrive

---

### Option 3: QuickNode Faucet

1. **Go to**: https://faucet.quicknode.com/polygon/amoy
2. **Enter your address**
3. **Request MATIC**

---

## 🔍 Verify You Got MATIC

**Check your balance**:
```bash
node -e "require('dotenv').config(); const { ethers } = require('ethers'); const provider = new ethers.JsonRpcProvider('https://polygon-amoy.g.alchemy.com/v2/9yZaCrLfaEboDtgob1tal'); const address = '0x38bc73898FbDEEd5140E6933f4503052f5E9F631'; provider.getBalance(address).then(b => console.log('Balance:', ethers.formatEther(b), 'MATIC'));"
```

**Or check in MetaMask**:
- Make sure you're on Amoy network (Chain ID: 80002)
- Your balance should show MATIC

---

## ⚠️ Important Notes

1. **Make sure you select AMOY**, not Mumbai (Mumbai is deprecated)
2. **Wait a few minutes** - faucets can be slow
3. **You may need to request multiple times** if first request doesn't give enough
4. **Check your wallet address is correct**: `0x38bc73898FbDEEd5140E6933f4503052f5E9F631`

---

## 💰 How Much Do You Need?

**Minimum**: ~0.01 MATIC (for deployment)
**Recommended**: 0.1-1 MATIC (for testing)

Most faucets give 0.1-0.5 MATIC per request.

---

## 🚀 After You Get MATIC

Once your balance shows MATIC (not 0), run:

```bash
npm run deploy:amoy
```

---

**Go to https://faucet.polygon.technology/ and select Amoy testnet!**
