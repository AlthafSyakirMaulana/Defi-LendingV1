// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ISimpleLendingProtocol {
    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);
    event Borrow(address indexed user, uint256 amount);
    event Repay(address indexed user, uint256 amount);
    event Liquidate(address indexed user, uint256 amount); // Tambahkan jika ada fungsi likuidasi

    function deposit(uint256 _amount) external;
    function withdraw(uint256 _amount) external;
    function borrow(uint256 _amount) external;
    function repay(uint256 _amount) external;
    function liquidate(address _user) external; // Tambahkan jika ada fungsi likuidasi
    function calculateInterest(address _user) external view returns (uint256);

    function deposits(address _user) external view returns (uint256);
    function borrows(address _user) external view returns (uint256);
}
