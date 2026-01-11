# GitHub Security Guide - What to Commit

## ✅ SAFE to Commit to GitHub

### Source Code
- ✅ `contracts/` - All Solidity contracts (100% safe, public code)
- ✅ `test/` - All test files (safe, no secrets)
- ✅ `scripts/` - Deployment scripts (safe, uses env variables)

### Configuration Files
- ✅ `package.json` - Dependencies (safe)
- ✅ `package-lock.json` - Lock file (safe)
- ✅ `hardhat.config.js` - Configuration (safe, uses env variables)
- ✅ `env.example` - Example environment file (safe, no real secrets)

### Documentation
- ✅ `README.md` - Project readme
- ✅ `WHITEPAPER.md` - Complete white paper
- ✅ `docs/` - All documentation files
- ✅ All `.md` files - Documentation is safe

### Other Safe Files
- ✅ `.gitignore` - Git ignore rules
- ✅ `LICENSE` - License file (if you have one)

---

## ❌ NEVER Commit to GitHub

### Environment Variables & Secrets
- ❌ `.env` - Contains private keys and API keys
- ❌ `.env.local` - Local environment variables
- ❌ `*.env` - Any environment file with real secrets
- ❌ `private_key.txt` - Private keys in plain text
- ❌ `secrets.txt` - Any file with secrets

### Private Keys
- ❌ Any file containing private keys
- ❌ Wallet private keys
- ❌ API keys (Polygonscan, Alchemy, etc.)
- ❌ RPC URLs with API keys embedded

### Build Artifacts
- ❌ `artifacts/` - Compiled contracts (can be regenerated)
- ❌ `cache/` - Hardhat cache (can be regenerated)
- ❌ `node_modules/` - Dependencies (can be reinstalled)

### IDE & OS Files
- ❌ `.vscode/` - IDE settings (personal preference)
- ❌ `.idea/` - IDE settings
- ❌ `.DS_Store` - macOS files
- ❌ `Thumbs.db` - Windows files

---

## 🔒 Security Checklist Before Committing

### Before Your First Commit

1. **Check for .env files**
   ```bash
   # Make sure .env is in .gitignore
   cat .gitignore | grep .env
   ```

2. **Check for hardcoded secrets**
   ```bash
   # Search for potential secrets in code
   grep -r "0x[a-fA-F0-9]{64}" . --exclude-dir=node_modules
   grep -r "PRIVATE_KEY" . --exclude-dir=node_modules
   ```

3. **Verify .gitignore exists**
   ```bash
   ls -la .gitignore
   ```

4. **Check what will be committed**
   ```bash
   git status
   git diff --cached
   ```

### What to Look For

#### ❌ Red Flags (DO NOT COMMIT):
- Private keys (64 character hex strings starting with 0x)
- API keys in code
- Wallet addresses that reveal your identity
- Real RPC URLs with embedded keys
- Any file named `.env` or containing `PRIVATE_KEY=`

#### ✅ Safe to Commit:
- Contract source code
- Test files
- Documentation
- Configuration files that use `process.env.VARIABLE`
- Example files (env.example)

---

## 📋 Recommended GitHub Repository Structure

```
simple-token/
├── .gitignore              ✅ Commit
├── README.md              ✅ Commit
├── WHITEPAPER.md          ✅ Commit
├── package.json            ✅ Commit
├── package-lock.json       ✅ Commit
├── hardhat.config.js      ✅ Commit
├── env.example             ✅ Commit (template, no secrets)
├── contracts/              ✅ Commit (all Solidity files)
│   └── Token.sol
├── scripts/                ✅ Commit (deployment scripts)
│   └── deploy.js
├── test/                   ✅ Commit (all test files)
│   └── Token.test.js
├── docs/                   ✅ Commit (all documentation)
│   ├── TOKENOMICS.md
│   └── ...
├── .env                    ❌ NEVER COMMIT
├── node_modules/           ❌ NEVER COMMIT (in .gitignore)
├── artifacts/              ❌ NEVER COMMIT (in .gitignore)
└── cache/                  ❌ NEVER COMMIT (in .gitignore)
```

---

## 🚨 If You Accidentally Committed Secrets

### Immediate Actions

1. **Remove from Git History**
   ```bash
   # Remove file from history
   git rm --cached .env
   git commit -m "Remove .env file"
   ```

2. **If Already Pushed to GitHub**
   - **IMMEDIATELY** rotate/change all exposed secrets:
     - Generate new private keys
     - Get new API keys
     - Update all services
   - Consider the old keys compromised

3. **Clean Git History** (if needed)
   ```bash
   # Use git filter-branch or BFG Repo-Cleaner
   # This is advanced - get help if needed
   ```

4. **Update .gitignore**
   - Make sure .env is in .gitignore
   - Commit the updated .gitignore

---

## ✅ Safe Practices

### 1. Use Environment Variables
```javascript
// ✅ GOOD - Uses environment variable
const privateKey = process.env.PRIVATE_KEY;

// ❌ BAD - Hardcoded private key
const privateKey = "0x1234567890abcdef...";
```

### 2. Use env.example
- Keep `env.example` in repository
- Contains template with placeholder values
- Users copy it to `.env` and fill in real values
- `.env` is in `.gitignore`

### 3. Never Commit Real Secrets
- Private keys: ❌ Never commit
- API keys: ❌ Never commit
- Wallet addresses (if they reveal identity): ⚠️ Consider not committing
- Contract addresses (after deployment): ✅ Safe to commit (public anyway)

### 4. Review Before Committing
```bash
# Always check what you're committing
git status
git diff

# Review each file before adding
git add -p  # Interactive add
```

---

## 📝 Example: Safe Deployment Script

```javascript
// ✅ SAFE - Uses environment variables
require("dotenv").config();

const privateKey = process.env.PRIVATE_KEY; // From .env file
const rpcUrl = process.env.POLYGON_RPC_URL; // From .env file

// This is safe to commit - no secrets in code
```

---

## 🔍 Verification Commands

### Before Pushing to GitHub

```bash
# 1. Check for .env files
find . -name ".env" -not -path "./node_modules/*"

# 2. Check for private keys in code
grep -r "0x[a-fA-F0-9]\{64\}" . --exclude-dir=node_modules --exclude-dir=.git

# 3. Check git status
git status

# 4. Review what will be pushed
git log origin/main..HEAD  # See commits not yet pushed
```

---

## ✅ Final Checklist

Before pushing to GitHub, verify:

- [ ] `.env` file is in `.gitignore`
- [ ] No private keys in any committed files
- [ ] No API keys hardcoded in code
- [ ] `env.example` exists (template only)
- [ ] All source code is committed
- [ ] All documentation is committed
- [ ] `node_modules/` is in `.gitignore`
- [ ] `artifacts/` and `cache/` are in `.gitignore`

---

## 🎯 Summary

**SAFE to Commit:**
- ✅ Source code (contracts, tests, scripts)
- ✅ Documentation (README, white paper, guides)
- ✅ Configuration files (package.json, hardhat.config.js)
- ✅ Example files (env.example)

**NEVER Commit:**
- ❌ `.env` files with real secrets
- ❌ Private keys
- ❌ API keys
- ❌ Build artifacts (artifacts/, cache/, node_modules/)

**Remember**: If in doubt, don't commit it. You can always add it later, but removing secrets from Git history is difficult.

---

**Last Updated**: January 2026
