# Gas Reporting in PowerShell

## ❌ Wrong (Linux/Bash Syntax)
```powershell
REPORT_GAS=true npm test
```
**This doesn't work in PowerShell!**

---

## ✅ Correct PowerShell Syntax

### **Method 1: Set Environment Variable First**
```powershell
$env:REPORT_GAS="true"
npm test
```

### **Method 2: Set and Run in One Line**
```powershell
$env:REPORT_GAS="true"; npm test
```

### **Method 3: Using PowerShell's Environment Variable Syntax**
```powershell
$env:REPORT_GAS = "true"
npm test
$env:REPORT_GAS = $null  # Clear it after
```

---

## 🎯 Quick Copy-Paste Commands

### **Run tests with gas report:**
```powershell
$env:REPORT_GAS="true"; npm test
```

### **Or set it first, then run:**
```powershell
$env:REPORT_GAS="true"
npm test
```

---

## 📊 What You'll See

When gas reporting is enabled, you'll see output like:
```
Token
  Deployment
    ✓ Should set the right name and symbol (gas: 123456)
    ✓ Should mint total supply to owner (gas: 234567)
```

---

## 🔄 Clear Environment Variable

After running, you can clear it:
```powershell
$env:REPORT_GAS = $null
```

Or just close the terminal - it resets automatically.

---

## 💡 Why It's Different

**Linux/Bash/Mac:**
```bash
REPORT_GAS=true npm test
```

**PowerShell (Windows):**
```powershell
$env:REPORT_GAS="true"; npm test
```

PowerShell uses `$env:VARIABLE_NAME="value"` syntax instead of `VARIABLE_NAME=value`.

---

*Use the PowerShell syntax for Windows!*
