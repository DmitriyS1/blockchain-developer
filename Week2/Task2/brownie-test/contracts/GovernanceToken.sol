pragma solidity 0.6.12;

// SPDX-License-Identifier: MIT


import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
// import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
// import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
// import "OpenZeppelin/contracts/access/Ownable.sol";
// import "@openzeppelin/contracts/utils/math/Math.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";


contract GovernanceToken {
    using SafeMath for uint256;
    struct Candidate {
        address candidateAddress;
        uint256 balance;
        uint256 portion;
    }

    mapping (uint => Candidate) private candidates;
    uint256 private fullBalance ;

    uint public candidatesCount;

    constructor() public {
        candidatesCount = 0;
    }
    
    string public symbol;
    string public name;
    uint256 public decimals;
    uint256 public totalSupply;

    function addCandidate(address _candidateAddress, uint256 _balance) public {
        require(_balance > 0);
        fullBalance += _balance;
        for (uint i = 0; i < candidatesCount; i++) {
            candidates[i].portion = candidates[i].balance / fullBalance;
        }

        candidates.push(Candidate(_candidateAddress, _balance / fullBalance));
        candidatesCount++;
    }

    function pay(uint value) public {
        require(candidatesCount > 0);
        for (uint i = 0; i < candidatesCount; i++) {
            candidates[i].candidateAddress.transfer(value * candidates[i].portion / 100);
        }

        fullBalance += value;
    }
}