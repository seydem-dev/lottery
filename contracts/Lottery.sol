// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Lottery {

    uint256 public lotteryId;

    address public immutable owner;
    address payable[] public players;

    mapping (uint256 => address payable) public lotteryHistory;

    constructor() {
        owner = msg.sender;
        lotteryId = 1;
    }

    function enter() external payable {
        require(msg.value >= 0.01 ether, "Need to pay at least 0.01 ETH");
        players.push(payable(msg.sender));
    }

    function getRandomNumber() public view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(owner, block.timestamp)));
    }

    function pickWinner() external {
        require(msg.sender == owner, "Not owner");
        uint256 playersLength = players.length;
        uint256 index = getRandomNumber() % playersLength;
        players[index].transfer(address(this).balance);
        lotteryHistory[lotteryId] = players[index];
        lotteryId++;
        players = new address payable[](0);
    }

    function getPlayers() external view returns (address payable[] memory) {
        return players;
    }

    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
