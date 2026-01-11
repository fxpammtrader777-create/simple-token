# Multi-Sig Wallet Setup Guide

## Overview

Using a multi-sig wallet as the contract owner adds an extra layer of security by requiring multiple signatures for critical operations.

## Why Multi-Sig?

- **Prevents Single Point of Failure**: If one key is compromised, attacker can't act alone
- **Industry Standard**: Used by all major DeFi projects
- **Community Trust**: Shows commitment to security
- **No Code Changes Needed**: Just use multi-sig address as owner

## Recommended: Gnosis Safe

Gnosis Safe is the most popular and trusted multi-sig solution.

### Setup Steps

#### 1. Create Gnosis Safe Wallet

1. Go to https://safe.global/
2. Click "Create Safe"
3. Connect your wallet
4. Select Polygon network
5. Choose signers (2-of-3 or 3-of-5 recommended)
6. Add signer addresses
7. Confirm and create

#### 2. Fund the Safe

- Send MATIC to the Safe address for gas fees
- Keep some MATIC in the Safe for future transactions

#### 3. Deploy Token with Safe as Owner

When deploying the token contract:
- Use the Gnosis Safe address as the `owner` parameter
- The Safe address will be the contract owner

#### 4. Transfer Ownership (if already deployed)

If you already deployed with a regular wallet:

```javascript
// In your deployment script or via Remix
await token.transferOwnership(gnosisSafeAddress);
```

## Multi-Sig Configuration Recommendations

### For Launch
- **2-of-3**: Good balance of security and convenience
  - 2 team members + 1 backup
  - Quick decisions, still secure

### For Production
- **3-of-5**: Maximum security
  - 3 team members + 2 advisors/community
  - More secure, requires more coordination

## Using Multi-Sig for Owner Functions

### Example: Changing Tax Rate

1. **Propose Transaction**:
   - Go to Gnosis Safe interface
   - Click "New Transaction"
   - Select your token contract
   - Call `setTransactionTax(400)` (4%)
   - Review and submit

2. **Signatures Required**:
   - Other signers will see pending transaction
   - They sign to approve
   - Once threshold reached, transaction executes

3. **With Timelock**:
   - Transaction schedules (24 hours)
   - Community can see pending change
   - After 24 hours, execute via Safe

## Security Best Practices

1. **Distribute Keys Securely**:
   - Use hardware wallets for signers
   - Store backups securely
   - Don't share keys

2. **Use Different Devices**:
   - Each signer on different device
   - Reduces risk of simultaneous compromise

3. **Regular Key Rotation**:
   - Periodically review signers
   - Remove inactive signers
   - Add new trusted signers

4. **Monitor Transactions**:
   - Set up alerts for Safe transactions
   - Review all pending transactions
   - Verify before signing

## Cost

- **Gnosis Safe**: FREE
- **Gas Fees**: Same as regular transactions
- **No Monthly Fees**: Completely free to use

## Alternative Multi-Sig Solutions

1. **Gnosis Safe** (Recommended)
   - Most popular
   - Best UI
   - Free

2. **OpenZeppelin Defender**
   - Enterprise solution
   - Advanced features
   - Paid plans available

3. **Custom Multi-Sig**
   - Build your own
   - More control
   - Requires development

## Verification

After setup, verify:
- ✅ Safe address is contract owner
- ✅ Multiple signers configured
- ✅ Test transaction works
- ✅ All signers can access Safe

## Support

- Gnosis Safe Docs: https://docs.safe.global/
- Gnosis Safe Support: https://help.safe.global/

---

**Next Step**: Set up timelock for additional security (see TIMELOCK_GUIDE.md)
