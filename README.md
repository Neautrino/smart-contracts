# Smart Contracts Collection

This project contains three Solidity-based smart contracts: **PocketMoney**, **EventOrganiser**, and **CrowdFunding**. Each contract has a specific purpose and includes admin control and secure fund management features.

## 1. PocketMoney Smart Contract

### Description

The **PocketMoney** smart contract allows an admin (the contract deployer) to send funds to kids (specific addresses) with a maturity date. Once the maturity date is reached, the kids can withdraw their funds.

### Key Features

- **Admin Control**: Only the admin (contract deployer) can add kids and assign funds.
- **Maturity Period**: Kids can only withdraw their assigned funds after a set maturity period.
- **One-Time Withdrawal**: Each kid can withdraw their funds only once.

## 2. EventOrganiser Smart Contract

### Description

The **EventOrganiser** smart contract allows users to create events, sell tickets, and manage ticket transfers. An admin or any external user can create events, while users can buy tickets and transfer them to others. This contract ensures that events are managed efficiently, with real-time availability of tickets and secure ticket transfers.

### Key Features

- **Event Creation**: Any user can create an event with details like event name, date, ticket price, and total number of tickets.
- **Ticket Purchase**: Users can buy tickets for an event if available and the event's date has not passed.
- **Ticket Transfer**: Users can transfer tickets to others before the event date.
- **Fund Withdrawal**: Only the event organizer can withdraw funds collected from ticket sales.

## 3. CrowdFunding Smart Contract

### Description

The **CrowdFunding** smart contract allows users to contribute funds towards a specific target within a deadline. The funds are used to finance requests for specific purposes, with contributors having the power to vote on fund allocation.

### Key Features

- **Contributions**: Users can contribute funds towards a project. If the target is not met by the deadline, they can request a refund.
- **Requests for Funds**: The admin (contract deployer) can create requests to allocate the collected funds for specific purposes.
- **Voting System**: Contributors can vote on requests. Only requests that receive majority approval can be funded.
- **Secure Fund Release**: Funds are released only when a request receives more than 50% approval from contributors.

---

### Solidity Version

The contracts are compatible with Solidity version `^0.8.24`.

## Installation & Usage

1. Install a Solidity development environment like [Remix](https://remix.ethereum.org) or [Hardhat](https://hardhat.org).
2. Deploy the contracts to an Ethereum-compatible network.
3. For the **PocketMoney** contract:
   - The deployer becomes the admin and can assign pocket money to addresses with maturity dates.
   - Kids can withdraw funds only after the maturity period ends.
4. For the **EventOrganiser** contract:
   - Any user can create an event.
   - Users can buy tickets for events and transfer tickets to others.
   - Event organizers can withdraw funds from ticket sales.
5. For the **CrowdFunding** contract:
   - Users can contribute funds towards a target within a deadline.
   - Admin can create requests to allocate funds.
   - Contributors vote to approve fund allocations.
   - If the target is not met, contributors can request refunds.

## License

This project is licensed under the MIT License.
