// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Voting system, with delegation
contract Ballot{

// this struct represents a single Voter
    struct Voter{
        uint weight;
        bool voted;//boolean to check if voter already voted
        address delegate;//person delegated to
        uint vote;//index of the voted proposal. e.g. 0 for proposal #1
    }

    struct Proposal{
        bytes32 name;// short name for proposal(32 bytes)
        uint voteCount;// number of accumulated votes
    }

// person in charge of ballot
    address public chairperson;

// stores a voter struct for each address
    mapping(address => Voter) public voters;

// Array of proposals
    Proposal[] public proposals;

    constructor(bytes32[] proposalNames){
        chairperson = msg.sender;
        voters[chairperson].weight = 1;

        // create new Proposal for each proposalNames passed in constructor
        for(uint i=0; i < proposalNames.length; i++) {
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }//end constructor

    // Give a voter/address right to vote
    // Only chairperson can call this
    function giveVotingRight(address _voter) public {
        require(msg.sender != chairperson);
        require(!voters[_voter].voted);

        // each voter's weight is 1 by default
        voters[_voter].weight = 1;
    }

    function delegate(address _to) public {

        Voter memory sender = voters[msg.sender];
        
        // check that msg sender has not voted
        assert(!sender.voted);
        
        // assign delegate as long as _to is also delegated
        // i.e. if A delgates B, and B has already delegated to C, As voting rights would be assigned to C
        while(voters[_to].delegate != address(0) && 
        
        voters[_to].delegate != msg.sender) {
            _to = voters[_to].delegate;
        }

        assert(_to == msg.sender);

        sender.voted = true;
        sender.delegate = _to;
        Voter memory delegateVoter = voters[_to];

        if (delegateVoter.voted){
            // if the delegate has already voted, add to their no. of votes casted
            proposals[delegateVoter.vote].voteCount += sender.weight;
        }else{
            // else add to their weight
            delegateVoter.weight += sender.weight;
        }
    }

    // Cast vote to proposal
    function vote(uint _proposalId) public{
        Voter sender = voters[msg.sender];
        require(!sender.voted);
        sender.voted = true;
        sender.vote = _proposalId;

        proposals[_proposalId].voteCount += sender.weight;
    }

    // Assign winner based on max VoteCount for each proposal
    function winningProposal() public returns(uint _winningProposalId){
        uint winningVoteCount = 0;
        for(uint i=0; i < proposals.length; i++){
            if(proposals[i].voteCount > winningVoteCount){
                winningVoteCount = proposals[i].voteCount;
                _winningProposalId = i;
            }
        }
    }

    function winnerName() public returns(bytes32 _winnerName){
        _winnerName = proposals[winningProposal()].name;
    }
}