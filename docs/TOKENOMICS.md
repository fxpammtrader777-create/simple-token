# Tokenomics - Bird Token

## Overview

Bird Token is designed with sustainable tokenomics that create value for holders while generating revenue for project development and marketing.

## Token Supply

**Total Supply**: 10,000,000 BIRD tokens

This supply was chosen for:
- Psychological appeal (higher per-token price)
- Good balance of scarcity and usability
- Can burn more later to increase value

## Distribution

### How Tokens Are Actually Distributed

**On Deployment:**
- **100% of tokens (10,000,000 BIRD) are minted to the owner**
- The contract does NOT automatically distribute tokens
- Owner receives all tokens and must distribute them manually

### Recommended Distribution Plan

After deployment, the owner should distribute tokens according to this plan:

| Allocation | Percentage | Amount | Purpose |
|------------|-----------|--------|---------|
| Treasury | 30% | 3,000,000 | For buyback/burn mechanism (stays in contract treasury) |
| Public Sale | 50% | 5,000,000 | Fair launch distribution to community |
| Liquidity | 20% | 2,000,000 | Initial DEX liquidity (should be locked) |

**Important Notes:**
- ⚠️ **This is a RECOMMENDED plan, not automatic**
- ⚠️ **Owner must manually transfer tokens after deployment**
- ⚠️ **No automatic vesting or locking in the contract**
- ⚠️ **Owner controls all tokens until distributed**
- ✅ **For transparency, owner should distribute as planned**
- ✅ **Liquidity should be locked using a locking service**

## Transaction Tax

**Tax Rate**: 3% (300 basis points)

Applied to all buys and sells, except:
- DEX pair addresses (exempt)
- Owner and contract addresses (exempt)
- Other exempt addresses set by owner

### Tax Distribution

| Destination | Percentage | Purpose |
|-------------|-----------|---------|
| Liquidity Pool | 40% | Auto-adds to liquidity, supports price |
| Marketing Wallet | 30% | Marketing campaigns, partnerships |
| Treasury | 30% | Accumulates for buyback and burn |

## Buyback & Burn Mechanism

### How It Works

1. **Treasury Accumulation**: 30% of transaction taxes go to treasury
2. **Threshold**: When treasury reaches 100,000 tokens
3. **Automatic Buyback**: Tokens are automatically burned
4. **Deflationary Effect**: Reduces supply, supports price

### Benefits

- **Deflationary**: Supply decreases over time
- **Price Support**: Buyback creates buying pressure
- **Automatic**: No manual intervention needed
- **Transparent**: All burns are on-chain

## Revenue Streams

### 1. Transaction Taxes
- **Source**: 3% on all trades
- **Frequency**: Every transaction
- **Sustainability**: Scales with volume

### 2. Treasury Accumulation
- **Source**: 30% of transaction taxes
- **Use**: Buyback and burn
- **Impact**: Deflationary pressure

### 3. Future Revenue (Optional)
- Staking fees
- NFT minting fees
- Partnership revenue

## Value Proposition

### For Holders
- **Deflationary**: Supply decreases over time
- **Price Support**: Buyback mechanism
- **Transparency**: Open source, verified contracts
- **Utility**: Can be used in future projects

### For Project
- **Sustainable Revenue**: Transaction taxes fund operations
- **Marketing Budget**: 30% of taxes for growth
- **Liquidity Support**: 40% of taxes for price stability

## Token Utility

### Current
- Trading on DEX
- Holding (deflationary asset)

### Future (Roadmap)
- Staking rewards
- Governance voting
- NFT minting
- Partnership integrations

## Economic Model

### Inflationary vs Deflationary

**Inflationary Factors**:
- None (fixed supply)

**Deflationary Factors**:
- Buyback and burn (automatic)
- Manual burns (optional)

**Net Effect**: **Deflationary** - supply decreases over time

### Price Support Mechanisms

1. **Transaction Taxes**: Discourage day trading, encourage holding
2. **Buyback & Burn**: Automatic price support
3. **Liquidity Addition**: 40% of taxes add to liquidity
4. **Locked Liquidity**: Initial liquidity is locked

## Risk Factors

### For Holders
- **Tax on Sells**: 3% tax applies to all sells
- **Market Risk**: Price can go up or down (controlled by market forces, not by owner or contract)
- **Liquidity Risk**: Low liquidity can cause slippage

**Price Control**: 
- **No one directly controls the price** - it's determined by supply and demand on the DEX (QuickSwap)
- **Market forces** (buyers and sellers) set the price
- **Contract mechanisms** can only **influence** price indirectly:
  - Buyback/burn reduces supply (can increase price if demand stays constant)
  - Liquidity addition (40% of taxes) can stabilize price
  - Transaction taxes affect trading behavior
- **Owner cannot manipulate price** - no functions exist to directly set or control price

### For Project
- **Regulatory Risk**: Crypto regulations may change
- **Market Risk**: Bear markets reduce trading volume
- **Competition**: Many similar projects exist

## Transparency Measures

1. **Open Source**: All code publicly available
2. **Verified Contracts**: Contracts verified on Polygonscan
3. **Public Treasury**: Treasury balance is public
4. **Clear Tokenomics**: This document explains everything
5. **Regular Updates**: Community updates on progress

## Vesting Schedule

**⚠️ IMPORTANT: The contract does NOT have automatic vesting or locking mechanisms built in.**

The contract automatically distributes tokens on deployment:
- **30% to contract treasury** (stays in contract, used for buyback/burn)
- **20% to liquidity wallet** (immediately available)
- **50% to public sale wallet** (immediately available)

### How Vesting Works (Manual Process)

Since the contract doesn't enforce vesting, the following is a **recommended plan** that should be implemented manually:

#### Treasury (30%)
- **Contract Behavior**: 30% (3,000,000 BIRD) is automatically minted to the contract treasury on deployment
- **Purpose**: Used for automatic buyback and burn mechanism
- **Access**: Only accessible via `withdrawTreasury()` function (owner only, with timelock if enabled)
- **Recommended Lock**: Owner should NOT withdraw from treasury (it's meant for buyback/burn)
- **Note**: Treasury is protected by contract - owner can withdraw, but this defeats the purpose of the buyback mechanism

#### Public Sale (50%)
- **Contract Behavior**: 50% (5,000,000 BIRD) is automatically minted to public sale wallet on deployment
- **Immediate Availability**: Tokens are immediately available to the public sale wallet
- **No Contract Lock**: Contract does not lock these tokens
- **Recommended Practice**: Public sale wallet should distribute tokens according to sale schedule
- **Manual Control**: The public sale wallet owner controls distribution timing

#### Liquidity (20%)
- **Contract Behavior**: 20% (2,000,000 BIRD) is automatically minted to liquidity wallet on deployment
- **Immediate Availability**: Tokens are immediately available to the liquidity wallet
- **No Contract Lock**: Contract does not lock these tokens
- **Recommended Practice**: 
  - Add liquidity to DEX (QuickSwap)
  - **Lock LP tokens** using a third-party service (e.g., Team Finance, Unicrypt)
  - This locks the liquidity provider tokens, not the BIRD tokens themselves
- **Purpose**: Price stability through locked liquidity

### Summary

| Allocation | Contract Behavior | Manual Action Required |
|------------|-------------------|------------------------|
| **Treasury (30%)** | Automatically minted to contract | Owner should NOT withdraw (defeats buyback purpose) |
| **Public Sale (50%)** | Automatically minted to public sale wallet | Wallet owner distributes according to sale schedule |
| **Liquidity (20%)** | Automatically minted to liquidity wallet | Add to DEX, then lock LP tokens externally |

**Key Point**: The contract ensures fair, automatic distribution (like Bitcoin), but vesting/locking must be handled manually or through external services (for LP tokens).

## Conclusion

Bird Token's tokenomics are designed for:
- **Sustainability**: Revenue from transaction taxes
- **Value Creation**: Deflationary mechanism
- **Transparency**: Open source and clear documentation
- **Growth**: Marketing budget for expansion

The combination of transaction taxes, buyback/burn, and locked liquidity creates a sustainable economic model that benefits both holders and the project.

---

**Last Updated**: January 2026
