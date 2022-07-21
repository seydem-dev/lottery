// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";

error NotOwner();
error InsufficientFunds();
error NotEnoughLink();

contract LotteryVRF is VRFConsumerBase(0xb3dCcb4Cf7a26f6cf6B120Cf5A73875B7BBc655B, 0x01BE23585060835E02B77ef475b0Cc51aA1e0709) {

    address public immutable owner;

    bytes32 private constant _keyHash = 0x2ed0feb3e7fd2022120aa84fab1945545a9f2ffc9076fd6156fa96eaff4c1311;

    /**
     * @dev _FEE = 0.1 LINK
     */
    uint256 private constant _FEE = 0.1 * 1e18;
    uint256 public randomResult;
    uint256 public lotteryId;

    address payable[] public players;

    mapping (uint256 => address payable) public lotteryWinners;

    /**
     * @dev Constructor inherits VRFConsumerBase
     *
     * Oracle: Chainlink
     * Network: Rinkeby
     * Chainlink VRF Coordinator address: 0xb3dCcb4Cf7a26f6cf6B120Cf5A73875B7BBc655B
     * LINK token address: 0x01BE23585060835E02B77ef475b0Cc51aA1e0709
     * Key Hash: 0x2ed0feb3e7fd2022120aa84fab1945545a9f2ffc9076fd6156fa96eaff4c1311
     */
    constructor() {
        owner = msg.sender;
       }

    function enter() public payable {
        if (msg.value < 0.01 ether) revert InsufficientFunds();
        players.push(payable(msg.sender));
    }

    /**
     * Requests randomness
     */
    function getRandomNumber() public returns (uint256) {
        if (LINK.balanceOf(address(this)) < _FEE) revert NotEnoughLink();
        return uint256(requestRandomness(_keyHash, _FEE));
    }

    function pickWinner() external {
        if (msg.sender != owner) revert NotOwner();
        uint256 playersLength = players.length;
        uint256 index = getRandomNumber() % playersLength;
        players[index].transfer(address(this).balance);
        lotteryWinners[lotteryId] = players[index];
        lotteryId++;
        delete players;
    }

    /**
     * Callback function used by VRF Coordinator
     */
    function fulfillRandomness(bytes32 requestId, uint256 randomness) internal override {
        randomResult = randomness;
    }

    function withdrawLink() external {
        if (msg.sender != owner) revert NotOwner();
        payable(owner).transfer(LINK.balanceOf(address(this)));
    }

    function getPlayers() external view returns (address payable[] memory) {
        return players;
    }

    receive() external payable {
        enter();
    }
}
