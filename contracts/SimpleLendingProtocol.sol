// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./library/InterestRate.sol";

contract SimpleLendingProtocol is ReentrancyGuard, Pausable, Ownable {
    using InterestRate for uint256;

    mapping(address => uint256) public deposits;
    mapping(address => uint256) public borrows;
    mapping(address => uint256) public lastBorrowTime;

    IERC20 public immutable token;
    uint256 public constant COLLATERAL_FACTOR = 75; // 75% collateral factor
    uint256 public constant LIQUIDATION_THRESHOLD = 50; // 50% threshold for liquidation

    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);
    event Borrow(address indexed user, uint256 amount);
    event Repay(address indexed user, uint256 amount);
    event Liquidate(address indexed user, uint256 amount);

    constructor(address _token) {
        token = IERC20(_token);
    }

    function deposit(uint256 _amount) external nonReentrant whenNotPaused {
        require(_amount > 0, "Amount must be greater than 0");
        require(token.transferFrom(msg.sender, address(this), _amount), "Transfer failed");

        deposits[msg.sender] += _amount;
        emit Deposit(msg.sender, _amount);
    }

    function withdraw(uint256 _amount) external nonReentrant whenNotPaused {
        updateInterest(msg.sender);
        uint256 userDeposit = deposits[msg.sender]; 
        require(_amount > 0, "Amount must be greater than 0");
        require(userDeposit >= _amount, "Insufficient balance");

        deposits[msg.sender] = userDeposit - _amount; 
        require(token.transfer(msg.sender, _amount), "Withdraw failed");
        emit Withdraw(msg.sender, _amount);
    }

    function borrow(uint256 _amount) external nonReentrant whenNotPaused {
        updateInterest(msg.sender);
        require(_amount > 0, "Amount must be greater than 0");
        
        uint256 userDeposit = deposits[msg.sender]; 
        uint256 maxBorrow = userDeposit * COLLATERAL_FACTOR / 100;
        require(borrows[msg.sender] + _amount <= maxBorrow, "Exceeds allowed borrow amount");

        borrows[msg.sender] += _amount;
        lastBorrowTime[msg.sender] = block.timestamp;
        require(token.transfer(msg.sender, _amount), "Transfer failed");
        emit Borrow(msg.sender, _amount);
    }

    function repay(uint256 _amount) external nonReentrant whenNotPaused {
        updateInterest(msg.sender);
        require(_amount > 0, "Amount must be greater than 0");
        require(borrows[msg.sender] >= _amount, "Repay amount exceeds borrow balance");
        require(token.transferFrom(msg.sender, address(this), _amount), "Transfer failed");

        borrows[msg.sender] -= _amount;
        emit Repay(msg.sender, _amount);
    }

    function updateInterest(address _user) internal {
        if (borrows[_user] > 0) {
            uint256 timeDiff = block.timestamp - lastBorrowTime[_user];
            uint256 interest = borrows[_user] * InterestRate.BASE_RATE / 100 * timeDiff / 365 days;
            borrows[_user] += interest;
            lastBorrowTime[_user] = block.timestamp;
        }
    }

    function calculateInterest(address _user) public view returns (uint256) {
        if (borrows[_user] > 0) {
            uint256 timeDiff = block.timestamp - lastBorrowTime[_user];
            return borrows[_user] * InterestRate.BASE_RATE / 100 * timeDiff / 365 days;
        } else {
            return 0;
        }
    }

    function liquidate(address _user) external nonReentrant whenNotPaused {
        updateInterest(_user);

        uint256 collateralValue = deposits[_user] * COLLATERAL_FACTOR / 100;
        uint256 borrowValue = borrows[_user];

        require(borrowValue > collateralValue * LIQUIDATION_THRESHOLD / 100, "Cannot liquidate");

        uint256 liquidationAmount = deposits[_user];
        deposits[_user] = 0;
        borrows[_user] = 0;

        require(token.transfer(msg.sender, liquidationAmount), "Transfer failed");
        emit Liquidate(_user, liquidationAmount);
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }
}
