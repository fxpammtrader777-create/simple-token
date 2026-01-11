# All Available Test Commands

## 🧪 Basic Test Commands

### 1. **Run All Tests**
```powershell
npm test
```
**What it does:**
- Runs all 20 tests in `test/Token.test.js`
- Shows pass/fail for each test
- Total time and results

**Output:** 20 passing tests

---

### 2. **Run Tests with Verbose Output**
```powershell
npm test -- --reporter spec
```
**What it does:**
- Shows detailed output for each test
- More information about what's being tested

---

### 3. **Run Specific Test File**
```powershell
npx hardhat test test/Token.test.js
```
**What it does:**
- Runs only the Token test file
- Same as `npm test` but explicit

---

## 🎯 Filtered Test Commands

### 4. **Run Tests Matching Pattern**
```powershell
npm test -- --grep "Deployment"
```
**What it does:**
- Runs only tests with "Deployment" in the name
- Example: Only runs deployment tests

**Other examples:**
```powershell
npm test -- --grep "Buyback"     # Only buyback tests
npm test -- --grep "Tax"         # Only tax-related tests
npm test -- --grep "Owner"        # Only owner function tests
npm test -- --grep "Burn"         # Only burn tests
```

---

### 5. **Run Tests in Parallel**
```powershell
npm test -- --parallel
```
**What it does:**
- Runs tests simultaneously
- Faster execution
- Use with caution (may cause issues with shared state)

---

### 6. **Stop on First Failure**
```powershell
npm test -- --bail
```
**What it does:**
- Stops running tests after first failure
- Useful for quick debugging

---

## 📊 Gas Reporting Commands

### 7. **Run Tests with Gas Report**
```powershell
REPORT_GAS=true npm test
```
**What it does:**
- Shows gas usage for each function call
- Helps optimize gas costs
- See which functions are expensive

**Output includes:**
```
Token
  Deployment
    ✓ Should set the right name and symbol (gas: 123456)
```

---

## 🚀 Local Deployment & Testing

### 8. **Deploy to Local Network**
```powershell
npm run deploy:local
```
**What it does:**
- Deploys contract to local Hardhat network
- Shows contract address
- Tests deployment process
- **FREE** - No real tokens needed

---

### 9. **Run Interactive Local Test Demo**
```powershell
npx hardhat run scripts/test-local.js
```
**What it does:**
- Deploys contract locally
- Runs 8 interactive tests
- Shows detailed output for each test
- Demonstrates all features working

**Shows:**
- Contract deployment
- Transfers with/without tax
- Tax distribution
- Tax exemptions
- Token burning
- Owner functions

---

## 🔧 Advanced Test Commands

### 10. **Run Tests Without Compiling**
```powershell
npm test -- --no-compile
```
**What it does:**
- Skips compilation step
- Faster if contract hasn't changed
- Use when you know contract is already compiled

---

### 11. **Run Tests with Custom Timeout**
```powershell
npm test -- --timeout 60000
```
**What it does:**
- Sets test timeout to 60 seconds
- Useful for slow tests
- Default is 40 seconds (set in hardhat.config.js)

---

### 12. **Run Tests with Specific Network**
```powershell
npx hardhat test --network hardhat
```
**What it does:**
- Explicitly uses Hardhat network
- Same as default but explicit

---

## 🎨 Test Output Options

### 13. **Run Tests with Different Reporters**
```powershell
npm test -- --reporter dot          # Minimal output (dots)
npm test -- --reporter spec         # Detailed output
npm test -- --reporter nyan         # Fun output (if installed)
npm test -- --reporter json         # JSON output
```

---

## 📝 Test File Commands

### 14. **Run Specific Test by Name**
```powershell
npm test -- --grep "Should set the right name"
```
**What it does:**
- Runs only the test with that exact name
- Very specific filtering

---

### 15. **Run Tests Excluding Pattern**
```powershell
npm test -- --grep "Buyback" --invert
```
**What it does:**
- Runs all tests EXCEPT buyback tests
- Useful for excluding slow tests

---

## 🔍 Debugging Commands

### 16. **Run Tests with Debug Output**
```powershell
DEBUG=hardhat:* npm test
```
**What it does:**
- Shows detailed debug information
- Useful for troubleshooting

---

### 17. **Run Tests and Keep Node Running**
```powershell
npm test -- --no-exit
```
**What it does:**
- Keeps Node.js process running after tests
- Useful for debugging
- Note: Process won't exit automatically

---

## 🎯 Quick Reference

| Command | What It Does |
|---------|--------------|
| `npm test` | Run all tests |
| `npm test -- --grep "Deployment"` | Run only deployment tests |
| `npm test -- --bail` | Stop on first failure |
| `REPORT_GAS=true npm test` | Show gas usage |
| `npm run deploy:local` | Deploy to local network |
| `npx hardhat run scripts/test-local.js` | Interactive test demo |
| `npm test -- --parallel` | Run tests in parallel |
| `npm test -- --no-compile` | Skip compilation |

---

## 💡 Most Useful Commands

### **For Regular Testing:**
```powershell
npm test
```

### **For Quick Checks:**
```powershell
npm test -- --grep "Deployment"
```

### **For Gas Analysis:**
```powershell
REPORT_GAS=true npm test
```

### **For Interactive Demo:**
```powershell
npx hardhat run scripts/test-local.js
```

### **For Local Deployment:**
```powershell
npm run deploy:local
```

---

## 🎓 Example Usage

### **Test only buyback functionality:**
```powershell
npm test -- --grep "Buyback"
```

### **Test with gas report:**
```powershell
REPORT_GAS=true npm test -- --grep "Transfer"
```

### **Quick test of deployment:**
```powershell
npm test -- --grep "Deployment" --bail
```

---

*All these commands work from the `simple-token` directory!*
