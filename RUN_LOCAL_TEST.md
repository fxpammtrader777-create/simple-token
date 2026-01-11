# How to Run Local Test - Quick Guide

## ✅ Correct Way to Run Local Test

### **Step 1: Navigate to simple-token directory**
```powershell
cd simple-token
```

### **Step 2: Run the local test**
```powershell
npx hardhat run scripts/test-local.js
```

---

## ❌ Common Mistakes

### **Wrong Directory:**
```powershell
# ❌ DON'T run from: C:\Users\Smonr\Desktop\tokoen
# ✅ DO run from: C:\Users\Smonr\Desktop\tokoen\simple-token
```

### **Why it fails:**
- Hardhat needs to be in the project directory
- `package.json` must be in current directory
- `node_modules` must be accessible

---

## 🚀 Quick Commands

### **From parent directory:**
```powershell
cd simple-token
npx hardhat run scripts/test-local.js
```

### **Or in one line:**
```powershell
cd simple-token; npx hardhat run scripts/test-local.js
```

### **Or use npm script:**
```powershell
cd simple-token
npm run deploy:local
```

---

## 📍 Check Your Current Directory

**To see where you are:**
```powershell
pwd
# or
Get-Location
```

**You should see:**
```
C:\Users\Smonr\Desktop\tokoen\simple-token
```

**If you see:**
```
C:\Users\Smonr\Desktop\tokoen
```

**Then run:**
```powershell
cd simple-token
```

---

## ✅ Verify You're in Right Place

**Check for package.json:**
```powershell
Test-Path package.json
# Should return: True
```

**If it returns False, you're in wrong directory!**

---

## 🎯 Complete Example

```powershell
# 1. Navigate to project
cd C:\Users\Smonr\Desktop\tokoen\simple-token

# 2. Verify you're in right place
Test-Path package.json
# Should show: True

# 3. Run the test
npx hardhat run scripts/test-local.js
```

---

*Always make sure you're in the `simple-token` directory before running Hardhat commands!*
