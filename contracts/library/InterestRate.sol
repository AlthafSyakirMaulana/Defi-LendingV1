// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library InterestRate {
    uint256 public constant BASE_RATE = 2; // 2% base rate
    uint256 public constant RATE_MULTIPLIER = 4; // 4% max additional rate
    uint256 public constant UTILIZATION_THRESHOLD = 80; // 80% utilization threshold

    function calculateInterestRate(uint256 _totalBorrows, uint256 _totalDeposits) internal pure returns (uint256) {
        if (_totalDeposits == 0) return 0;
        
        uint256 utilization = (_totalBorrows * 100) / _totalDeposits;
        
        if (utilization <= UTILIZATION_THRESHOLD) {
            return BASE_RATE + (utilization * RATE_MULTIPLIER) / UTILIZATION_THRESHOLD;
        } else {
            uint256 excessUtilization = utilization - UTILIZATION_THRESHOLD;
            return BASE_RATE + RATE_MULTIPLIER + (excessUtilization * RATE_MULTIPLIER) / (100 - UTILIZATION_THRESHOLD);
        }
    }

    function calculateInterest(uint256 _amount, uint256 _rate, uint256 _timeInSeconds) internal pure returns (uint256) {
        return (_amount * _rate * _timeInSeconds) / (365 days) / 100;
    }
}
