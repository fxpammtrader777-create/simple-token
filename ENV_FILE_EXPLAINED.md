# .env File - What Each Field Does

## 📋 What is .env File?

**`.env` file** stores your configuration and secrets. It's used by Hardhat to deploy your contract.

**⚠️ Important**: Never share this file! It contains your private key.

---

## 🔑 Required Fields (Must Have)

### 1. PRIVATE_KEY
```
PRIVATE_KEY=your_private_key_here
```

**What it's for**:
- Your wallet's private key
- Used to sign transactions
- Needed to deploy contract
- **KEEP SECRET!**

**How to get**:
- From MetaMask: Account Details → Show Private Key

**Why needed**:
- Hardhat uses it to deploy contract
- Signs the deployment transaction
- Pays for gas fees

---

### 2. MUMBAI_RPC_URL
```
MUMBAI_RPC_URL=https://rpc-mumbai.maticvigil.com
```

**What it's for**:
- Connection to Mumbai testnet
- How Hardhat talks to blockchain
- Free public RPC endpoint

**Why needed**:
- Hardhat needs to connect to testnet
- Sends deployment transaction
- Checks your balance

**Already set**: ✅ This URL works, no need to change

---

## ⚠️ Optional Fields (Can Leave Empty)

### 3. POLYGON_RPC_URL
```
POLYGON_RPC_URL=https://polygon-rpc.com
```

**What it's for**:
- Connection to Polygon mainnet
- Only needed for mainnet deployment
- Not needed for testnet

**Why needed**:
- For mainnet deployment (later)
- Can leave as-is for now

---

### 4. POLYGONSCAN_API_KEY
```
POLYGONSCAN_API_KEY=your_polygonscan_api_key
```

**What it's for**:
- Auto-verify contract on Polygonscan
- Makes contract code public
- Optional - contract works without it

**Why needed**:
- Auto-verifies contract after deployment
- Without it: deploy works, but need to verify manually

**How to get** (optional):
1. Go to https://polygonscan.com/
2. Create account (free)
3. Go to API-KEYs section
4. Create new API key
5. Copy to `.env`

**Can leave empty**: ✅ Contract deploys without it

---

## 📝 Token Configuration (Optional)

These are optional - contract uses defaults if not set:

### TOKEN_NAME
```
TOKEN_NAME=Simple Token
```
**Default**: "Simple Token"  
**What**: Your token's name

### TOKEN_SYMBOL
```
TOKEN_SYMBOL=SIMPLE
```
**Default**: "SIMPLE"  
**What**: Your token's symbol (like BTC, ETH)

### TOTAL_SUPPLY
```
TOTAL_SUPPLY=10000000
```
**Default**: 10,000,000  
**What**: Total number of tokens to mint

### MARKETING_WALLET
```
MARKETING_WALLET=0x...
```
**Default**: Deployer address  
**What**: Where marketing tax goes (30% of taxes)

### LIQUIDITY_WALLET
```
LIQUIDITY_WALLET=0x...
```
**Default**: Deployer address  
**What**: Where liquidity tax goes (40% of taxes)

---

## 🎯 Minimum Required for Testnet

**For testnet deployment, you only need**:

```env
PRIVATE_KEY=your_private_key_here
MUMBAI_RPC_URL=https://rpc-mumbai.maticvigil.com
```

**That's it!** Everything else is optional.

---

## 📊 What Each Field Does

| Field | Required? | What It Does |
|-------|----------|-------------|
| **PRIVATE_KEY** | ✅ **YES** | Signs transactions, pays gas |
| **MUMBAI_RPC_URL** | ✅ **YES** | Connects to testnet |
| **POLYGON_RPC_URL** | ⚠️ Later | For mainnet (not needed now) |
| **POLYGONSCAN_API_KEY** | ❌ Optional | Auto-verifies contract |
| **TOKEN_NAME** | ❌ Optional | Token name (has default) |
| **TOKEN_SYMBOL** | ❌ Optional | Token symbol (has default) |
| **TOTAL_SUPPLY** | ❌ Optional | Token supply (has default) |
| **MARKETING_WALLET** | ❌ Optional | Marketing wallet (uses deployer) |
| **LIQUIDITY_WALLET** | ❌ Optional | Liquidity wallet (uses deployer) |

---

## 🔒 Security Notes

### What to Keep Secret:
- ✅ **PRIVATE_KEY** - Never share!
- ✅ **POLYGONSCAN_API_KEY** - Keep private

### What's Safe to Share:
- ✅ RPC URLs (public)
- ✅ Token configuration (public)
- ✅ Contract address (public after deployment)

---

## 🎯 Quick Setup

**Minimum `.env` file for testnet**:

```env
PRIVATE_KEY=your_private_key_from_metamask
MUMBAI_RPC_URL=https://rpc-mumbai.maticvigil.com
```

**Everything else can be empty or use defaults!**

---

## 💡 Summary

**Required**:
- `PRIVATE_KEY` - Your wallet key (to deploy)
- `MUMBAI_RPC_URL` - Testnet connection (already set)

**Optional**:
- Everything else - Has defaults or not needed for testnet

**Bottom Line**: Just add your `PRIVATE_KEY` and you're ready to deploy! 🚀
