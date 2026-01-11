# Wallet Addresses Explained (Lines 12-16)

## 📋 What Are These For?

These are **wallet addresses** - where different parts of your token's taxes go.

---

## 🔍 Lines 12-16 Breakdown

### Line 12: DECIMALS
```
DECIMALS=18
```

**What it's for**:
- Token decimals (how many decimal places)
- Standard is 18 (like ETH)
- **Note**: This is actually set in the contract, not used from .env
- **Can ignore** - contract uses 18 decimals

---

### Line 13: OWNER_ADDRESS
```
OWNER_ADDRESS=your_wallet_address
```

**What it's for**:
- Your wallet address (the deployer)
- Where tokens are minted to
- Who controls the contract initially

**How to get**:
- From MetaMask: Click account name → Copy address

**Why needed**:
- Tokens are minted to this address
- This address becomes contract owner
- Can be used for reference

**Note**: Hardhat automatically uses the deployer address, so this is optional

---

### Line 14: MARKETING_WALLET
```
MARKETING_WALLET=marketing_wallet_address
```

**What it's for**:
- Where **30% of transaction taxes** go
- Marketing/development fund
- Receives marketing portion of taxes

**Example**:
- Someone transfers 100 tokens
- 3% tax = 3 tokens
- 30% of tax = 0.9 tokens → goes to this wallet

**Options**:
1. **Use deployer address** (default if not set)
2. **Use separate wallet** (recommended)
3. **Use multi-sig wallet** (best for security)

**Recommendation**: Use a separate wallet or multi-sig

---

### Line 15: LIQUIDITY_WALLET
```
LIQUIDITY_WALLET=liquidity_wallet_address
```

**What it's for**:
- Where **40% of transaction taxes** go
- Liquidity pool fund
- Receives liquidity portion of taxes

**Example**:
- Someone transfers 100 tokens
- 3% tax = 3 tokens
- 40% of tax = 1.2 tokens → goes to this wallet

**Options**:
1. **Use deployer address** (default if not set)
2. **Use separate wallet** (recommended)
3. **Use multi-sig wallet** (best for security)

**Recommendation**: Use a separate wallet or multi-sig

---

## 💰 Tax Flow Example

**Transaction**: 100 tokens transferred

**Tax Breakdown** (3% = 3 tokens):
- 40% → `LIQUIDITY_WALLET` = 1.2 tokens
- 30% → `MARKETING_WALLET` = 0.9 tokens
- 30% → Treasury (for buyback) = 0.9 tokens

---

## 🎯 What You Should Do

### For Testnet (Now):
**Option 1: Use Same Address** (Simplest)
```
MARKETING_WALLET=0xYourDeployerAddress
LIQUIDITY_WALLET=0xYourDeployerAddress
```
- All taxes go to your deployer wallet
- Easy for testing
- Fine for testnet

**Option 2: Use Separate Addresses** (Better)
```
MARKETING_WALLET=0xMarketingWalletAddress
LIQUIDITY_WALLET=0xLiquidityWalletAddress
```
- Separate wallets for each purpose
- Better organization
- Recommended for mainnet

**Option 3: Leave Empty** (Uses Defaults)
```
MARKETING_WALLET=
LIQUIDITY_WALLET=
```
- Contract uses deployer address as default
- Works fine for testnet

---

### For Mainnet (Later):
**Use Multi-Sig Wallets** (Best)
```
MARKETING_WALLET=0xMultiSigMarketingAddress
LIQUIDITY_WALLET=0xMultiSigLiquidityAddress
```
- More secure
- Multiple signers required
- See `docs/MULTISIG_SETUP.md`

---

## ⚠️ Important Notes

### Security:
- **Don't use same wallet** for everything on mainnet
- **Use multi-sig** for tax wallets (recommended)
- **Keep private keys secure**

### For Testnet:
- ✅ Using same address is fine
- ✅ Can use deployer address
- ✅ Just for testing

### For Mainnet:
- ⚠️ Use separate wallets
- ⚠️ Use multi-sig (recommended)
- ⚠️ More secure

---

## 🎯 Quick Answer

**Q: What are these wallet addresses for?**
**A**: They determine where transaction taxes go:
- `MARKETING_WALLET` → Gets 30% of taxes
- `LIQUIDITY_WALLET` → Gets 40% of taxes
- Treasury → Gets 30% of taxes (for buyback)

**For testnet**: You can leave them empty or use your deployer address.

**For mainnet**: Use separate wallets or multi-sig.

---

## 📝 Summary

**Lines 12-16 are**:
- Wallet addresses for tax distribution
- Optional (contract uses defaults if not set)
- Can customize where taxes go

**Minimum needed**: Just `PRIVATE_KEY` - everything else has defaults!

---

**Bottom Line**: These are optional. For testnet, you can leave them empty and the contract will use your deployer address as default. For mainnet, use separate wallets or multi-sig for better security.
