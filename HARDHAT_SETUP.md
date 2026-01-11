# Hardhat Setup & Usage Guide

## ✅ We ARE Using Hardhat!

**Hardhat** is our development environment. All commands use Hardhat under the hood.

## 📦 Hardhat Configuration

### `hardhat.config.js`
- ✅ Configured for Polygon/Mumbai
- ✅ Solidity 0.8.20
- ✅ Network settings (Mumbai testnet, Polygon mainnet)
- ✅ Etherscan verification setup

### `package.json` Scripts (All Use Hardhat)
```json
{
  "compile": "hardhat compile",           // Compile contracts
  "test": "hardhat test",                 // Run tests
  "deploy:testnet": "hardhat run scripts/deploy.js --network mumbai",
  "deploy:mainnet": "hardhat run scripts/deploy.js --network polygon",
  "verify": "hardhat verify --network"    // Verify on Polygonscan
}
```

## 🚀 Hardhat Commands

### Development Commands

**Compile Contracts**:
```bash
npx hardhat compile
# or
npm run compile
```

**Run Tests**:
```bash
npx hardhat test
# or
npm test
```

**Run Specific Test**:
```bash
npx hardhat test test/Token.test.js
```

**Run Tests with Gas Report**:
```bash
REPORT_GAS=true npx hardhat test
```

### Deployment Commands

**Deploy to Mumbai Testnet**:
```bash
npx hardhat run scripts/deploy.js --network mumbai
# or
npm run deploy:testnet
```

**Deploy to Polygon Mainnet**:
```bash
npx hardhat run scripts/deploy.js --network polygon
# or
npm run deploy:mainnet
```

**Deploy to Local Hardhat Network**:
```bash
npx hardhat run scripts/deploy.js
```

### Verification Commands

**Verify Contract on Polygonscan**:
```bash
npx hardhat verify --network mumbai <CONTRACT_ADDRESS> "Token Name" "SYMBOL" 10000000 "0xMarketing" "0xLiquidity"
```

**Verify with Constructor Arguments File**:
```bash
npx hardhat verify --network mumbai <CONTRACT_ADDRESS> --constructor-args arguments.js
```

### Other Hardhat Commands

**Start Local Hardhat Node**:
```bash
npx hardhat node
```

**Run Console (Interactive)**:
```bash
npx hardhat console --network mumbai
```

**Clean Artifacts**:
```bash
npx hardhat clean
```

**Get Network Info**:
```bash
npx hardhat node --fork https://polygon-rpc.com
```

## 📁 Project Structure (Hardhat)

```
simple-token/
├── contracts/          # Solidity contracts
│   └── Token.sol
├── scripts/            # Deployment scripts
│   └── deploy.js
├── test/              # Test files
│   └── Token.test.js
├── hardhat.config.js  # Hardhat configuration
├── package.json        # Dependencies & scripts
└── .env                # Environment variables (create this)
```

## 🔧 Hardhat Configuration Details

### Networks Configured:
- **hardhat**: Local development network
- **mumbai**: Polygon Mumbai testnet
- **polygon**: Polygon mainnet

### Compiler Settings:
- **Solidity Version**: 0.8.20
- **Optimizer**: Enabled (200 runs)
- **EVM Version**: paris

## 🎯 Quick Start with Hardhat

### 1. Set Up Environment
```bash
# Create .env file
cp env.example .env

# Edit .env with:
PRIVATE_KEY=your_private_key_here
MUMBAI_RPC_URL=https://rpc-mumbai.maticvigil.com
POLYGON_RPC_URL=https://polygon-rpc.com
POLYGONSCAN_API_KEY=your_api_key_here
```

### 2. Compile Contracts
```bash
npm run compile
```

### 3. Run Tests
```bash
npm test
```

### 4. Deploy to Testnet
```bash
npm run deploy:testnet
```

### 5. Verify Contract
```bash
npx hardhat verify --network mumbai <CONTRACT_ADDRESS> "Token Name" "SYMBOL" 10000000 "0xMarketing" "0xLiquidity"
```

## 📝 Hardhat Scripts

### Deployment Script (`scripts/deploy.js`)
- Uses Hardhat's `ethers` provider
- Connects to configured network
- Deploys contract with constructor arguments
- Logs deployment address

### Test Scripts (`test/Token.test.js`)
- Uses Hardhat's test environment
- Uses `ethers` from Hardhat
- Uses `chai` for assertions
- Runs on Hardhat's local network

## 🔍 Hardhat Features We're Using

1. **Hardhat Network**: Local blockchain for testing
2. **Hardhat Compile**: Compiles Solidity contracts
3. **Hardhat Test**: Runs test suite
4. **Hardhat Deploy**: Deploys contracts
5. **Hardhat Verify**: Verifies contracts on block explorers
6. **Hardhat Console**: Interactive console for debugging

## ⚠️ Node.js Version Note

**Warning**: Node.js v24.9.0 not officially supported

**Hardhat Supported Versions**:
- Node.js 16.x
- Node.js 18.x
- Node.js 20.x

**Current Status**: 
- ✅ Works for development
- ✅ Tests pass
- ⚠️ May have unexpected behavior
- 💡 Consider using Node.js 18 or 20 for production

## 🎯 Summary

**We ARE using Hardhat!** 

All commands (`npm run compile`, `npm test`, `npm run deploy:testnet`) use Hardhat under the hood.

**Hardhat is**:
- ✅ Our development environment
- ✅ Our testing framework
- ✅ Our deployment tool
- ✅ Our verification tool

**Everything runs through Hardhat!**

---

**Next Step**: Set up `.env` file and deploy to testnet using Hardhat!
