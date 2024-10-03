// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract SimpleLendingProtocol is ReentrancyGuard {
    using SafeMath for uint256;

    mapping(address => uint256) public deposits;
    mapping(address => uint256) public borrows;
    
    IERC20 public immutable token;
    uint256 public constant INTEREST_RATE = 5; // 5% per year
    uint256 public constant COLLATERAL_FACTOR = 75; // 75% collateral factor

    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);
    event Borrow(address indexed user, uint256 amount);
    event Repay(address indexed user, uint256 amount);

    constructor(address _token) {
        token = IERC20(_token);
    }

    function deposit(uint256 _amount) external nonReentrant {
        require(_amount > 0, "Amount must be greater than 0");
        require(token.transferFrom(msg.sender, address(this), _amount), "Transfer failed");
        deposits[msg.sender] = deposits[msg.sender].add(_amount);
        emit Deposit(msg.sender, _amount);
    }

    function withdraw(uint256 _amount) external nonReentrant {
        require(_amount > 0, "Amount must be greater than 0");
        require(deposits[msg.sender] >= _amount, "Insufficient balance");
        deposits[msg.sender] = deposits[msg.sender].sub(_amount);
        require(token.transfer(msg.sender, _amount), "Transfer failed");
        emit Withdraw(msg.sender, _amount);
    }

    function borrow(uint256 _amount) external nonReentrant {
        require(_amount > 0, "Amount must be greater than 0");
        uint256 maxBorrow = deposits[msg.sender].mul(COLLATERAL_FACTOR).div(100);
        require(borrows[msg.sender].add(_amount) <= maxBorrow, "Exceeds allowed borrow amount");
        borrows[msg.sender] = borrows[msg.sender].add(_amount);
        require(token.transfer(msg.sender, _amount), "Transfer failed");
        emit Borrow(msg.sender, _amount);
    }

    function repay(uint256 _amount) external nonReentrant {
        require(_amount > 0, "Amount must be greater than 0");
        require(borrows[msg.sender] >= _amount, "Repay amount exceeds borrow balance");
        require(token.transferFrom(msg.sender, address(this), _amount), "Transfer failed");
        borrows[msg.sender] = borrows[msg.sender].sub(_amount);
        emit Repay(msg.sender, _amount);
    }

    function calculateInterest(address _user) public view returns (uint256) {
        return borrows[_user].mul(INTEREST_RATE).div(100).div(365);
    }
}