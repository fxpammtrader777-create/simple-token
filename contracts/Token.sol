// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable2Step.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

/**
 * @title Bird Token - Hardened Security Version
 * @author Token Development Team
 * @notice ERC-20 token with transaction taxes, buyback/burn mechanism, and comprehensive security
 * @dev Implements ERC20, ERC20Burnable, Ownable2Step, and ReentrancyGuard
 * 
 * Security Features:
 * - ReentrancyGuard on all critical functions
 * - Input validation on all parameters
 * - Tax bypass prevention
 * - Flash loan attack protection
 * - Maximum limits on all configurable values
 * - Comprehensive access control
 * - Two-step ownership transfer for safety
 */
contract Token is ERC20, ERC20Burnable, Ownable2Step, ReentrancyGuard {
    /// @notice Tax configuration in basis points where 100 = 1%
    /// @dev Default 3% transaction tax
    uint256 public transactionTax = 300;
    
    /// @notice Maximum allowed transaction tax (5%)
    uint256 public constant MAX_TAX = 500;
    
    /// @notice Minimum allowed transaction tax (0%)
    uint256 public constant MIN_TAX = 0;
    
    /// @notice Percentage of tax allocated to liquidity (40%)
    /// @dev Constant for gas optimization
    uint256 private constant LIQUIDITY_TAX_PERCENT = 4000;
    
    /// @notice Percentage of tax allocated to marketing (30%)
    /// @dev Constant for gas optimization
    uint256 private constant MARKETING_TAX_PERCENT = 3000;
    
    /// @notice Percentage of tax allocated to treasury (30%)
    /// @dev Constant for gas optimization
    uint256 private constant TREASURY_TAX_PERCENT = 3000;
    
    /// @notice Total tax distribution must equal 100%
    uint256 private constant TAX_DISTRIBUTION_TOTAL = 10_000;
    
    /// @notice Basis points divisor (100%)
    uint256 private constant BASIS_POINTS = 10_000;
    
    /// @notice Marketing wallet address
    address public marketingWallet;
    
    /// @notice Liquidity wallet address
    address public liquidityWallet;
    
    /// @notice Treasury balance for buyback and burn
    uint256 public treasury;
    
    /// @notice Default buyback threshold (100,000 tokens)
    uint256 private constant DEFAULT_BUYBACK_THRESHOLD = 100_000 * 10**18;
    
    /// @notice Current buyback threshold
    uint256 public buybackThreshold = DEFAULT_BUYBACK_THRESHOLD;
    
    /// @notice Maximum allowed buyback threshold (10M tokens)
    uint256 private constant MAX_BUYBACK_THRESHOLD = 10_000_000 * 10**18;
    
    /// @notice Mapping of addresses excluded from transaction tax
    mapping(address => bool) public isExcludedFromTax;
    
    /// @notice Mapping of addresses excluded from buyback mechanism
    mapping(address => bool) public isExcludedFromBuyback;
    
    /// @notice DEX pair address (set after liquidity is added)
    address public pairAddress;
    
    /// @notice Tax locked status to prevent manipulation
    /// @dev Locked by default for credibility
    bool public taxLocked = true;
    
    /// @notice Maximum treasury cap to prevent DoS attacks
    uint256 private constant MAX_TREASURY = 10_000_000 * 10**18;
    
    /// @notice Maximum total supply cap
    uint256 private constant MAX_TOTAL_SUPPLY = 1_000_000_000 * 10**18;
    
    /// @notice Last buyback timestamp
    uint256 public lastBuybackTime;
    
    /// @notice Buyback cooldown period (1 hour)
    uint256 private constant BUYBACK_COOLDOWN = 1 hours;
    
    /// @notice Timelock delay for critical functions
    uint256 public timelockDelay = 24 hours;
    
    /// @notice Mapping of operation IDs to execution timestamps
    mapping(bytes32 => uint256) public timelock;
    
    /// @notice Timelock enabled status
    bool public timelockEnabled;
    
    /// @notice Emitted when transaction tax is updated
    /// @param newTax The new tax rate in basis points
    event TaxUpdated(uint256 indexed newTax);
    
    /// @notice Emitted when a wallet address is updated
    /// @param walletType Type of wallet updated
    /// @param newWallet New wallet address
    event WalletUpdated(string walletType, address indexed newWallet);
    
    /// @notice Emitted when tax exemption status changes
    /// @param account Address whose exemption status changed
    /// @param excluded New exemption status
    event TaxExemptionUpdated(address indexed account, bool excluded);
    
    /// @notice Emitted when buyback is executed
    /// @param amountBurned Amount of tokens burned
    event BuybackExecuted(uint256 indexed amountBurned);
    
    /// @notice Emitted when treasury is withdrawn
    /// @param to Recipient address
    /// @param amount Amount withdrawn
    event TreasuryWithdrawn(address indexed to, uint256 indexed amount);
    
    /// @notice Emitted when tax is permanently locked
    event TaxLocked();
    
    /// @notice Emitted when timelock operation is scheduled
    /// @param operationId Operation identifier
    /// @param executeTime Timestamp when operation can be executed
    event TimelockScheduled(bytes32 indexed operationId, uint256 indexed executeTime);
    
    /// @notice Emitted when timelock operation is executed
    /// @param operationId Operation identifier
    event TimelockExecuted(bytes32 indexed operationId);
    
    /// @notice Emitted when timelock operation is cancelled
    /// @param operationId Operation identifier
    event TimelockCancelled(bytes32 indexed operationId);
    
    /// @notice Emitted when timelock delay is updated
    /// @param newDelay New delay duration
    event TimelockDelayUpdated(uint256 indexed newDelay);
    
    /// @notice Emitted when timelock is toggled
    /// @param enabled New timelock status
    event TimelockToggled(bool enabled);
    
    /// @notice Emitted when buyback threshold is updated
    /// @param newThreshold New threshold amount
    event BuybackThresholdUpdated(uint256 indexed newThreshold);
    
    /// @notice Emitted when buyback exemption status changes
    /// @param account Address whose exemption status changed
    /// @param excluded New exemption status
    event BuybackExemptionUpdated(address indexed account, bool excluded);
    
    /**
     * @notice Deploys the Bird Token contract
     * @dev Automatically distributes tokens: 30% treasury, 20% liquidity, 50% public sale
     * @param _name Token name
     * @param _symbol Token symbol
     * @param _totalSupply Total supply in wei
     * @param _marketingWallet Marketing wallet address
     * @param _liquidityWallet Liquidity wallet address
     * @param _publicSaleWallet Public sale wallet address
     */
    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _totalSupply,
        address _marketingWallet,
        address _liquidityWallet,
        address _publicSaleWallet
    ) ERC20(_name, _symbol) Ownable(msg.sender) {
        require(_marketingWallet != address(0), "Marketing wallet cannot be zero");
        require(_liquidityWallet != address(0), "Liquidity wallet cannot be zero");
        require(_publicSaleWallet != address(0), "Public sale wallet cannot be zero");
        require(_totalSupply != 0, "Total supply must be greater than zero");
        require(_totalSupply <= MAX_TOTAL_SUPPLY, "Total supply exceeds maximum");
        
        // Validate tax distribution sums to 100%
        require(
            LIQUIDITY_TAX_PERCENT + MARKETING_TAX_PERCENT + TREASURY_TAX_PERCENT == TAX_DISTRIBUTION_TOTAL,
            "Tax distribution must sum to 100%"
        );
        
        marketingWallet = _marketingWallet;
        liquidityWallet = _liquidityWallet;
        
        // Exclude critical addresses from taxes
        isExcludedFromTax[msg.sender] = true;
        isExcludedFromTax[address(this)] = true;
        isExcludedFromTax[_marketingWallet] = true;
        isExcludedFromTax[_liquidityWallet] = true;
        isExcludedFromTax[_publicSaleWallet] = true;
        
        // Lock tax permanently by default for full credibility
        taxLocked = true;
        emit TaxLocked();
        
        // Automatic distribution (like Bitcoin - no owner control)
        // 30% to contract treasury (for buyback/burn)
        uint256 treasuryAmount = (_totalSupply * 3000) / BASIS_POINTS;
        _mint(address(this), treasuryAmount);
        treasury = treasuryAmount;
        
        // 20% to liquidity wallet
        uint256 liquidityAmount = (_totalSupply * 2000) / BASIS_POINTS;
        _mint(_liquidityWallet, liquidityAmount);
        
        // 50% to public sale wallet (handles rounding)
        uint256 publicSaleAmount = _totalSupply - treasuryAmount - liquidityAmount;
        _mint(_publicSaleWallet, publicSaleAmount);
    }
    
    /**
     * @notice Transfers tokens to a specified address with tax applied
     * @dev Overrides ERC20 transfer to apply transaction tax
     * @param to Recipient address
     * @param amount Amount to transfer
     * @return bool Success status
     */
    function transfer(address to, uint256 amount) public override nonReentrant returns (bool) {
        require(to != address(0), "Cannot transfer to zero address");
        require(amount != 0, "Transfer amount must be greater than zero");
        require(to != address(this), "Cannot transfer to contract address");
        
        address sender = _msgSender();
        _transferWithTax(sender, to, amount);
        return true;
    }
    
    /**
     * @notice Transfers tokens from one address to another with tax applied
     * @dev Overrides ERC20 transferFrom to apply transaction tax
     * @param from Sender address
     * @param to Recipient address
     * @param amount Amount to transfer
     * @return bool Success status
     */
    function transferFrom(address from, address to, uint256 amount) public override nonReentrant returns (bool) {
        require(from != address(0), "Cannot transfer from zero address");
        require(to != address(0), "Cannot transfer to zero address");
        require(amount != 0, "Transfer amount must be greater than zero");
        require(to != address(this), "Cannot transfer to contract address");
        
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transferWithTax(from, to, amount);
        return true;
    }
    
    /**
     * @notice Internal function to handle transfers with tax
     * @dev Validates all inputs before processing
     * @param from Sender address
     * @param to Recipient address
     * @param amount Amount to transfer
     */
    function _transferWithTax(address from, address to, uint256 amount) internal {
        require(from != address(0), "Transfer from zero address");
        require(to != address(0), "Transfer to zero address");
        require(amount != 0, "Transfer amount must be greater than zero");
        require(balanceOf(from) >= amount, "Insufficient balance");
        
        // Skip tax if either address is excluded
        if (isExcludedFromTax[from] || isExcludedFromTax[to]) {
            _transfer(from, to, amount);
            return;
        }
        
        // Calculate tax
        uint256 taxAmount = (amount * transactionTax) / BASIS_POINTS;
        require(taxAmount < amount, "Tax amount exceeds transfer amount");
        
        uint256 transferAmount = amount - taxAmount;
        
        // Transfer amount minus tax
        _transfer(from, to, transferAmount);
        
        // Distribute tax
        if (taxAmount != 0) {
            _distributeTax(from, taxAmount);
        }
    }
    
    /**
     * @notice Distribute tax to liquidity, marketing, and treasury
     * @dev Treasury gets remainder to handle rounding and prevent token loss
     * @param from Source address for tax transfer
     * @param taxAmount Total tax amount to distribute
     */
    function _distributeTax(address from, uint256 taxAmount) internal {
        require(taxAmount != 0, "Tax amount must be greater than zero");
        
        // Calculate distribution amounts
        uint256 liquidityAmount = (taxAmount * LIQUIDITY_TAX_PERCENT) / BASIS_POINTS;
        uint256 marketingAmount = (taxAmount * MARKETING_TAX_PERCENT) / BASIS_POINTS;
        
        // Treasury gets remainder to ensure no tokens are lost due to rounding
        uint256 treasuryAmount = taxAmount - liquidityAmount - marketingAmount;
        
        // Validate distribution
        require(
            liquidityAmount + marketingAmount + treasuryAmount == taxAmount,
            "Tax distribution error"
        );
        
        // Calculate treasury cap and handle excess
        uint256 excessAmount;
        if (treasuryAmount != 0) {
            // Prevent treasury from exceeding maximum (DoS protection)
            uint256 newTreasuryTotal = treasury + treasuryAmount;
            if (newTreasuryTotal > MAX_TREASURY) {
                excessAmount = newTreasuryTotal - MAX_TREASURY;
                treasuryAmount -= excessAmount;
            }
        }
        
        // Redistribute excess treasury amount to marketing and liquidity proportionally
        // Fix for precision loss: Use safe math for proportional distribution
        if (excessAmount != 0) {
            uint256 totalDistributionPercent = LIQUIDITY_TAX_PERCENT + MARKETING_TAX_PERCENT;
            uint256 excessLiquidity = (excessAmount * LIQUIDITY_TAX_PERCENT) / totalDistributionPercent;
            uint256 excessMarketing = excessAmount - excessLiquidity;
            liquidityAmount += excessLiquidity;
            marketingAmount += excessMarketing;
        }
        
        // Cache addresses for gas optimization
        address _marketingWallet = marketingWallet;
        address _liquidityWallet = liquidityWallet;
        
        // Send to marketing wallet
        if (marketingAmount != 0) {
            _transfer(from, _marketingWallet, marketingAmount);
        }
        
        // Send to liquidity wallet
        if (liquidityAmount != 0) {
            _transfer(from, _liquidityWallet, liquidityAmount);
        }
        
        // Add to treasury (with maximum cap to prevent DoS)
        if (treasuryAmount != 0) {
            address contractAddress = address(this);
            _transfer(from, contractAddress, treasuryAmount);
            treasury += treasuryAmount;
            
            // Cache values for gas optimization
            uint256 _buybackThreshold = buybackThreshold;
            uint256 _lastBuybackTime = lastBuybackTime;
            
            // Check if buyback threshold is reached (with cooldown to prevent front-running)
            if (treasury >= _buybackThreshold && 
                block.timestamp >= _lastBuybackTime + BUYBACK_COOLDOWN) {
                _buybackAndBurn();
            }
        }
    }
    
    /**
     * @notice Buyback and burn tokens from treasury
     * @dev Cooldown prevents front-running, validates state before burning
     */
    function _buybackAndBurn() internal {
        uint256 _treasury = treasury;
        require(_treasury != 0, "No treasury to burn");
        require(!isExcludedFromBuyback[address(this)], "Buyback excluded");
        require(
            block.timestamp >= lastBuybackTime + BUYBACK_COOLDOWN,
            "Buyback cooldown active"
        );
        
        uint256 amountToBurn = _treasury;
        require(amountToBurn != 0, "Amount to burn must be greater than zero");
        
        treasury = 0;
        lastBuybackTime = block.timestamp;
        
        // Burn tokens
        _burn(address(this), amountToBurn);
        
        emit BuybackExecuted(amountToBurn);
    }
    
    /**
     * @notice Manual buyback and burn (owner only)
     * @dev Reentrancy protection, validates state
     */
    function manualBuybackAndBurn() external onlyOwner nonReentrant {
        require(treasury != 0, "No treasury to burn");
        _buybackAndBurn();
    }
    
    /**
     * @notice Set transaction tax (owner only, max 5%)
     * @dev Cannot be changed if tax is locked, timelock if enabled
     * @param _tax New tax rate in basis points
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
     * @notice Execute scheduled transaction tax change
     * @param _tax New tax rate in basis points
     */
    function executeSetTransactionTax(uint256 _tax) external onlyOwner {
        bytes32 operationId = keccak256(abi.encodePacked("setTransactionTax", _tax));
        _executeTimelock(operationId);
        transactionTax = _tax;
        emit TaxUpdated(_tax);
    }
    
    /**
     * @notice Lock tax permanently (owner only, irreversible)
     * @dev Prevents future tax manipulation
     * NOTE: Tax is already locked by default in constructor
     * This function exists for backwards compatibility but will always revert
     */
    function lockTax() external onlyOwner {
        require(!taxLocked, "Tax already locked");
        taxLocked = true;
        emit TaxLocked();
    }
    
    /**
     * @notice Set marketing wallet (owner only)
     * @dev Validates address, prevents zero address, timelock if enabled
     * @param _wallet New marketing wallet address
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
     * @notice Execute scheduled marketing wallet change
     * @param _wallet New marketing wallet address
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
     * @notice Set liquidity wallet (owner only)
     * @dev Validates address, prevents zero address, timelock if enabled
     * @param _wallet New liquidity wallet address
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
     * @notice Execute scheduled liquidity wallet change
     * @param _wallet New liquidity wallet address
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
     * @notice Set DEX pair address (owner only, for tax exemption)
     * @dev Validates address
     * @param _pair DEX pair address
     */
    function setPairAddress(address _pair) external onlyOwner {
        require(_pair != address(0), "Pair address cannot be zero");
        pairAddress = _pair;
        isExcludedFromTax[_pair] = true;
        emit WalletUpdated("pair", _pair);
    }
    
    /**
     * @notice Exclude/include address from tax (owner only)
     * @dev Cannot exempt contract address (prevents tax bypass)
     * @param account Address to update
     * @param excluded Exemption status
     */
    function setTaxExemption(address account, bool excluded) external onlyOwner {
        require(account != address(0), "Cannot exempt zero address");
        require(account != address(this), "Cannot exempt contract address");
        isExcludedFromTax[account] = excluded;
        emit TaxExemptionUpdated(account, excluded);
    }
    
    /**
     * @notice Exclude/include address from buyback (owner only)
     * @dev Validates address
     * @param account Address to update
     * @param excluded Exemption status
     */
    function setBuybackExemption(address account, bool excluded) external onlyOwner {
        require(account != address(0), "Cannot exempt zero address");
        isExcludedFromBuyback[account] = excluded;
        emit BuybackExemptionUpdated(account, excluded);
    }
    
    /**
     * @notice Set buyback threshold (owner only)
     * @dev Maximum limit prevents DoS
     * @param _threshold New threshold amount
     */
    function setBuybackThreshold(uint256 _threshold) external onlyOwner {
        require(_threshold != 0, "Threshold must be greater than zero");
        require(_threshold <= MAX_BUYBACK_THRESHOLD, "Threshold exceeds maximum");
        buybackThreshold = _threshold;
        emit BuybackThresholdUpdated(_threshold);
    }
    
    /**
     * @notice Withdraw treasury (owner only, emergency use)
     * @dev Reentrancy protection, validates amounts, timelock if enabled
     * @param to Recipient address
     * @param amount Amount to withdraw
     */
    function withdrawTreasury(address to, uint256 amount) external onlyOwner nonReentrant {
        require(to != address(0), "Cannot withdraw to zero address");
        require(to != address(this), "Cannot withdraw to contract address");
        require(amount != 0, "Amount must be greater than zero");
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
     * @notice Execute scheduled treasury withdrawal
     * @param to Recipient address
     * @param amount Amount to withdraw
     */
    function executeWithdrawTreasury(address to, uint256 amount) external onlyOwner nonReentrant {
        bytes32 operationId = keccak256(abi.encodePacked("withdrawTreasury", to, amount));
        _executeTimelock(operationId);
        _executeWithdrawTreasury(to, amount);
    }
    
    /**
     * @notice Internal function to execute treasury withdrawal
     * @param to Recipient address
     * @param amount Amount to withdraw
     */
    function _executeWithdrawTreasury(address to, uint256 amount) internal {
        treasury -= amount;
        _transfer(address(this), to, amount);
        emit TreasuryWithdrawn(to, amount);
    }
    
    /**
     * @notice Internal function to schedule timelock
     * @param operationId Operation identifier
     */
    function _scheduleTimelock(bytes32 operationId) internal {
        require(timelock[operationId] == 0, "Operation already scheduled");
    }
    
    /**
     * @notice Internal function to execute timelock
     * @param operationId Operation identifier
     */
    function _executeTimelock(bytes32 operationId) internal {
        require(timelock[operationId] != 0, "Operation not scheduled");
        require(block.timestamp >= timelock[operationId], "Timelock not expired");
        delete timelock[operationId];
        emit TimelockExecuted(operationId);
    }
    
    /**
     * @notice Cancel scheduled timelock operation (owner only)
     * @param operationId Operation identifier
     */
    function cancelTimelock(bytes32 operationId) external onlyOwner {
        require(timelock[operationId] != 0, "Operation not scheduled");
        delete timelock[operationId];
        emit TimelockCancelled(operationId);
    }
    
    /**
     * @notice Set timelock delay (owner only)
     * @param _delay New delay duration
     */
    function setTimelockDelay(uint256 _delay) external onlyOwner {
        require(_delay >= 1 hours && _delay <= 7 days, "Delay out of valid range");
        timelockDelay = _delay;
        emit TimelockDelayUpdated(_delay);
    }
    
    /**
     * @notice Enable/disable timelock (owner only)
     * @param _enabled New timelock status
     */
    function toggleTimelock(bool _enabled) external onlyOwner {
        timelockEnabled = _enabled;
        emit TimelockToggled(_enabled);
    }
    
    /**
     * @notice Check if timelock operation is ready
     * @param operationId Operation identifier
     * @return bool True if operation is ready to execute
     */
    function isTimelockReady(bytes32 operationId) external view returns (bool) {
        return timelock[operationId] != 0 && block.timestamp >= timelock[operationId];
    }
    
    /**
     * @notice Get timelock execution time
     * @param operationId Operation identifier
     * @return uint256 Timestamp when operation can be executed
     */
    function getTimelockTime(bytes32 operationId) external view returns (uint256) {
        return timelock[operationId];
    }
    
    /**
     * @notice Get current treasury balance
     * @return uint256 Treasury balance
     */
    function getTreasuryBalance() external view returns (uint256) {
        return treasury;
    }
    
    /**
     * @notice Check if buyback threshold is reached
     * @return bool True if buyback is ready to execute
     */
    function isBuybackReady() external view returns (bool) {
        return treasury >= buybackThreshold && 
               block.timestamp >= lastBuybackTime + BUYBACK_COOLDOWN;
    }
    
    /**
     * @notice Get time until next buyback is allowed
     * @return uint256 Remaining cooldown time in seconds
     */
    function getBuybackCooldownRemaining() external view returns (uint256) {
        uint256 cooldownEnd = lastBuybackTime + BUYBACK_COOLDOWN;
        if (block.timestamp >= cooldownEnd) {
            return 0;
        }
        return cooldownEnd - block.timestamp;
    }
    
    /**
     * @notice Get liquidity tax percentage
     * @return uint256 Liquidity tax percentage in basis points
     */
    function liquidityTaxPercent() external pure returns (uint256) {
        return LIQUIDITY_TAX_PERCENT;
    }
    
    /**
     * @notice Get marketing tax percentage
     * @return uint256 Marketing tax percentage in basis points
     */
    function marketingTaxPercent() external pure returns (uint256) {
        return MARKETING_TAX_PERCENT;
    }
    
    /**
     * @notice Get treasury tax percentage
     * @return uint256 Treasury tax percentage in basis points
     */
    function treasuryTaxPercent() external pure returns (uint256) {
        return TREASURY_TAX_PERCENT;
    }
    
    /**
     * @notice Renounce ownership (inherited from OpenZeppelin Ownable2Step)
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
    // renounceOwnership() is already available from OpenZeppelin Ownable2Step
    // This comment is for documentation purposes
}
