// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract CrowdFunding {
    struct Request {
        string description;
        address payable recipient;
        uint256 value;
        bool completed;
        uint256 noOfVoters;
        mapping(address => bool) voters;
    }
    mapping(address => uint256) public contributors;
    mapping(uint256 => Request) public requests;
    uint256 public noOfRequests;
    address public manager;
    uint256 public minimumContribution;
    uint256 public deadline;
    uint256 public target;
    uint256 public raisedAmount;
    uint256 public noOfContributions;

    constructor(uint256 _target, uint256 _deadline) {
        manager = msg.sender;
        target = _target;
        deadline = block.timestamp + (_deadline * 1 days); // _deadline is in days.

        minimumContribution = 0.001 ether;
    }

    modifier onlyManager() {
        require(msg.sender == manager, "You are not the manager");
        _;
    }

    function createRequests(
        string calldata _description,
        address payable _recipient,
        uint256 _value
    ) public onlyManager {
        Request storage newRequest = requests[noOfRequests];
        noOfRequests++;
        newRequest.description = _description;
        newRequest.recipient = _recipient;
        newRequest.value = _value;
        newRequest.completed = false;
        newRequest.noOfVoters = 0;
    }

    function contribution() public payable {
        require(block.timestamp < deadline, "Deadline has passed.");
        require(msg.value > minimumContribution, "Minimum contribution required is 100 wei.");

        if(contributors[msg.sender] == 0){
            noOfContributions++;
        }

        contributors[msg.sender] += msg.value;
        raisedAmount += msg.value;
    }

    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }

    function refund() public {
        require(deadline<block.timestamp && target > raisedAmount, "You are not eligible for the refund");
        require(contributors[msg.sender] > 0, "No contribution made to refund.");
        payable (msg.sender).transfer (contributors[msg.sender]);
        contributors[msg.sender] = 0;
    }

    function voteRequest(uint _requestId) public {
        require(contributors[msg.sender]>0, "You are not a contributor");
        Request storage thisRequest = requests[_requestId];
        require(thisRequest.voters[msg.sender]==false, "You have already voted.");
        thisRequest.voters[msg.sender] = true;
        thisRequest.noOfVoters ++;
    }

    function makePayment(uint _requestId) public onlyManager{
        require(raisedAmount >= target, "Target is not reached");
        Request storage thisRequest = requests[_requestId];
        require(thisRequest.completed == false, "The request has been completed.");
        require(thisRequest.noOfVoters > noOfContributions/2, "Maturity does not support the request.");
        thisRequest.recipient.transfer(thisRequest.value);
        thisRequest.completed = true;
    }


}
