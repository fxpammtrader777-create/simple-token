# Mainnet Tax Distribution - Complete Guide

## 📊 Tax Distribution Breakdown

### **Default Transaction Tax: 3%**

When someone transfers tokens on mainnet, **3% of the transfer amount** is collected as tax.

---

## 💰 How the 3% Tax is Distributed

### **Distribution Split:**

| Destination | Percentage | Amount (from 3% tax) |
|------------|------------|---------------------|
| **Liquidity Wallet** | 40% | 1.2% of transfer |
| **Marketing Wallet** | 30% | 0.9% of transfer |
| **Treasury** | 30% | 0.9% of transfer |
| **Total** | 100% | 3.0% of transfer |

---

## 📈 Example Calculation

### **Scenario: User transfers 1,000 BIRD tokens**

**Transfer Amount:** 1,000 BIRD

**Tax Collected (3%):** 30 BIRD

**Distribution:**
- **Liquidity Wallet:** 12 BIRD (40% of 30 = 1.2% of 1,000)
- **Marketing Wallet:** 9 BIRD (30% of 30 = 0.9% of 1,000)
- **Treasury:** 9 BIRD (30% of 30 = 0.9% of 1,000)

**User Receives:** 970 BIRD (97% of original)

---

## 🎯 What Each Wallet Does

### **1. Liquidity Wallet (40% of tax)**
**Purpose:**
- Add liquidity to DEX (QuickSwap, Uniswap, etc.)
- Maintain trading pairs
- Ensure smooth trading

**Example:** If 1,000 BIRD transferred:
- **12 BIRD** goes to liquidity wallet
- Used to add liquidity to trading pairs

---

### **2. Marketing Wallet (30% of tax)**
**Purpose:**
- Marketing campaigns
- Promotions
- Partnerships
- Community rewards
- Exchange listings

**Example:** If 1,000 BIRD transferred:
- **9 BIRD** goes to marketing wallet
- Used for marketing activities

---

### **3. Treasury (30% of tax)**
**Purpose:**
- Automatic buyback and burn
- Token price support
- Deflationary mechanism

**How it works:**
1. Treasury accumulates tokens
2. When threshold reached (100,000 BIRD default)
3. Automatic buyback and burn triggers
4. Tokens are burned (removed from supply)
5. Reduces total supply
6. Increases value per token

**Example:** If 1,000 BIRD transferred:
- **9 BIRD** goes to treasury
- Accumulates until 100,000 BIRD
- Then automatically burned

---

## 🔄 Complete Flow Example

### **User transfers 10,000 BIRD:**

```
Transfer: 10,000 BIRD
├── Tax (3%): 300 BIRD
│   ├── Liquidity: 120 BIRD (40%)
│   ├── Marketing: 90 BIRD (30%)
│   └── Treasury: 90 BIRD (30%)
└── User receives: 9,700 BIRD (97%)
```

---

## 📊 Treasury Buyback Mechanism

### **How Treasury Works:**

1. **Accumulation Phase:**
   - Every taxed transfer adds to treasury
   - Treasury grows: 9 BIRD, 18 BIRD, 27 BIRD...
   - Continues until threshold reached

2. **Buyback Threshold:**
   - Default: **100,000 BIRD**
   - Owner can change (max: 10,000,000 BIRD)
   - When treasury ≥ threshold → buyback triggers

3. **Automatic Burn:**
   - All treasury tokens burned
   - Supply decreases
   - Price per token increases
   - Cooldown: 1 hour between buybacks

4. **Repeat:**
   - Treasury resets to 0
   - Process repeats

---

## 💡 Real-World Example

### **If 1,000,000 BIRD is traded (total volume):**

**Tax Collected:** 30,000 BIRD (3% of 1M)

**Distribution:**
- **Liquidity:** 12,000 BIRD (40%)
- **Marketing:** 9,000 BIRD (30%)
- **Treasury:** 9,000 BIRD (30%)

**After ~11 trades of this size:**
- Treasury reaches 100,000 BIRD threshold
- Automatic buyback and burn triggers
- 100,000 BIRD burned
- Supply decreases
- Price increases

---

## 🔒 Tax Configuration

### **Current Settings:**
- **Default Tax:** 3% (300 basis points)
- **Maximum Tax:** 5% (500 basis points)
- **Minimum Tax:** 0% (0 basis points)
- **Owner Can Change:** ❌ **NO** - Tax is **PERMANENTLY LOCKED** by default from deployment
- **Can Be Locked:** Yes (irreversible)

### **Distribution Percentages (Fixed):**
- **Liquidity:** 40% (cannot be changed)
- **Marketing:** 30% (cannot be changed)
- **Treasury:** 30% (cannot be changed)

**Note:** Distribution percentages are **constants** - they cannot be changed after deployment.

---

## 🎯 Tax Exemptions

### **Who Doesn't Pay Tax:**

1. **Owner** - Excluded by default
2. **Contract Address** - Excluded by default
3. **Marketing Wallet** - Excluded by default
4. **Liquidity Wallet** - Excluded by default
5. **DEX Pair Address** - Excluded (set after liquidity added)
6. **Custom Exemptions** - Owner can add/remove

**Why:** Prevents tax on:
- Initial distribution
- DEX trading pairs
- Internal operations

---

## 📈 Impact on Tokenomics

### **Benefits of This Distribution:**

1. **Liquidity (40%):**
   - Ensures trading pairs stay liquid
   - Reduces price slippage
   - Makes trading easier

2. **Marketing (30%):**
   - Funds growth and adoption
   - Attracts new users
   - Builds community

3. **Treasury/Burn (30%):**
   - Deflationary mechanism
   - Reduces supply over time
   - Increases value per token
   - Price support

---

## 🔢 Mathematical Breakdown

### **For Every 100 BIRD Transferred:**

```
Original: 100 BIRD
├── Tax (3%): 3 BIRD
│   ├── Liquidity: 1.2 BIRD (40%)
│   ├── Marketing: 0.9 BIRD (30%)
│   └── Treasury: 0.9 BIRD (30%)
└── Received: 97 BIRD
```

### **For Every 1,000 BIRD Transferred:**

```
Original: 1,000 BIRD
├── Tax (3%): 30 BIRD
│   ├── Liquidity: 12 BIRD (40%)
│   ├── Marketing: 9 BIRD (30%)
│   └── Treasury: 9 BIRD (30%)
└── Received: 970 BIRD
```

### **For Every 10,000 BIRD Transferred:**

```
Original: 10,000 BIRD
├── Tax (3%): 300 BIRD
│   ├── Liquidity: 120 BIRD (40%)
│   ├── Marketing: 90 BIRD (30%)
│   └── Treasury: 90 BIRD (30%)
└── Received: 9,700 BIRD
```

---

## 🎯 Summary

### **Mainnet Tax Distribution:**

**Transaction Tax:** 3% (**PERMANENTLY LOCKED** - cannot be changed)

**Distribution:**
- **40% → Liquidity Wallet** (1.2% of transfer)
- **30% → Marketing Wallet** (0.9% of transfer)
- **30% → Treasury** (0.9% of transfer, used for buyback/burn)

**Treasury Buyback:**
- Triggers at 100,000 BIRD threshold
- Automatically burns tokens
- Reduces supply
- Increases value

**Tax Exemptions:**
- Owner, contract, wallets, DEX pairs excluded
- Prevents tax on internal operations

---

## 📝 Important Notes

1. **Distribution percentages are FIXED** - cannot be changed after deployment
2. **Tax rate is PERMANENTLY LOCKED** - locked at 3% from deployment, cannot be changed
3. **Treasury threshold can be changed** - owner can adjust (max 10M)
4. **Buyback is automatic** - triggers when threshold reached
5. **Cooldown protection** - 1 hour between buybacks (prevents front-running)

---

*This distribution structure is designed to balance liquidity, growth, and deflationary mechanisms for sustainable tokenomics.*
