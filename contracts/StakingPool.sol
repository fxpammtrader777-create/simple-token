// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";

/**
 * @title StakingPool - Treasury-Based Staking Contract
 * @dev Separate staking contract for Simple Token
 * 
 * Features:
 * - Flexible staking (no lock period)
 * - Fixed-term staking (30-day lock)
 * - Treasury-based rewards (sustainable)
 * - Reward per share calculation (accurate)
 * - Security: ReentrancyGuard, Pausable, input validation
 * 
 * Security Features:
 * - ReentrancyGuard on all critical functions
 * - Input validation on all parameters
 * - Maximum limits to prevent DoS
 * - Emergency pause functionality
 * - Owner access control
 */
contract StakingPool is Ownable, ReentrancyGuard, Pausable {
    using SafeERC20 for IERC20;

    // Token contract reference
    IERC20 public immutable token;

    // Staking pool structure
    struct Pool {
        uint256 lockPeriod;           // 0 = flexible, >0 = fixed-term (in seconds)
        uint256 rewardRate;           // APY in basis points (10000 = 100%)
        uint256 totalStaked;          // Total tokens staked in this pool
        uint256 totalRewards;         // Total rewards distributed
        uint256 rewardPerShare;       // Accumulated reward per share (scaled by 1e18)
        uint256 lastUpdateTime;        // Last time reward per share was updated
        bool active;                  // Pool is active (can stake/unstake)
    }

    // User stake information
    struct Stake {
        uint256 amount;               // Amount staked
        uint256 lockUntil;            // Timestamp when lock expires (0 = flexible)
        uint256 rewardDebt;           // Reward debt (for accurate calculation)
        uint256 lastClaimTime;        // Last time rewards were claimed
    }

    // Pools mapping (poolId => Pool)
    mapping(uint256 => Pool) public pools;
    uint256 public poolCount;

    // User stakes mapping (user => poolId => Stake)
    mapping(address => mapping(uint256 => Stake)) public stakes;

    // Total rewards available for distribution
    uint256 public totalRewardPool;

    // Maximum pool count (DoS protection)
    uint256 public constant MAX_POOLS = 10;

    // Maximum stake per user per pool (DoS protection)
    uint256 public constant MAX_STAKE_PER_USER = 10000000 * 10**18; // 10M tokens

    // Events
    event PoolAdded(uint256 indexed poolId, uint256 lockPeriod, uint256 rewardRate);
    event PoolUpdated(uint256 indexed poolId, uint256 newRewardRate, bool active);
    event Staked(address indexed user, uint256 indexed poolId, uint256 amount, uint256 lockUntil);
    event Unstaked(address indexed user, uint256 indexed poolId, uint256 amount);
    event RewardsClaimed(address indexed user, uint256 indexed poolId, uint256 amount);
    event RewardsFunded(uint256 amount);
    event EmergencyWithdraw(address indexed user, uint256 indexed poolId, uint256 amount);

    /**
     * @dev Constructor
     * @param _token Address of the token contract
     */
    constructor(address _token) Ownable(msg.sender) {
        require(_token != address(0), "Token address cannot be zero");
        token = IERC20(_token);
    }

    /**
     * @dev Add a new staking pool
     * @param _lockPeriod Lock period in seconds (0 = flexible)
     * @param _rewardRate APY in basis points (10000 = 100%)
     */
    function addPool(uint256 _lockPeriod, uint256 _rewardRate) external onlyOwner {
        require(poolCount < MAX_POOLS, "Maximum pools reached");
        require(_rewardRate <= 10000, "Reward rate cannot exceed 100%");
        
        pools[poolCount] = Pool({
            lockPeriod: _lockPeriod,
            rewardRate: _rewardRate,
            totalStaked: 0,
            totalRewards: 0,
            rewardPerShare: 0,
            lastUpdateTime: block.timestamp,
            active: true
        });

        emit PoolAdded(poolCount, _lockPeriod, _rewardRate);
        poolCount++;
    }

    /**
     * @dev Update pool reward rate or active status
     * @param _poolId Pool ID to update
     * @param _newRewardRate New APY in basis points (0 = no change)
     * @param _active Active status
     */
    function updatePool(uint256 _poolId, uint256 _newRewardRate, bool _active) external onlyOwner {
        require(_poolId < poolCount, "Pool does not exist");
        require(_newRewardRate <= 10000, "Reward rate cannot exceed 100%");
        
        Pool storage pool = pools[_poolId];
        
        if (_newRewardRate > 0) {
            pool.rewardRate = _newRewardRate;
        }
        
        pool.active = _active;
        
        emit PoolUpdated(_poolId, pool.rewardRate, _active);
    }

    /**
     * @dev Fund rewards pool (owner only, from treasury)
     * @param _amount Amount of tokens to add to reward pool
     */
    function fundRewards(uint256 _amount) external onlyOwner {
        require(_amount > 0, "Amount must be greater than zero");
        require(token.balanceOf(msg.sender) >= _amount, "Insufficient balance");
        
        token.safeTransferFrom(msg.sender, address(this), _amount);
        totalRewardPool += _amount;
        
        emit RewardsFunded(_amount);
    }

    /**
     * @dev Stake tokens in a pool
     * @param _poolId Pool ID to stake in
     * @param _amount Amount of tokens to stake
     */
    function stake(uint256 _poolId, uint256 _amount) external nonReentrant whenNotPaused {
        require(_poolId < poolCount, "Pool does not exist");
        require(_amount > 0, "Amount must be greater than zero");
        require(_amount <= MAX_STAKE_PER_USER, "Stake exceeds maximum");
        
        Pool storage pool = pools[_poolId];
        require(pool.active, "Pool is not active");
        
        Stake storage userStake = stakes[msg.sender][_poolId];
        
        // Update pool rewards before staking
        _updatePoolRewards(_poolId);
        
        // If user already has a stake, claim pending rewards first
        if (userStake.amount > 0) {
            _claimRewards(msg.sender, _poolId);
        }
        
        // Transfer tokens from user
        token.safeTransferFrom(msg.sender, address(this), _amount);
        
        // Calculate lock expiration
        uint256 lockUntil = 0;
        if (pool.lockPeriod > 0) {
            lockUntil = block.timestamp + pool.lockPeriod;
        }
        
        // Update user stake
        userStake.amount += _amount;
        userStake.lockUntil = lockUntil;
        userStake.rewardDebt = (userStake.amount * pool.rewardPerShare) / 1e18;
        userStake.lastClaimTime = block.timestamp;
        
        // Update pool
        pool.totalStaked += _amount;
        
        emit Staked(msg.sender, _poolId, _amount, lockUntil);
    }

    /**
     * @dev Unstake tokens from a pool
     * @param _poolId Pool ID to unstake from
     * @param _amount Amount of tokens to unstake
     */
    function unstake(uint256 _poolId, uint256 _amount) external nonReentrant whenNotPaused {
        require(_poolId < poolCount, "Pool does not exist");
        require(_amount > 0, "Amount must be greater than zero");
        
        Stake storage userStake = stakes[msg.sender][_poolId];
        require(userStake.amount >= _amount, "Insufficient staked amount");
        
        Pool storage pool = pools[_poolId];
        
        // Check lock period (if applicable)
        if (pool.lockPeriod > 0) {
            require(block.timestamp >= userStake.lockUntil, "Lock period not expired");
        }
        
        // Update pool rewards before unstaking
        _updatePoolRewards(_poolId);
        
        // Claim pending rewards
        _claimRewards(msg.sender, _poolId);
        
        // Update user stake
        userStake.amount -= _amount;
        userStake.rewardDebt = (userStake.amount * pool.rewardPerShare) / 1e18;
        
        // Update pool
        pool.totalStaked -= _amount;
        
        // Transfer tokens to user
        token.safeTransfer(msg.sender, _amount);
        
        emit Unstaked(msg.sender, _poolId, _amount);
    }

    /**
     * @dev Claim rewards from a pool
     * @param _poolId Pool ID to claim from
     */
    function claimRewards(uint256 _poolId) external nonReentrant whenNotPaused {
        require(_poolId < poolCount, "Pool does not exist");
        
        _updatePoolRewards(_poolId);
        _claimRewards(msg.sender, _poolId);
    }

    /**
     * @dev Internal function to claim rewards
     */
    function _claimRewards(address _user, uint256 _poolId) internal {
        Stake storage userStake = stakes[_user][_poolId];
        Pool storage pool = pools[_poolId];
        
        if (userStake.amount == 0) {
            return;
        }
        
        // Calculate pending rewards
        uint256 pending = (userStake.amount * pool.rewardPerShare) / 1e18 - userStake.rewardDebt;
        
        if (pending > 0 && totalRewardPool >= pending) {
            // Update user stake
            userStake.rewardDebt = (userStake.amount * pool.rewardPerShare) / 1e18;
            userStake.lastClaimTime = block.timestamp;
            
            // Update pool
            pool.totalRewards += pending;
            totalRewardPool -= pending;
            
            // Transfer rewards to user
            token.safeTransfer(_user, pending);
            
            emit RewardsClaimed(_user, _poolId, pending);
        }
    }

    /**
     * @dev Update pool rewards (distribute from reward pool)
     */
    function _updatePoolRewards(uint256 _poolId) internal {
        Pool storage pool = pools[_poolId];
        
        if (pool.totalStaked == 0 || pool.rewardRate == 0) {
            pool.lastUpdateTime = block.timestamp;
            return;
        }
        
        // Calculate time elapsed
        uint256 timeElapsed = block.timestamp - pool.lastUpdateTime;
        
        // Calculate rewards to distribute (APY / 365 days / 86400 seconds)
        uint256 rewards = (pool.totalStaked * pool.rewardRate * timeElapsed) / (365 days * 10000);
        
        // Limit rewards to available reward pool
        if (rewards > totalRewardPool) {
            rewards = totalRewardPool;
        }
        
        // Update reward per share
        if (pool.totalStaked > 0) {
            pool.rewardPerShare += (rewards * 1e18) / pool.totalStaked;
        }
        
        pool.lastUpdateTime = block.timestamp;
    }

    /**
     * @dev Emergency withdraw (bypasses lock period, owner only)
     * @param _user User to withdraw for
     * @param _poolId Pool ID
     */
    function emergencyWithdraw(address _user, uint256 _poolId) external onlyOwner {
        Stake storage userStake = stakes[_user][_poolId];
        require(userStake.amount > 0, "No stake to withdraw");
        
        Pool storage pool = pools[_poolId];
        uint256 amount = userStake.amount;
        
        // Reset user stake
        userStake.amount = 0;
        userStake.rewardDebt = 0;
        
        // Update pool
        pool.totalStaked -= amount;
        
        // Transfer tokens
        token.safeTransfer(_user, amount);
        
        emit EmergencyWithdraw(_user, _poolId, amount);
    }

    /**
     * @dev Get pending rewards for a user in a pool
     * @param _user User address
     * @param _poolId Pool ID
     * @return Pending reward amount
     */
    function getPendingRewards(address _user, uint256 _poolId) external view returns (uint256) {
        require(_poolId < poolCount, "Pool does not exist");
        
        Pool memory pool = pools[_poolId];
        Stake memory userStake = stakes[_user][_poolId];
        
        if (userStake.amount == 0 || pool.totalStaked == 0) {
            return 0;
        }
        
        // Calculate current reward per share
        uint256 currentRewardPerShare = pool.rewardPerShare;
        if (pool.rewardRate > 0 && pool.totalStaked > 0) {
            uint256 timeElapsed = block.timestamp - pool.lastUpdateTime;
            uint256 rewards = (pool.totalStaked * pool.rewardRate * timeElapsed) / (365 days * 10000);
            if (rewards <= totalRewardPool) {
                currentRewardPerShare += (rewards * 1e18) / pool.totalStaked;
            }
        }
        
        // Calculate pending rewards
        uint256 pending = (userStake.amount * currentRewardPerShare) / 1e18 - userStake.rewardDebt;
        
        return pending;
    }

    /**
     * @dev Get user stake information
     * @param _user User address
     * @param _poolId Pool ID
     * @return amount Staked amount
     * @return lockUntil Lock expiration timestamp
     * @return pendingRewards Pending reward amount
     */
    function getUserStakeInfo(address _user, uint256 _poolId) external view returns (
        uint256 amount,
        uint256 lockUntil,
        uint256 pendingRewards
    ) {
        Stake memory userStake = stakes[_user][_poolId];
        amount = userStake.amount;
        lockUntil = userStake.lockUntil;
        pendingRewards = this.getPendingRewards(_user, _poolId);
    }

    /**
     * @dev Get pool information
     * @param _poolId Pool ID
     * @return lockPeriod Lock period in seconds
     * @return rewardRate APY in basis points
     * @return totalStaked Total tokens staked
     * @return totalRewards Total rewards distributed
     * @return active Pool is active
     */
    function getPoolInfo(uint256 _poolId) external view returns (
        uint256 lockPeriod,
        uint256 rewardRate,
        uint256 totalStaked,
        uint256 totalRewards,
        bool active
    ) {
        Pool memory pool = pools[_poolId];
        lockPeriod = pool.lockPeriod;
        rewardRate = pool.rewardRate;
        totalStaked = pool.totalStaked;
        totalRewards = pool.totalRewards;
        active = pool.active;
    }

    /**
     * @dev Pause contract (emergency only)
     */
    function pause() external onlyOwner {
        _pause();
    }

    /**
     * @dev Unpause contract
     */
    function unpause() external onlyOwner {
        _unpause();
    }

    /**
     * @dev Withdraw excess tokens (owner only, emergency)
     * @param _amount Amount to withdraw
     */
    function withdrawExcess(uint256 _amount) external onlyOwner {
        require(_amount > 0, "Amount must be greater than zero");
        require(token.balanceOf(address(this)) >= _amount, "Insufficient balance");
        
        // Don't withdraw from staked amounts or reward pool
        uint256 totalStaked = 0;
        for (uint256 i = 0; i < poolCount; i++) {
            totalStaked += pools[i].totalStaked;
        }
        
        uint256 available = token.balanceOf(address(this)) - totalStaked - totalRewardPool;
        require(available >= _amount, "Insufficient excess balance");
        
        token.safeTransfer(owner(), _amount);
    }
}
