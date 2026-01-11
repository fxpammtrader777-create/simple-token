# Local Testing Options - What You Can Test Locally

## ✅ What We've Already Done

1. **Unit Tests** - `npm test`
   - ✅ 20/20 tests passing
   - ✅ All functions tested
   - ✅ Runs on Hardhat's local network automatically

## 🧪 Additional Local Tests You Can Do

### 1. **Local Deployment Test**
**Command:** `npm run deploy:local`

**What it does:**
- Deploys contract to local Hardhat network
- Creates a local blockchain on your computer
- Shows contract address
- Tests deployment process
- **FREE** - No real tokens needed

**What you'll see:**
```
Deploying contracts with account: 0x...
Account balance: 10000000000000000000000 (free test ETH)
Token deployed to: 0x...
```

---

### 2. **Interactive Console Testing**
**Command:** `npx hardhat console`

**What it does:**
- Opens interactive JavaScript console
- Connect to local Hardhat network
- Test contract functions manually
- Call functions directly

**Example usage:**
```javascript
const Token = await ethers.getContractFactory("Token");
const token = await Token.deploy("Test", "TEST", "1000000", ...);
await token.waitForDeployment();
const address = await token.getAddress();
console.log("Deployed to:", address);

// Test functions
await token.name(); // "Test"
await token.transfer("0x...", "1000");
```

---

### 3. **Gas Usage Testing**
**Command:** `REPORT_GAS=true npm test`

**What it does:**
- Runs all tests
- Shows gas usage for each function
- Helps optimize gas costs
- See which functions are expensive

**What you'll see:**
```
Token
  Deployment
    ✓ Should set the right name and symbol (gas: 123456)
    ✓ Should mint total supply to owner (gas: 234567)
```

---

### 4. **Specific Test Filtering**
**Command:** `npm test -- --grep "Deployment"`

**What it does:**
- Runs only tests matching the pattern
- Useful for testing specific features
- Faster feedback on specific areas

**Examples:**
```bash
npm test -- --grep "Deployment"    # Only deployment tests
npm test -- --grep "Buyback"       # Only buyback tests
npm test -- --grep "Tax"           # Only tax-related tests
```

---

### 5. **Local Hardhat Node**
**Command:** `npx hardhat node`

**What it does:**
- Starts a local blockchain node
- Runs in background
- Provides RPC endpoint: `http://127.0.0.1:8545`
- Can connect MetaMask to it
- Test with wallet interactions

**Usage:**
1. Terminal 1: `npx hardhat node` (keep running)
2. Terminal 2: `npm run deploy:local` (deploy to that node)
3. Connect MetaMask to `http://127.0.0.1:8545`

---

### 6. **Test Coverage (if installed)**
**Command:** `npx hardhat coverage`

**What it does:**
- Shows which code is tested
- Identifies untested functions
- Helps ensure complete testing

**Note:** Requires `solidity-coverage` package

---

## 🎯 Recommended Local Testing Flow

### **Step 1: Run Unit Tests**
```bash
npm test
```
✅ Already done - 20/20 passing

### **Step 2: Test Local Deployment**
```bash
npm run deploy:local
```
- Tests deployment process
- Verifies contract deploys correctly
- Shows contract address

### **Step 3: Interactive Testing (Optional)**
```bash
npx hardhat console
```
- Test functions manually
- Try different scenarios
- Debug issues

### **Step 4: Gas Analysis (Optional)**
```bash
REPORT_GAS=true npm test
```
- See gas costs
- Optimize if needed

---

## 📊 What Each Test Type Covers

| Test Type | What It Tests | Command |
|-----------|---------------|---------|
| **Unit Tests** | All functions, logic, edge cases | `npm test` |
| **Deployment** | Contract deployment process | `npm run deploy:local` |
| **Interactive** | Manual function calls | `npx hardhat console` |
| **Gas Usage** | Function gas costs | `REPORT_GAS=true npm test` |
| **Local Node** | Full blockchain simulation | `npx hardhat node` |

---

## 💡 Quick Start: Test Deployment Now

**Run this to test local deployment:**
```bash
npm run deploy:local
```

**What happens:**
1. Hardhat creates local blockchain
2. Deploys your contract
3. Shows contract address
4. Tests deployment works
5. **Takes ~10-30 seconds**

**No cost, no waiting, instant results!**

---

## 🔍 What Local Tests Verify

✅ **Contract compiles correctly**  
✅ **Deployment works**  
✅ **All functions work as expected**  
✅ **Gas costs are reasonable**  
✅ **No deployment errors**  
✅ **Contract address is generated**  
✅ **Initial state is correct**

---

*Local testing is FREE, instant, and verifies everything works before spending money on testnet/mainnet!*
