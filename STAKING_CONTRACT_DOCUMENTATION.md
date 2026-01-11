# StakingPool Contract - Documentation

**Contract**: `StakingPool.sol`  
**Version**: 1.0  
**Status**: Ready for Testing  
**Security**: ReentrancyGuard, Pausable, Input Validation

---

## 📋 Overview

The `StakingPool` contract is a separate, secure staking contract that works with the main Token contract. It implements treasury-based rewards with flexible and fixed-term staking options.

### Key Features

- ✅ **Separate Contract**: No modifications to main Token.sol (security maintained)
- ✅ **Flexible Staking**: No lock period, stake/unstake anytime
- ✅ **Fixed-Term Staking**: 30-day lock period for higher APY
- ✅ **Treasury-Based Rewards**: Sustainable rewards from transaction volume
- ✅ **Reward Per Share**: Accurate reward calculation
- ✅ **Security First**: ReentrancyGuard, Pausable, input validation

---

## 🏗️ Contract Architecture

### Pool Structure

```solidity
struct Pool {
    uint256 lockPeriod;      // 0 = flexible, >0 = fixed-term (seconds)
    uint256 rewardRate;      // APY in basis points (10000 = 100%)
    uint256 totalStaked;     // Total tokens staked
    uint256 totalRewards;    // Total rewards distributed
    uint256 rewardPerShare;  // Accumulated reward per share
    uint256 lastUpdateTime;  // Last update timestamp
    bool active;             // Pool is active
}
```

### User Stake Structure

```solidity
struct Stake {
    uint256 amount;          // Amount staked
    uint256 lockUntil;       // Lock expiration (0 = flexible)
    uint256 rewardDebt;      // Reward debt (for calculation)
    uint256 lastClaimTime;   // Last claim timestamp
}
```

---

## 🚀 Deployment Guide

### Step 1: Deploy StakingPool Contract

```javascript
// Deploy script
const StakingPool = await ethers.getContractFactory("StakingPool");
const stakingPool = await StakingPool.deploy(tokenAddress);
await stakingPool.waitForDeployment();
```

### Step 2: Configure Token Contract

```javascript
// Exempt staking contract from tax (optional, recommended)
await token.setTaxExemption(stakingPoolAddress, true);

// Exempt from buyback (optional, if staking receives treasury)
await token.setBuybackExemption(stakingPoolAddress, true);
```

### Step 3: Initialize Pools

```javascript
// Add flexible pool (0 lock period, 8% APY)
await stakingPool.addPool(0, 800); // 800 basis points = 8%

// Add 30-day fixed pool (30 days lock, 18% APY)
const thirtyDays = 30 * 24 * 60 * 60; // 30 days in seconds
await stakingPool.addPool(thirtyDays, 1800); // 1800 basis points = 18%
```

### Step 4: Fund Rewards Pool

```javascript
// Fund from treasury (25% of treasury = staking rewards)
const treasuryBalance = await token.getTreasuryBalance();
const stakingRewards = treasuryBalance * 25n / 100n;

// Withdraw from treasury to owner, then fund staking
await token.withdrawTreasury(ownerAddress, stakingRewards);
await token.approve(stakingPoolAddress, stakingRewards);
await stakingPool.fundRewards(stakingRewards);
```

---

## 📖 Function Reference

### Owner Functions

#### `addPool(uint256 _lockPeriod, uint256 _rewardRate)`
Add a new staking pool.

**Parameters:**
- `_lockPeriod`: Lock period in seconds (0 = flexible)
- `_rewardRate`: APY in basis points (10000 = 100%)

**Example:**
```javascript
// Flexible pool: 8% APY
await stakingPool.addPool(0, 800);

// 30-day pool: 18% APY
await stakingPool.addPool(2592000, 1800); // 30 days = 2,592,000 seconds
```

---

#### `updatePool(uint256 _poolId, uint256 _newRewardRate, bool _active)`
Update pool reward rate or active status.

**Parameters:**
- `_poolId`: Pool ID to update
- `_newRewardRate`: New APY (0 = no change)
- `_active`: Active status

**Example:**
```javascript
// Update pool 0 to 10% APY
await stakingPool.updatePool(0, 1000, true);

// Deactivate pool 1
await stakingPool.updatePool(1, 0, false);
```

---

#### `fundRewards(uint256 _amount)`
Fund the reward pool from treasury.

**Parameters:**
- `_amount`: Amount of tokens to add to reward pool

**Example:**
```javascript
// Fund 10,000 tokens
await token.approve(stakingPoolAddress, ethers.parseUnits("10000", 18));
await stakingPool.fundRewards(ethers.parseUnits("10000", 18));
```

---

#### `pause()` / `unpause()`
Emergency pause/unpause functionality.

**Example:**
```javascript
// Pause all staking operations
await stakingPool.pause();

// Resume operations
await stakingPool.unpause();
```

---

#### `emergencyWithdraw(address _user, uint256 _poolId)`
Emergency withdraw (bypasses lock period, owner only).

**Parameters:**
- `_user`: User to withdraw for
- `_poolId`: Pool ID

**Example:**
```javascript
// Emergency withdraw for user in pool 0
await stakingPool.emergencyWithdraw(userAddress, 0);
```

---

### User Functions

#### `stake(uint256 _poolId, uint256 _amount)`
Stake tokens in a pool.

**Parameters:**
- `_poolId`: Pool ID to stake in
- `_amount`: Amount of tokens to stake

**Example:**
```javascript
// Stake 1,000 tokens in flexible pool (pool 0)
await token.approve(stakingPoolAddress, ethers.parseUnits("1000", 18));
await stakingPool.stake(0, ethers.parseUnits("1000", 18));
```

---

#### `unstake(uint256 _poolId, uint256 _amount)`
Unstake tokens from a pool.

**Parameters:**
- `_poolId`: Pool ID to unstake from
- `_amount`: Amount of tokens to unstake

**Requirements:**
- Lock period must be expired (for fixed-term pools)
- Sufficient staked amount

**Example:**
```javascript
// Unstake 500 tokens from pool 0
await stakingPool.unstake(0, ethers.parseUnits("500", 18));
```

---

#### `claimRewards(uint256 _poolId)`
Claim pending rewards from a pool.

**Parameters:**
- `_poolId`: Pool ID to claim from

**Example:**
```javascript
// Claim rewards from pool 0
await stakingPool.claimRewards(0);
```

---

### View Functions

#### `getPendingRewards(address _user, uint256 _poolId)`
Get pending rewards for a user.

**Returns:** Pending reward amount

**Example:**
```javascript
const pending = await stakingPool.getPendingRewards(userAddress, 0);
console.log("Pending rewards:", ethers.formatUnits(pending, 18));
```

---

#### `getUserStakeInfo(address _user, uint256 _poolId)`
Get user stake information.

**Returns:**
- `amount`: Staked amount
- `lockUntil`: Lock expiration timestamp
- `pendingRewards`: Pending reward amount

**Example:**
```javascript
const [amount, lockUntil, pending] = await stakingPool.getUserStakeInfo(userAddress, 0);
console.log("Staked:", ethers.formatUnits(amount, 18));
console.log("Lock until:", new Date(Number(lockUntil) * 1000));
console.log("Pending:", ethers.formatUnits(pending, 18));
```

---

#### `getPoolInfo(uint256 _poolId)`
Get pool information.

**Returns:**
- `lockPeriod`: Lock period in seconds
- `rewardRate`: APY in basis points
- `totalStaked`: Total tokens staked
- `totalRewards`: Total rewards distributed
- `active`: Pool is active

**Example:**
```javascript
const [lockPeriod, rewardRate, totalStaked, totalRewards, active] = 
    await stakingPool.getPoolInfo(0);
console.log("APY:", Number(rewardRate) / 100, "%");
console.log("Total staked:", ethers.formatUnits(totalStaked, 18));
```

---

## 🔒 Security Features

### 1. ReentrancyGuard
- All critical functions protected
- Prevents reentrancy attacks

### 2. Input Validation
- Amount > 0 checks
- Pool existence checks
- Lock period validation
- Maximum limits (DoS protection)

### 3. Access Control
- Owner-only functions (addPool, fundRewards, etc.)
- User functions (stake, unstake, claimRewards)

### 4. Emergency Controls
- Pause functionality
- Emergency withdraw (owner only)
- Excess withdrawal (owner only)

### 5. Overflow Protection
- Solidity 0.8.20 (built-in)
- SafeERC20 for token transfers

---

## 💰 Reward Calculation

### Reward Per Share Method

Rewards are calculated using the "reward per share" method for accuracy:

```
rewardPerShare = totalRewards / totalStaked
userReward = (userStake × currentRewardPerShare) - userRewardDebt
```

### APY Calculation

Rewards are distributed based on APY:

```
dailyReward = (stakedAmount × APY) / 365
rewardPerSecond = dailyReward / 86400
```

### Example

**User stakes 1,000 tokens at 8% APY:**
- Daily reward: (1,000 × 0.08) / 365 = 0.219 tokens/day
- After 30 days: 0.219 × 30 = 6.57 tokens

---

## 📊 Integration with Tokenomics

### Treasury Allocation

**Current Flow:**
```
Transfer → 3% Tax → 30% to Treasury → Buyback & Burn
```

**With Staking:**
```
Transfer → 3% Tax → 30% to Treasury → 
    ├─ 25% to Staking Rewards (via owner withdrawal)
    └─ 75% to Buyback & Burn (as before)
```

### Recommended Setup

1. **Owner periodically funds staking** (weekly/monthly)
2. **25% of treasury** goes to staking rewards
3. **75% of treasury** continues to buyback/burn
4. **Staking contract exempt from tax** (optional, recommended)

---

## 🧪 Testing Checklist

### Unit Tests Required

- [ ] Pool creation and management
- [ ] Staking functionality (flexible and fixed-term)
- [ ] Unstaking functionality (lock period enforcement)
- [ ] Reward calculation accuracy
- [ ] Reward claiming
- [ ] Emergency functions
- [ ] Pause/unpause
- [ ] Reentrancy protection
- [ ] Input validation
- [ ] Edge cases (zero amounts, expired locks, etc.)

### Integration Tests Required

- [ ] Token contract integration
- [ ] Treasury funding flow
- [ ] Tax exemption (if applicable)
- [ ] Multiple users staking simultaneously
- [ ] Reward distribution accuracy

---

## 🚨 Important Notes

### Before Deployment

1. ✅ **Audit Required**: Staking contracts are high-risk, professional audit recommended
2. ✅ **Test Thoroughly**: Test all functions on testnet first
3. ✅ **Start Small**: Begin with lower APY, increase gradually
4. ✅ **Monitor Rewards**: Ensure reward pool is adequately funded

### After Deployment

1. ✅ **Fund Rewards Regularly**: Treasury-based funding should be automated or scheduled
2. ✅ **Monitor Pool Health**: Track total staked, rewards distributed, APY
3. ✅ **Community Communication**: Clear communication about APY, lock periods, risks

---

## 📈 Expected Performance

### Phase 1 (Launch)

**Pool 0 - Flexible:**
- APY: 5-10%
- Lock Period: 0 (flexible)
- Expected Stakers: 50-200 users

**Pool 1 - 30-Day Fixed:**
- APY: 15-20%
- Lock Period: 30 days
- Expected Stakers: 20-100 users

### Reward Sustainability

**Assumptions:**
- Daily trading volume: $100,000
- Token price: $0.10
- Treasury: 30% of 3% tax = 0.9% of volume
- Staking allocation: 25% of treasury = 0.225% of volume

**Daily Rewards:**
- Daily treasury: $100,000 × 0.009 = $900
- Daily staking rewards: $900 × 0.25 = $225
- Tokens staked: 5,000,000 = $500,000
- APY: ($225 × 365) / $500,000 = **16.4%**

---

## 🔄 Upgrade Path

### Phase 2: Additional Pools
- 90-day fixed-term pool (25-35% APY)
- Compound staking (stake rewards to earn more)

### Phase 3: DeFi Integration
- Aave lending integration
- QuickSwap LP staking
- Yield aggregation

---

**Contract Status**: Ready for Testing  
**Next Steps**: Create test suite, deploy to testnet, audit  
**Security Score**: TBD (after audit)

---

**Last Updated**: January 2026  
**Version**: 1.0
