# Switch All Terminals to simple-token Folder

## Quick Command for Each Terminal

**Copy and paste this into EACH of your 3 terminals:**

```powershell
cd C:\Users\Smonr\Desktop\tokoen\simple-token
```

---

## Verify You're in the Right Place

**After running the command above, verify with:**

```powershell
pwd
```

**Should show:**
```
C:\Users\Smonr\Desktop\tokoen\simple-token
```

**Or check for package.json:**
```powershell
Test-Path package.json
```

**Should return:** `True`

---

## One-Line Verification

**Copy this to verify everything:**
```powershell
cd C:\Users\Smonr\Desktop\tokoen\simple-token; pwd; Test-Path package.json
```

**Should show:**
```
C:\Users\Smonr\Desktop\tokoen\simple-token
True
```

---

## For Each Terminal Window

1. **Terminal 1:** Paste `cd C:\Users\Smonr\Desktop\tokoen\simple-token`
2. **Terminal 2:** Paste `cd C:\Users\Smonr\Desktop\tokoen\simple-token`
3. **Terminal 3:** Paste `cd C:\Users\Smonr\Desktop\tokoen\simple-token`

---

## After Switching, You Can Run:

```powershell
# Run local test
npx hardhat run scripts/test-local.js

# Or run unit tests
npm test

# Or deploy locally
npm run deploy:local
```

---

*Make sure all 3 terminals are in the simple-token folder before running any commands!*
