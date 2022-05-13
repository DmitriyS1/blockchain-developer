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

    struct Voter {
        bool isVoted;
        uint8 candidateNumber;
    }

    // Setting variables
    uint8 private constant candidatesLimit = 10;
    bool private isElectionAllowed;
    bool private isElectionFinished;
    address private owner;
    address private tokenAddress;

    mapping(address => Voter) public voters;
    Candidate[] public candidates;
    uint8 public candidateCount;

    string public winner;

    constructor(address electionTokenAddress) {
        tokenAddress = electionTokenAddress;
        candidateCount = 0;
        owner = msg.sender;
        winner = "";
        isElectionAllowed = false;
        isElectionFinished = true;
    }

    function addCandidate(string calldata name) public {
        require(candidates.length < candidatesLimit, "Candidates limit reached");
        candidateCount += 1;
        candidates.push(Candidate({
            number: candidateCount - 1,
            name: name,
            votes: 0
        }));
    }

    function electCandidate(uint8 number) public {
        require(isElectionAllowed && !isElectionFinished, "Election is not allowed for now"); // looks not good
        require(candidateCount > 0, "No candidates added");
        require(number >= 0 && number < candidatesLimit, "Candidate number out of range");
        require(candidates[number].number == number, "Candidate number is not valid");
        require(!voters[msg.sender].isVoted, "You already voted");

        isElectionAllowed = false; // how to use finite state machine here and not a mutex?
        voters[msg.sender].isVoted = true;
        voters[msg.sender].candidateNumber = number;
        candidates[number].votes += ERC20(tokenAddress).balanceOf(msg.sender);
        isElectionAllowed = true;
    }

    function startElection() public {
        require(isElectionFinished, "Election is already started");
        require(msg.sender == owner, "Only owner can start election");
        isElectionFinished = false;
        isElectionAllowed = true;
        winner = "";
    }

    function endElection() public {
        require(msg.sender == owner, "Only owner can end election");
        isElectionFinished = true;
        isElectionAllowed = false;
    }

    function getWinner() public {
        require(isElectionFinished, "Election is not finished");
        require(!isElectionAllowed, "Election in process");

        winner = candidates[0].name;
        if (keccak256(bytes(winner)) != keccak256(bytes(""))){
            return ;
        }

        for (uint8 i = 1; i < candidateCount; i++) {
            if (candidates[i].votes > candidates[0].votes) {
                candidates[0].name = candidates[i].name;
                candidates[0].votes = candidates[i].votes;
            }
        }

        winner = candidates[0].name;
    }

    function seeWinner() public view returns (string memory) {
        return winner;
    }
}