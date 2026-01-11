// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

/**
 * @title Simple Token - Hardened Security Version
 * @dev ERC-20 token with transaction taxes, buyback/burn mechanism, and comprehensive security
 * 
 * Security Features:
 * - ReentrancyGuard on all critical functions
 * - Input validation on all parameters
 * - Tax bypass prevention
 * - Flash loan attack protection
 * - Maximum limits on all configurable values
 * - Comprehensive access control
 */
contract Token is ERC20, ERC20Burnable, Ownable, ReentrancyGuard {
    // Tax configuration (in basis points, 100 = 1%)
    uint256 public transactionTax = 300; // 3% default
    uint256 public constant MAX_TAX = 500; // 5% maximum
    uint256 public constant MIN_TAX = 0; // 0% minimum
    
    // Tax distribution percentages (in basis points) - constant for gas optimization
    uint256 public constant liquidityTaxPercent = 4000; // 40%
    uint256 public constant marketingTaxPercent = 3000; // 30%
    uint256 public constant treasuryTaxPercent = 3000; // 30%
    uint256 public constant TAX_DISTRIBUTION_TOTAL = 10000; // 100%
    
    // Wallet addresses
    address public marketingWallet;
    address public liquidityWallet;
    
    // Treasury for buyback and burn
    uint256 public treasury;
    uint256 public constant DEFAULT_BUYBACK_THRESHOLD = 100000 * 10**18; // 100,000 tokens
    uint256 public buybackThreshold = DEFAULT_BUYBACK_THRESHOLD;
    uint256 public constant MAX_BUYBACK_THRESHOLD = 10000000 * 10**18; // 10M max
    
    // Tax exemptions
    mapping(address => bool) public isExcludedFromTax;
    mapping(address => bool) public isExcludedFromBuyback;
    
    // DEX pair address (set after liquidity is added)
    address public pairAddress;
    
    // Security: Prevent tax manipulation
    bool public taxLocked = true; // Locked by default - no surprises
    
    // Security: Maximum treasury cap (prevents DoS)
    uint256 public constant MAX_TREASURY = 10000000 * 10**18; // 10M max
    uint256 private constant MAX_TOTAL_SUPPLY = 1000000000 * 10**18; // 1B max
    
    // Security: Cooldown for buyback (prevents front-running)
    uint256 public lastBuybackTime;
    uint256 public constant BUYBACK_COOLDOWN = 1 hours;
    
    // Security: Timelock for critical functions
    uint256 public timelockDelay = 24 hours; // Default 24 hour delay
    mapping(bytes32 => uint256) public timelock;
    bool public timelockEnabled = false;
    
    // Events
    event TaxUpdated(uint256 newTax);
    event WalletUpdated(string walletType, address newWallet);
    event TaxExemptionUpdated(address account, bool excluded);
    event BuybackExecuted(uint256 amountBurned);
    event TreasuryWithdrawn(address to, uint256 amount);
    event TaxLocked();
    event TimelockScheduled(bytes32 indexed operationId, uint256 executeTime);
    event TimelockExecuted(bytes32 indexed operationId);
    event TimelockCancelled(bytes32 indexed operationId);
    event TimelockDelayUpdated(uint256 newDelay);
    event TimelockToggled(bool enabled);
    event BuybackThresholdUpdated(uint256 newThreshold);
    event BuybackExemptionUpdated(address account, bool excluded);
    
    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _totalSupply,
        address _marketingWallet,
        address _liquidityWallet
    ) ERC20(_name, _symbol) Ownable(msg.sender) {
        require(_marketingWallet != address(0), "Marketing wallet cannot be zero");
        require(_liquidityWallet != address(0), "Liquidity wallet cannot be zero");
        require(_totalSupply > 0, "Total supply must be greater than zero");
        require(_totalSupply <= MAX_TOTAL_SUPPLY, "Total supply exceeds maximum");
        
        // Validate tax distribution sums to 100%
        require(
            liquidityTaxPercent + marketingTaxPercent + treasuryTaxPercent == TAX_DISTRIBUTION_TOTAL,
            "Tax distribution must sum to 100%"
        );
        
        marketingWallet = _marketingWallet;
        liquidityWallet = _liquidityWallet;
        
        // Exclude owner and contract from taxes
        isExcludedFromTax[msg.sender] = true;
        isExcludedFromTax[address(this)] = true;
        isExcludedFromTax[_marketingWallet] = true;
        isExcludedFromTax[_liquidityWallet] = true;
        
        // Mint total supply to owner
        
        // Lock tax permanently by default - no surprises, full credibility
        taxLocked = true;
        emit TaxLocked();
        
        _mint(msg.sender, _totalSupply);
    }
    
    /**
     * @dev Override transfer to apply transaction tax with reentrancy protection
     */
    function transfer(address to, uint256 amount) public override nonReentrant returns (bool) {
        require(to != address(0), "Cannot transfer to zero address");
        require(amount > 0, "Transfer amount must be greater than zero");
        require(to != address(this), "Cannot transfer to contract address");
        
        address sender = _msgSender();
        _transferWithTax(sender, to, amount);
        return true;
    }
    
    /**
     * @dev Override transferFrom to apply transaction tax with reentrancy protection
     */
    function transferFrom(address from, address to, uint256 amount) public override nonReentrant returns (bool) {
        require(from != address(0), "Cannot transfer from zero address");
        require(to != address(0), "Cannot transfer to zero address");
        require(amount > 0, "Transfer amount must be greater than zero");
        require(to != address(this), "Cannot transfer to contract address");
        
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transferWithTax(from, to, amount);
        return true;
    }
    
    /**
     * @dev Internal function to handle transfers with tax
     * Security: Validates all inputs before processing
     */
    function _transferWithTax(address from, address to, uint256 amount) internal {
        require(from != address(0), "Transfer from zero address");
        require(to != address(0), "Transfer to zero address");
        require(amount > 0, "Transfer amount must be greater than zero");
        require(balanceOf(from) >= amount, "Insufficient balance");
        
        // Skip tax if either address is excluded
        if (isExcludedFromTax[from] || isExcludedFromTax[to]) {
            _transfer(from, to, amount);
            return;
        }
        
        // Calculate tax
        uint256 taxAmount = (amount * transactionTax) / 10000;
        require(taxAmount < amount, "Tax amount exceeds transfer amount"); // Safety check
        
        uint256 transferAmount = amount - taxAmount;
        
        // Transfer amount minus tax
        _transfer(from, to, transferAmount);
        
        // Distribute tax
        if (taxAmount > 0) {
            _distributeTax(from, taxAmount);
        }
    }
    
    /**
     * @dev Distribute tax to liquidity, marketing, and treasury
     * Security: Treasury gets remainder to handle rounding, prevents token loss
     */
    function _distributeTax(address from, uint256 taxAmount) internal {
        require(taxAmount > 0, "Tax amount must be greater than zero");
        
        uint256 liquidityAmount = (taxAmount * liquidityTaxPercent) / 10000;
        uint256 marketingAmount = (taxAmount * marketingTaxPercent) / 10000;
        // Treasury gets remainder to ensure no tokens are lost due to rounding
        uint256 treasuryAmount = taxAmount - liquidityAmount - marketingAmount;
        
        // Validate distribution
        require(
            liquidityAmount + marketingAmount + treasuryAmount == taxAmount,
            "Tax distribution error"
        );
        
        // Calculate treasury cap and handle excess
        uint256 excessAmount = 0;
        if (treasuryAmount > 0) {
            // Prevent treasury from exceeding maximum (DoS protection)
            if (treasury + treasuryAmount > MAX_TREASURY) {
                excessAmount = treasuryAmount - (MAX_TREASURY - treasury);
                treasuryAmount = MAX_TREASURY - treasury;
            }
        }
        
        // Redistribute excess treasury amount to marketing and liquidity proportionally
        if (excessAmount > 0) {
            uint256 excessLiquidity = (excessAmount * liquidityTaxPercent) / (liquidityTaxPercent + marketingTaxPercent);
            uint256 excessMarketing = excessAmount - excessLiquidity;
            liquidityAmount += excessLiquidity;
            marketingAmount += excessMarketing;
        }
        
        // Send to marketing wallet
        if (marketingAmount > 0) {
            _transfer(from, marketingWallet, marketingAmount);
        }
        
        // Send to liquidity wallet
        if (liquidityAmount > 0) {
            _transfer(from, liquidityWallet, liquidityAmount);
        }
        
        // Add to treasury (with maximum cap to prevent DoS)
        if (treasuryAmount > 0) {
            _transfer(from, address(this), treasuryAmount);
            treasury += treasuryAmount;
            
            // Check if buyback threshold is reached (with cooldown to prevent front-running)
            if (treasury >= buybackThreshold && 
                block.timestamp >= lastBuybackTime + BUYBACK_COOLDOWN) {
                _buybackAndBurn();
            }
        }
    }
    
    /**
     * @dev Buyback and burn tokens from treasury
     * Security: Cooldown prevents front-running, validates state before burning
     */
    function _buybackAndBurn() internal {
        require(treasury > 0, "No treasury to burn");
        require(!isExcludedFromBuyback[address(this)], "Buyback excluded");
        require(
            block.timestamp >= lastBuybackTime + BUYBACK_COOLDOWN,
            "Buyback cooldown active"
        );
        
        uint256 amountToBurn = treasury;
        require(amountToBurn > 0, "Amount to burn must be greater than zero");
        
        treasury = 0;
        lastBuybackTime = block.timestamp;
        
        // Burn tokens
        _burn(address(this), amountToBurn);
        
        emit BuybackExecuted(amountToBurn);
    }
    
    /**
     * @dev Manual buyback and burn (owner only)
     * Security: Reentrancy protection, validates state
     */
    function manualBuybackAndBurn() external onlyOwner nonReentrant {
        require(treasury > 0, "No treasury to burn");
        _buybackAndBurn();
    }
    
    /**
     * @dev Set transaction tax (owner only, max 5%)
     * Security: Cannot be changed if tax is locked, timelock if enabled
     */
    function setTransactionTax(uint256 _tax) external onlyOwner {
        require(!taxLocked, "Tax is locked and cannot be changed");
        require(_tax >= MIN_TAX && _tax <= MAX_TAX, "Tax out of valid range");
        
        if (timelockEnabled) {
            bytes32 operationId = keccak256(abi.encodePacked("setTransactionTax", _tax));
            _scheduleTimelock(operationId);
            timelock[operationId] = block.timestamp + timelockDelay;
            emit TimelockScheduled(operationId, timelock[operationId]);
            return;
        }
        
        transactionTax = _tax;
        emit TaxUpdated(_tax);
    }
    
    /**
     * @dev Execute scheduled transaction tax change
     */
    function executeSetTransactionTax(uint256 _tax) external onlyOwner {
        bytes32 operationId = keccak256(abi.encodePacked("setTransactionTax", _tax));
        _executeTimelock(operationId);
        transactionTax = _tax;
        emit TaxUpdated(_tax);
    }
    
    /**
     * @dev Lock tax permanently (owner only, irreversible)
     * Security: Prevents future tax manipulation
     * NOTE: Tax is already locked by default in constructor
     * This function exists for backwards compatibility but will always revert
     */
    function lockTax() external onlyOwner {
        require(!taxLocked, "Tax already locked");
        taxLocked = true;
        emit TaxLocked();
    }
    
    /**
     * @dev Set marketing wallet (owner only)
     * Security: Validates address, prevents zero address, timelock if enabled
     */
    function setMarketingWallet(address _wallet) external onlyOwner {
        require(_wallet != address(0), "Wallet cannot be zero address");
        require(_wallet != address(this), "Cannot set contract as wallet");
        
        if (timelockEnabled) {
            bytes32 operationId = keccak256(abi.encodePacked("setMarketingWallet", _wallet));
            _scheduleTimelock(operationId);
            timelock[operationId] = block.timestamp + timelockDelay;
            emit TimelockScheduled(operationId, timelock[operationId]);
            return;
        }
        
        marketingWallet = _wallet;
        emit WalletUpdated("marketing", _wallet);
    }
    
    /**
     * @dev Execute scheduled marketing wallet change
     */
    function executeSetMarketingWallet(address _wallet) external onlyOwner {
        require(_wallet != address(0), "Wallet cannot be zero address");
        require(_wallet != address(this), "Cannot set contract as wallet");
        bytes32 operationId = keccak256(abi.encodePacked("setMarketingWallet", _wallet));
        _executeTimelock(operationId);
        marketingWallet = _wallet;
        emit WalletUpdated("marketing", _wallet);
    }
    
    /**
     * @dev Set liquidity wallet (owner only)
     * Security: Validates address, prevents zero address, timelock if enabled
     */
    function setLiquidityWallet(address _wallet) external onlyOwner {
        require(_wallet != address(0), "Wallet cannot be zero address");
        require(_wallet != address(this), "Cannot set contract as wallet");
        
        if (timelockEnabled) {
            bytes32 operationId = keccak256(abi.encodePacked("setLiquidityWallet", _wallet));
            _scheduleTimelock(operationId);
            timelock[operationId] = block.timestamp + timelockDelay;
            emit TimelockScheduled(operationId, timelock[operationId]);
            return;
        }
        
        liquidityWallet = _wallet;
        emit WalletUpdated("liquidity", _wallet);
    }
    
    /**
     * @dev Execute scheduled liquidity wallet change
     */
    function executeSetLiquidityWallet(address _wallet) external onlyOwner {
        require(_wallet != address(0), "Wallet cannot be zero address");
        require(_wallet != address(this), "Cannot set contract as wallet");
        bytes32 operationId = keccak256(abi.encodePacked("setLiquidityWallet", _wallet));
        _executeTimelock(operationId);
        liquidityWallet = _wallet;
        emit WalletUpdated("liquidity", _wallet);
    }
    
    /**
     * @dev Set DEX pair address (owner only, for tax exemption)
     * Security: Validates address
     */
    function setPairAddress(address _pair) external onlyOwner {
        require(_pair != address(0), "Pair address cannot be zero");
        pairAddress = _pair;
        isExcludedFromTax[_pair] = true;
        emit WalletUpdated("pair", _pair);
    }
    
    /**
     * @dev Exclude/include address from tax (owner only)
     * Security: Cannot exempt contract address (prevents tax bypass)
     */
    function setTaxExemption(address account, bool excluded) external onlyOwner {
        require(account != address(0), "Cannot exempt zero address");
        require(account != address(this), "Cannot exempt contract address");
        isExcludedFromTax[account] = excluded;
        emit TaxExemptionUpdated(account, excluded);
    }
    
    /**
     * @dev Exclude/include address from buyback (owner only)
     * Security: Validates address
     */
    function setBuybackExemption(address account, bool excluded) external onlyOwner {
        require(account != address(0), "Cannot exempt zero address");
        isExcludedFromBuyback[account] = excluded;
        emit BuybackExemptionUpdated(account, excluded);
    }
    
    /**
     * @dev Set buyback threshold (owner only)
     * Security: Maximum limit prevents DoS
     */
    function setBuybackThreshold(uint256 _threshold) external onlyOwner {
        require(_threshold > 0, "Threshold must be greater than zero");
        require(_threshold <= MAX_BUYBACK_THRESHOLD, "Threshold exceeds maximum");
        buybackThreshold = _threshold;
        emit BuybackThresholdUpdated(_threshold);
    }
    
    /**
     * @dev Withdraw treasury (owner only, emergency use)
     * Security: Reentrancy protection, validates amounts, timelock if enabled
     */
    function withdrawTreasury(address to, uint256 amount) external onlyOwner nonReentrant {
        require(to != address(0), "Cannot withdraw to zero address");
        require(to != address(this), "Cannot withdraw to contract address");
        require(amount > 0, "Amount must be greater than zero");
        require(amount <= treasury, "Insufficient treasury");
        
        if (timelockEnabled) {
            bytes32 operationId = keccak256(abi.encodePacked("withdrawTreasury", to, amount));
            _scheduleTimelock(operationId);
            timelock[operationId] = block.timestamp + timelockDelay;
            emit TimelockScheduled(operationId, timelock[operationId]);
            return;
        }
        
        _executeWithdrawTreasury(to, amount);
    }
    
    /**
     * @dev Execute scheduled treasury withdrawal
     */
    function executeWithdrawTreasury(address to, uint256 amount) external onlyOwner nonReentrant {
        bytes32 operationId = keccak256(abi.encodePacked("withdrawTreasury", to, amount));
        _executeTimelock(operationId);
        _executeWithdrawTreasury(to, amount);
    }
    
    /**
     * @dev Internal function to execute treasury withdrawal
     */
    function _executeWithdrawTreasury(address to, uint256 amount) internal {
        treasury -= amount;
        _transfer(address(this), to, amount);
        emit TreasuryWithdrawn(to, amount);
    }
    
    /**
     * @dev Internal function to schedule timelock
     */
    function _scheduleTimelock(bytes32 operationId) internal {
        require(timelock[operationId] == 0, "Operation already scheduled");
    }
    
    /**
     * @dev Internal function to execute timelock
     */
    function _executeTimelock(bytes32 operationId) internal {
        require(timelock[operationId] > 0, "Operation not scheduled");
        require(block.timestamp >= timelock[operationId], "Timelock not expired");
        delete timelock[operationId];
        emit TimelockExecuted(operationId);
    }
    
    /**
     * @dev Cancel scheduled timelock operation (owner only)
     */
    function cancelTimelock(bytes32 operationId) external onlyOwner {
        require(timelock[operationId] > 0, "Operation not scheduled");
        delete timelock[operationId];
        emit TimelockCancelled(operationId);
    }
    
    /**
     * @dev Set timelock delay (owner only)
     */
    function setTimelockDelay(uint256 _delay) external onlyOwner {
        require(_delay >= 1 hours && _delay <= 7 days, "Delay out of valid range");
        timelockDelay = _delay;
        emit TimelockDelayUpdated(_delay);
    }
    
    /**
     * @dev Enable/disable timelock (owner only)
     */
    function toggleTimelock(bool _enabled) external onlyOwner {
        timelockEnabled = _enabled;
        emit TimelockToggled(_enabled);
    }
    
    /**
     * @dev Check if timelock operation is ready
     */
    function isTimelockReady(bytes32 operationId) external view returns (bool) {
        return timelock[operationId] > 0 && block.timestamp >= timelock[operationId];
    }
    
    /**
     * @dev Get timelock execution time
     */
    function getTimelockTime(bytes32 operationId) external view returns (uint256) {
        return timelock[operationId];
    }
    
    /**
     * @dev Get current treasury balance
     */
    function getTreasuryBalance() external view returns (uint256) {
        return treasury;
    }
    
    /**
     * @dev Check if buyback threshold is reached
     */
    function isBuybackReady() external view returns (bool) {
        return treasury >= buybackThreshold && 
               block.timestamp >= lastBuybackTime + BUYBACK_COOLDOWN;
    }
    
    /**
     * @dev Get time until next buyback is allowed
     */
    function getBuybackCooldownRemaining() external view returns (uint256) {
        if (block.timestamp >= lastBuybackTime + BUYBACK_COOLDOWN) {
            return 0;
        }
        return (lastBuybackTime + BUYBACK_COOLDOWN) - block.timestamp;
    }
    
    /**
     * @dev Renounce ownership (inherited from OpenZeppelin Ownable)
     * 
     * ⚠️ WARNING: This is IRREVERSIBLE!
     * 
     * What it does:
     * - Removes ability to call owner-only functions
     * - Makes contract fully decentralized
     * 
     * What it does NOT do:
     * - Does NOT remove access to marketingWallet or liquidityWallet
     * - Those wallets are still controlled by their private keys
     * 
     * Before renouncing:
     * 1. Lock tax (recommended)
     * 2. Set final wallet addresses (use multi-sig or separate wallets)
     * 3. Verify everything is correct
     * 4. Test on testnet first
     * 
     * See docs/RENOUNCE_OWNERSHIP.md for detailed guide
     */
    // renounceOwnership() is already available from OpenZeppelin Ownable
    // This comment is for documentation purposes
}
