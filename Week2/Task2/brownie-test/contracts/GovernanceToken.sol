pragma solidity 0.6.12;

// SPDX-License-Identifier: MIT


import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";


contract GovernanceToken {
    using SafeMath for uint256;
    struct Candidate {
        address candidateAddress;
        uint256 balance;
        uint256 portion;
    }

    mapping (uint => Candidate) private candidates;
    uint256 private fullBalance ; // Будет ли балансе храниться все время как и кол-во кандидатов и сами кандидаты?

    uint private candidatesCount;

    constructor() public {
        candidatesCount = 0;
    }
    
    string public symbol;
    string public name;
    uint256 public decimals;
    uint256 public totalSupply;

    // payable function where ether is coming
    function deposit() public payable {
        shareIncome(msg.value);
    }

    // share coming ether between candidates
    function shareIncome(uint value) private {
        for (uint i = 0; i < candidatesCount; i++){
            transfer(candidates[i].candidateAddress, value * candidate[i].portion);
        }

        fullBalance += value;
    }

    // transfer ether to particular address
    function transfer(address _to, uint _amount) {
        _to.transfer(_amount);
    }

    // Add new candidate to the candidates set
    function addCandidate(address _candidateAddress, uint256 _balance) public {
        candidate = Candidate(msg.sender, msg.value, msg.value / fullBalance); // ?
        require(_balance > 0);
        fullBalance += _balance;
        for (uint i = 0; i < candidatesCount; i++) {
            candidates[i].portion = candidates[i].balance / fullBalance;
        }
        
        candidatesCount++;
        candidates[candidatesCount] = Candidate(_candidateAddress, msg. / fullBalance);
        candidatesCount++;
    }
}