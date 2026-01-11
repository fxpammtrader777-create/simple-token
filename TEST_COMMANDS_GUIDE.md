# Complete Test Commands Guide

## 📋 Table of Contents
1. [Basic Test Commands](#basic-test-commands)
2. [Filtered Test Commands](#filtered-test-commands)
3. [Gas Reporting](#gas-reporting)
4. [Local Testing](#local-testing)
5. [Advanced Options](#advanced-options)
6. [Quick Reference](#quick-reference)

---

## 🧪 Basic Test Commands

### Run All Tests
```powershell
npm test
```
**What it does:** Runs all 20 tests in the test suite  
**Output:** Shows pass/fail for each test, total time, and summary

---

### Run Specific Test File
```powershell
npx hardhat test test/Token.test.js
```
**What it does:** Runs only the Token test file (same as `npm test`)

---

### Run Tests with Verbose Output
```powershell
npm test -- --reporter spec
```
**What it does:** Shows detailed output for each test

---

## 🎯 Filtered Test Commands

### Run Tests Matching Pattern
```powershell
npm test -- --grep "Deployment"
```
**What it does:** Runs only tests with "Deployment" in the name

**Available filters:**
```powershell
npm test -- --grep "Deployment"    # Only deployment tests (5 tests)
npm test -- --grep "Buyback"       # Only buyback tests (3 tests)
npm test -- --grep "Tax"           # Only tax-related tests
npm test -- --grep "Owner"         # Only owner function tests (6 tests)
npm test -- --grep "Burn"          # Only burn tests
npm test -- --grep "Transaction"   # Only transaction tests
```

---

### Run Specific Test by Exact Name
```powershell
npm test -- --grep "Should set the right name and symbol"
```
**What it does:** Runs only the test with that exact name

---

### Exclude Tests Matching Pattern
```powershell
npm test -- --grep "Buyback" --invert
```
**What it does:** Runs all tests EXCEPT buyback tests

---

## 📊 Gas Reporting

### Run Tests with Gas Report (PowerShell)
```powershell
$env:REPORT_GAS="true"; npm test
```

### Alternative Method
```powershell
$env:REPORT_GAS="true"
npm test
$env:REPORT_GAS=$null  # Clear after
```

**What it does:** Shows gas usage for each function call  
**Output:** Displays gas costs next to each test

**Note:** PowerShell uses `$env:VARIABLE="value"` syntax, not `VARIABLE=value`

---

## 🚀 Local Testing

### Deploy to Local Hardhat Network
```powershell
npm run deploy:local
```
**What it does:**
- Deploys contract to local Hardhat network
- Shows contract address
- Tests deployment process
- **FREE** - No real tokens needed

---

### Run Interactive Local Test Demo
```powershell
npx hardhat run scripts/test-local.js
```
**What it does:**
- Deploys contract locally
- Runs 8 interactive tests
- Shows detailed output for each feature
- Demonstrates all functionality working

**Tests included:**
1. Check Initial State
2. Transfer from Owner (No Tax)
3. Transfer with Tax Applied
4. Check Tax Distribution
5. Set Tax Exemption
6. Transfer with Exemption
7. Burn Tokens
8. Owner Functions

---

## ⚙️ Advanced Options

### Stop on First Failure
```powershell
npm test -- --bail
```
**What it does:** Stops running tests after first failure  
**Use case:** Quick debugging

---

### Run Tests in Parallel
```powershell
npm test -- --parallel
```
**What it does:** Runs tests simultaneously (faster)  
**Warning:** May cause issues with shared state

---

### Skip Compilation
```powershell
npm test -- --no-compile
```
**What it does:** Skips compilation step (faster if contract unchanged)

---

### Custom Timeout
```powershell
npm test -- --timeout 60000
```
**What it does:** Sets test timeout to 60 seconds (default is 40 seconds)

---

### Different Output Formats
```powershell
npm test -- --reporter dot      # Minimal output (dots)
npm test -- --reporter spec     # Detailed output
npm test -- --reporter json     # JSON output
```

---

## 📝 Complete Command Examples

### Most Common Commands
```powershell
# Run all tests
npm test

# Test only deployment
npm test -- --grep "Deployment"

# Test with gas report
$env:REPORT_GAS="true"; npm test

# Local deployment test
npm run deploy:local

# Interactive demo
npx hardhat run scripts/test-local.js
```

### Combined Options
```powershell
# Test deployment with gas report
$env:REPORT_GAS="true"; npm test -- --grep "Deployment"

# Test buyback, stop on failure
npm test -- --grep "Buyback" --bail

# Test owner functions, verbose output
npm test -- --grep "Owner" --reporter spec
```

---

## 🎯 Quick Reference Table

| Command | What It Does | Use Case |
|---------|--------------|----------|
| `npm test` | Run all 20 tests | Regular testing |
| `npm test -- --grep "Deployment"` | Run only deployment tests | Quick check |
| `npm test -- --bail` | Stop on first failure | Debugging |
| `$env:REPORT_GAS="true"; npm test` | Show gas usage | Gas optimization |
| `npm run deploy:local` | Deploy to local network | Test deployment |
| `npx hardhat run scripts/test-local.js` | Interactive demo | See it working |
| `npm test -- --parallel` | Run tests in parallel | Faster execution |
| `npm test -- --no-compile` | Skip compilation | Faster if unchanged |

---

## 🔍 Test Categories

### Deployment Tests (5 tests)
```powershell
npm test -- --grep "Deployment"
```
- Should set the right name and symbol
- Should mint total supply to owner
- Should set correct wallets
- Should set default transaction tax to 3%
- Should exclude owner from tax

### Transaction Tests (3 tests)
```powershell
npm test -- --grep "Transaction"
```
- Should transfer tokens without tax for excluded addresses
- Should apply tax on regular transfers
- Should distribute tax correctly

### Tax Exemption Tests (2 tests)
```powershell
npm test -- --grep "Tax Exemption"
```
- Should allow owner to set tax exemption
- Should revert when non-owner tries to set exemption

### Buyback Tests (3 tests)
```powershell
npm test -- --grep "Buyback"
```
- Should accumulate treasury from taxes
- Should trigger buyback when threshold is reached
- Should allow manual buyback

### Owner Function Tests (6 tests)
```powershell
npm test -- --grep "Owner"
```
- Should allow owner to update transaction tax
- Should revert when tax exceeds maximum
- Should allow owner to update wallets
- Should allow owner to set pair address
- Should allow owner to set buyback threshold
- Should allow owner to withdraw treasury

### Burn Tests (1 test)
```powershell
npm test -- --grep "Burn"
```
- Should allow burning tokens

---

## 💡 Tips & Tricks

### Quick Test Cycle
```powershell
# 1. Run all tests
npm test

# 2. If failure, run specific category
npm test -- --grep "Buyback"

# 3. If still failing, run with bail
npm test -- --grep "Buyback" --bail
```

### Gas Optimization Workflow
```powershell
# 1. Run with gas report
$env:REPORT_GAS="true"; npm test

# 2. Identify expensive functions
# 3. Optimize code
# 4. Re-run to compare
$env:REPORT_GAS="true"; npm test
```

### Debugging Workflow
```powershell
# 1. Run all tests
npm test

# 2. Find failing test category
npm test -- --grep "CategoryName"

# 3. Run with verbose output
npm test -- --grep "CategoryName" --reporter spec

# 4. Stop on first failure
npm test -- --grep "CategoryName" --bail
```

---

## 🚨 Common Issues

### Gas Reporting Not Working
**Problem:** `REPORT_GAS=true npm test` doesn't work  
**Solution:** Use PowerShell syntax: `$env:REPORT_GAS="true"; npm test`

### Tests Running Slowly
**Solution:** Use `--no-compile` if contract hasn't changed:
```powershell
npm test -- --no-compile
```

### Too Much Output
**Solution:** Use minimal reporter:
```powershell
npm test -- --reporter dot
```

---

## 📚 Additional Resources

- **Test File:** `test/Token.test.js`
- **Local Test Script:** `scripts/test-local.js`
- **Deploy Script:** `scripts/deploy.js`
- **Hardhat Config:** `hardhat.config.js`

---

## ✅ Verification Commands

### Check You're in Right Directory
```powershell
pwd
# Should show: C:\Users\Smonr\Desktop\tokoen\simple-token

Test-Path package.json
# Should return: True
```

### Verify Contract Compiles
```powershell
npm run compile
```

### Check Test File Exists
```powershell
Test-Path test/Token.test.js
# Should return: True
```

---

*All commands work from the `simple-token` directory. Make sure you're in the right folder before running tests!*
