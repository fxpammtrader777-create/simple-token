# Simple Token - Profitable ERC-20 Token

A simple, transparent, and profitable ERC-20 token built on Polygon with transaction taxes, automatic buyback/burn, and sustainable tokenomics.

## 🎯 Overview

Simple Token is designed to be a legitimate, profitable token with:
- **3% transaction tax** (configurable, max 5%)
- **Automatic buyback and burn** when treasury threshold is reached
- **Transparent tokenomics** with clear distribution
- **Tax exemptions** for DEX pairs and contracts
- **Owner controls** for tax rates and wallet management

## ✨ Features

### Transaction Taxes
- 3% tax on all buys and sells (configurable up to 5%)
- Tax distribution:
  - 40% → Liquidity pool (auto-adds)
  - 30% → Marketing wallet
  - 30% → Treasury (for buyback)

### Buyback & Burn
- Automatic buyback when treasury reaches 100,000 tokens
- Manual buyback function available
- Deflationary mechanism supports token value

### Security
- Open source code (transparency)
- Comprehensive test coverage (90%+)
- ReentrancyGuard protection
- Owner controls with safety limits

## 📊 Tokenomics

**Total Supply**: 10,000,000 tokens

**Distribution**:
- 30% → Treasury (vested, locked for 6 months)
- 50% → Public sale / Fair launch
- 20% → Initial liquidity (locked)

**Transaction Tax**: 3%
- 40% → Liquidity
- 30% → Marketing
- 30% → Treasury (buyback fund)

**Buyback Threshold**: 100,000 tokens

## 🚀 Quick Start

### Prerequisites
- Node.js 16+ 
- npm or yarn
- Hardhat
- Polygon wallet with MATIC

### Installation

```bash
# Install dependencies
npm install

# Compile contracts
npm run compile

# Run tests
npm test
```

### Configuration

1. Copy `env.example` to `.env`
2. Fill in your configuration:
   - `PRIVATE_KEY`: Your wallet private key
   - `POLYGONSCAN_API_KEY`: For contract verification
   - Wallet addresses for marketing and liquidity

### Deployment

```bash
# Deploy to Mumbai testnet
npm run deploy:testnet

# Deploy to Polygon mainnet
npm run deploy:mainnet
```

## 📁 Project Structure

```
simple-token/
├── contracts/
│   └── Token.sol          # Main token contract
├── scripts/
│   └── deploy.js          # Deployment script
├── test/
│   └── Token.test.js      # Comprehensive tests
├── docs/
│   ├── TOKENOMICS.md      # Detailed tokenomics
│   └── ROADMAP.md         # Project roadmap
├── hardhat.config.js      # Hardhat configuration
└── package.json           # Dependencies
```

## 🔒 Security

- **Open Source**: All code is publicly available for review
- **Tested**: Comprehensive test suite with 90%+ coverage
- **Audited**: Ready for professional security audit
- **Transparent**: Verified contracts on Polygonscan

## 📝 Documentation

- [Tokenomics](docs/TOKENOMICS.md) - Detailed tokenomics explanation
- [Roadmap](docs/ROADMAP.md) - Project development roadmap

## 🛠️ Development

### Compile Contracts
```bash
npm run compile
```

### Run Tests
```bash
npm test
```

### Verify Contracts
```bash
npm run verify -- --network polygon <CONTRACT_ADDRESS>
```

## 📋 Pre-Launch Checklist

- [ ] Deploy to testnet
- [ ] Test all functionality
- [ ] Get community feedback
- [ ] Deploy to mainnet
- [ ] Verify contracts on Polygonscan
- [ ] Add initial liquidity
- [ ] Set DEX pair address
- [ ] Lock liquidity
- [ ] Launch marketing campaign

## 💰 Cost Breakdown

**Development**: FREE (open source)
**Deployment**: ~$5-10 (Polygon gas fees)
**Liquidity**: $100-500 (your choice)
**Total**: $5-10 + optional liquidity

## 🤝 Contributing

This is an open source project. Contributions are welcome!

## 📄 License

MIT License - see LICENSE file for details

## ⚠️ Disclaimer

This token is for educational and development purposes. Always do your own research (DYOR) before investing in any cryptocurrency project.

## 📞 Support

- GitHub Issues: For bug reports and feature requests
- Documentation: See `docs/` folder for detailed information

---

**Built with ❤️ for the Polygon ecosystem**
