// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract EventContract{
    struct Event{
        address organizer;
        string name;
        uint256 date;
        uint256 price;
        uint256 totalTicket;
        uint256 ticketRemaining;
    }

    mapping(uint => Event) public events;
    mapping(address => mapping(uint => uint)) public tickets;
    uint public nextId;

    function createEvent(string memory _name, uint _date, uint _price, uint _totalTicket) external {
        require(_date > block.timestamp, "date should be in the future");
        require(_totalTicket > 0, "total ticket must be greater than 0");

        events[nextId]= Event(
            msg.sender,
            _name,
            _date,
            _price,
            _totalTicket,
            _totalTicket
        );

        nextId += 1;
    }

    function buyTicket(uint _eventId,uint _ticketCount) external payable {
        require(events[_eventId].date > block.timestamp, "event not available yet");
        require(events[_eventId].ticketRemaining > _ticketCount, "Enough tickets not available");
        require(events[_eventId].price*_ticketCount <= msg.value, "Insufficent funds");

        events[_eventId].ticketRemaining -= _ticketCount;   
        tickets[msg.sender][_eventId] += _ticketCount;
    }

    function transferTicket(uint _eventId,uint _ticketCount,address _to) external {
        require(events[_eventId].date > block.timestamp, "event not available yet");
        require(tickets[msg.sender][_eventId] >= _ticketCount, "Not enough tickets. Please buy more");
        tickets[msg.sender][_eventId] -= _ticketCount;
        tickets[_to][_eventId] += _ticketCount;
    }

    function withdrawFunds(uint _eventId) external payable {
        require(events[_eventId].organizer==msg.sender, "You must be the creator of the event");
        payable(msg.sender).transfer(address(this).balance);
    }
}
