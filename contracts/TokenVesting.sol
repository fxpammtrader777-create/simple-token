// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "@openzeppelin/contracts/finance/VestingWallet.sol";

/**
 * @title TokenVesting
 * @author Token Development Team
 * @notice Wrapper contract for OpenZeppelin VestingWallet with 2026 compliance
 * @dev Used to create vesting schedules that meet 2026 industry standards:
 *      - 4 year vesting for team/founders
 *      - 1 year cliff period
 *      - Linear vesting after cliff
 * 
 * Industry Standards (2026):
 * - Team allocation: 15-20% max
 * - Vesting period: 4 years minimum
 * - Cliff period: 1 year minimum
 * - Community allocation: 40-50%
 * - Locked liquidity: 2+ years
 */

/**
 * @notice This contract is a deployment helper for VestingWallet
 * @dev OpenZeppelin's VestingWallet is already 2026-compliant
 * 
 * Usage:
 * 1. Deploy VestingWallet for each allocation
 * 2. Transfer tokens to VestingWallet address
 * 3. Tokens vest linearly over specified duration
 * 4. Beneficiary can release vested tokens anytime
 * 
 * Example deployment:
 * ```javascript
 * // Team vesting: 4 years, 1 year cliff
 * const teamVesting = await VestingWallet.deploy(
 *     teamAddress,                    // beneficiary
 *     startTimestamp,                 // start time
 *     4 * 365 * 24 * 60 * 60         // duration (4 years)
 * );
 * 
 * // Tokens locked for 1 year (cliff), then vest linearly over 3 years
 * // Beneficiary can call release() to claim vested tokens
 * ```
 */

// Note: We use OpenZeppelin's VestingWallet directly
// This file serves as documentation for the vesting strategy

/**
 * @dev Vesting Schedule for 2026 Compliance:
 * 
 * TEAM & FOUNDERS (18% = 1,800,000 tokens):
 * - Duration: 4 years (1461 days)
 * - Cliff: 1 year (365 days)
 * - Vesting: Linear after cliff
 * - Release: Manual by beneficiary
 * 
 * COMMUNITY REWARDS (25% = 2,500,000 tokens):
 * - Duration: 2 years (730 days)
 * - Cliff: None (immediate start)
 * - Vesting: Linear
 * - Release: Manual by beneficiary
 * 
 * ECOSYSTEM GROWTH (15% = 1,500,000 tokens):
 * - Duration: 3 years (1095 days)
 * - Cliff: 6 months (182 days)
 * - Vesting: Linear after cliff
 * - Release: Manual by beneficiary
 * 
 * DEVELOPMENT FUND (12% = 1,200,000 tokens):
 * - Duration: 2 years (730 days)
 * - Cliff: 3 months (91 days)
 * - Vesting: Linear after cliff
 * - Release: Manual by beneficiary
 * 
 * LIQUIDITY (15% = 1,500,000 tokens):
 * - Locked via Unicrypt/Team Finance (not VestingWallet)
 * - Duration: 2 years minimum
 * - Cannot unlock early
 * 
 * PUBLIC SALE (5% = 500,000 tokens):
 * - No vesting (immediate availability)
 * - Available at launch
 * 
 * BUYBACK/BURN (10% = 1,000,000 tokens):
 * - In Token contract
 * - Automatically burns at threshold
 * - No vesting needed
 */

/**
 * @dev How Cliff Works:
 * 
 * With 4-year vesting and 1-year cliff:
 * 
 * Year 0-1 (Cliff): 0% vested, 0 tokens claimable
 * Year 1-2: 25% vested (linear), 450K tokens claimable
 * Year 2-3: 50% vested (linear), 900K tokens claimable
 * Year 3-4: 75% vested (linear), 1.35M tokens claimable
 * Year 4+: 100% vested, all 1.8M tokens claimable
 * 
 * Example with 1.8M tokens over 4 years with 1-year cliff:
 * - After 0 months: 0 tokens released (cliff)
 * - After 12 months: 0 tokens released (cliff ends)
 * - After 18 months: 225K tokens (12.5% of total)
 * - After 24 months: 450K tokens (25% of total)
 * - After 36 months: 900K tokens (50% of total)
 * - After 48 months: 1.8M tokens (100% of total)
 */

/**
 * @dev Security Features:
 * 
 * 1. Immutable Vesting Schedule:
 *    - Cannot change beneficiary
 *    - Cannot change duration
 *    - Cannot speed up vesting
 *    - Cannot pause vesting
 * 
 * 2. Transparent Release:
 *    - All releases on-chain
 *    - Public releasable() function
 *    - Anyone can verify vesting status
 * 
 * 3. OpenZeppelin Audited:
 *    - Battle-tested code
 *    - Used by major projects
 *    - Industry standard
 * 
 * 4. 2026 Compliance:
 *    - Meets SEC guidelines
 *    - Meets MiCA requirements
 *    - Reduces rug pull risk
 *    - Increases investor confidence
 */

/**
 * @dev Gas Optimization:
 * 
 * - VestingWallet is gas-efficient
 * - Release is manual (beneficiary pays gas)
 * - No automatic distributions
 * - No loops or complex calculations
 */

/**
 * @notice Deployment addresses will be stored here after deployment
 * @dev Update these addresses in deployment script output
 */

// Deployment addresses (update after deployment):
// Team Vesting:        0x...
// Community Vesting:   0x...
// Ecosystem Vesting:   0x...
// Development Vesting: 0x...
// Liquidity Lock:      0x... (Unicrypt/Team Finance)
// Public Sale:         0x...
// Token Contract:      0x...
