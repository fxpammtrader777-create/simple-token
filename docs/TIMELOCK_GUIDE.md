# Timelock Guide

## Overview

Timelock adds a delay to critical functions, giving the community time to react to changes.

## How It Works

1. **Schedule**: Owner calls function (e.g., `setTransactionTax()`)
2. **Delay**: 24-hour delay (configurable)
3. **Execute**: After delay, owner calls execute function
4. **Community**: Can see pending changes and react

## Enabling Timelock

### Step 1: Enable Timelock

```javascript
// Via Remix, Hardhat, or frontend
await token.toggleTimelock(true);
```

### Step 2: Set Delay (Optional)

Default is 24 hours. You can change it:

```javascript
// Set to 48 hours (2 days)
await token.setTimelockDelay(2 * 24 * 60 * 60); // 172800 seconds
```

**Valid Range**: 1 hour to 7 days

## Using Timelock Functions

### Example: Changing Transaction Tax

#### Without Timelock (Immediate)
```javascript
await token.setTransactionTax(400); // Executes immediately
```

#### With Timelock (Delayed)
```javascript
// Step 1: Schedule the change
await token.setTransactionTax(400);
// Returns: Transaction scheduled, will execute in 24 hours

// Step 2: After 24 hours, execute
await token.executeSetTransactionTax(400);
// Returns: Tax updated to 4%
```

### Functions with Timelock

These functions support timelock when enabled:

1. **`setTransactionTax()`** → `executeSetTransactionTax()`
2. **`setMarketingWallet()`** → `executeSetMarketingWallet()`
3. **`setLiquidityWallet()`** → `executeSetLiquidityWallet()`
4. **`withdrawTreasury()`** → `executeWithdrawTreasury()`

## Checking Timelock Status

### Check if Operation is Ready

```javascript
const operationId = ethers.utils.keccak256(
  ethers.utils.defaultAbiCoder.encode(
    ["string", "uint256"],
    ["setTransactionTax", 400]
  )
);

const isReady = await token.isTimelockReady(operationId);
// Returns: true if 24 hours have passed
```

### Get Execution Time

```javascript
const executeTime = await token.getTimelockTime(operationId);
// Returns: Unix timestamp when operation can execute
```

## Canceling Scheduled Operations

Owner can cancel scheduled operations:

```javascript
const operationId = ethers.utils.keccak256(
  ethers.utils.defaultAbiCoder.encode(
    ["string", "uint256"],
    ["setTransactionTax", 400]
  )
);

await token.cancelTimelock(operationId);
```

## Recommended Settings

### For Launch
- **Timelock**: Enabled
- **Delay**: 24 hours
- **Reason**: Balance security and flexibility

### For Production
- **Timelock**: Enabled
- **Delay**: 48 hours
- **Reason**: More time for community review

### For Testing
- **Timelock**: Disabled
- **Reason**: Faster iteration during development

## Security Benefits

1. **Transparency**: All changes are visible before execution
2. **Community Protection**: Time to react to malicious changes
3. **Trust Building**: Shows commitment to community
4. **Attack Prevention**: Prevents sudden malicious changes

## Best Practices

1. **Enable Before Launch**: Set up timelock before mainnet
2. **Communicate Changes**: Announce scheduled changes to community
3. **Monitor Pending**: Check for pending operations regularly
4. **Use with Multi-Sig**: Combine timelock with multi-sig for maximum security

## Example Workflow

### Changing Marketing Wallet

```javascript
// 1. Schedule change (Day 1)
const newWallet = "0x...";
await token.setMarketingWallet(newWallet);
// Transaction scheduled for Day 2

// 2. Announce to community
// "Marketing wallet change scheduled for [timestamp]"

// 3. Execute after delay (Day 2)
await token.executeSetMarketingWallet(newWallet);
// Marketing wallet updated
```

## Integration with Multi-Sig

When using Gnosis Safe + Timelock:

1. **Schedule**: Propose transaction in Safe
2. **Sign**: Signers approve
3. **Schedule**: Transaction schedules (24 hours)
4. **Execute**: After delay, propose execute transaction
5. **Sign**: Signers approve execution
6. **Complete**: Change takes effect

## Events

Monitor these events for timelock operations:

```solidity
event TimelockScheduled(bytes32 indexed operationId, uint256 executeTime);
event TimelockExecuted(bytes32 indexed operationId);
event TimelockCancelled(bytes32 indexed operationId);
event TimelockDelayUpdated(uint256 newDelay);
event TimelockToggled(bool enabled);
```

## Troubleshooting

### Operation Not Ready
- Check if 24 hours have passed
- Verify operation was scheduled
- Check `getTimelockTime()` for exact time

### Can't Cancel
- Only owner can cancel
- Operation must be scheduled
- Check operation ID is correct

### Timelock Not Working
- Verify `timelockEnabled` is true
- Check delay is set correctly
- Ensure you're calling execute function

---

**Next Step**: Set up multi-sig wallet (see MULTISIG_SETUP.md)
