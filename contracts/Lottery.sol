// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

error InsufficientFunds();
error NotOwner();

contract Lottery {

    address public immutable owner;

    uint256 public lotteryId;

    address payable[] public players;

    mapping (uint256 => address payable) public lotteryHistory;

    constructor() {
        owner = msg.sender;
    }

    function enter() external payable {
        if (msg.value < 0.01 ether) revert InsufficientFunds();
        players.push(payable(msg.sender));
    }

    function getRandomNumber() public view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(owner, block.timestamp)));
    }

    function pickWinner() external {
        if (msg.sender != owner) revert NotOwner();
        uint256 playersLength = players.length;
        uint256 index = getRandomNumber() % playersLength;
        players[index].transfer(address(this).balance);
        lotteryHistory[lotteryId] = players[index];
        lotteryId++;
        delete players;
    }

    function getPlayers() external view returns (address payable[] memory) {
        return players;
    }
}
