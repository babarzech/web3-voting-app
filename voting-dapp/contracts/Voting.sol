// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    struct Proposal {
        string description;
        uint voteCount;
    }

    Proposal[] public proposals;
    mapping(address => bool) public voters;

    function createProposal(string memory _description) public {
        proposals.push(Proposal({
            description: _description,
            voteCount: 0
        }));
    }

    function vote(uint _proposalIndex) public {
        require(!voters[msg.sender], "You have already voted.");
        require(_proposalIndex < proposals.length, "Proposal does not exist.");

        voters[msg.sender] = true;
        proposals[_proposalIndex].voteCount += 1;
    }

    function getProposal(uint _proposalIndex) public view returns (string memory description, uint voteCount) {
        require(_proposalIndex < proposals.length, "Proposal does not exist.");

        Proposal storage proposal = proposals[_proposalIndex];
        return (proposal.description, proposal.voteCount);
    }
}

