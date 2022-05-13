// "SPDX-License-Identifier: MIT"
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./ElectionToken.sol";

contract Election {
    struct Candidate {
        uint8 number;
        string name;
        uint256 votes;
    }

    ElectionToken token;
    Candidate[] public candidates;
    uint8 private candidateCount;

    uint8 private constant candidatesLimit = 10;

    bool private isElectionAllowed = true;
    bool private isElectionFinished = false;
    address private owner;
    address private tokenAddress;
    string private winner;

    constructor(address electionTokenAddress) {
        candidates = new Candidate[](candidatesLimit);
        tokenAddress = electionTokenAddress;
        candidateCount = 0;
        owner = msg.sender;
        winner = "";
    }

    function addCandidate(string memory name) public {
        require(candidates.length < candidatesLimit, "Candidates limit reached");
        candidateCount += 1;
        candidates[candidateCount - 1].name = name;
        candidates[candidateCount - 1].number = candidateCount - 1;
        candidates[candidateCount - 1].votes = 0;
    }

    function getCandidates() public view returns (Candidate[] memory) {
        return candidates;
    }

    function electCandidate(uint8 number) public {
        require(isElectionAllowed && !isElectionFinished, "Election is not allowed for now"); // looks not good
        require(candidateCount > 0, "No candidates added");
        require(number >= 0 && number < candidatesLimit, "Candidate number out of range");
        require(candidates[number].number == number, "Candidate number is not valid");

        isElectionAllowed = false; // how to use finite state machine here and not a mutex?
        candidates[number].votes += ERC20(tokenAddress).balanceOf(msg.sender);
        isElectionAllowed = true;
    }

    function startElection() public {
        require(msg.sender == owner, "Only owner can start election");
        isElectionFinished = false;
        winner = "";
        candidates = new Candidate[](candidatesLimit);
    }

    function endElection() public {
        require(msg.sender == owner, "Only owner can end election");
        isElectionFinished = true;
    }

    function getWinner() public returns (string memory) {
        require(!isElectionFinished, "Election is not finished");
        require(isElectionAllowed, "Election in process");

        if (keccak256(bytes(winner)) != keccak256(bytes(""))){
            return winner;
        }

        Candidate storage _winner = Candidate(candidates[0].number, candidates[0].name, candidates[0].votes);
        // string storage _winnerName = candidates[0].name;
        // uint storage _winnerVotes = candidates[0].votes;
        for (uint8 i = 1; i < candidateCount; i++) {
            if (candidates[i].votes > _winner.votes) {
                _winner.name = candidates[i].name;
                _winner.votes = candidates[i].votes;
            }
        }

        winner = _winner.name;
        return winner;
    }
}