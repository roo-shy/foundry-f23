// Layout of Contract: 
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events

// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external functions
// public functions
// internal functions
// private functions
// view & pure functions

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

/**
 * @title A sample Raffle contract
 * @author
 * @notice This contract is for creating a sample raffle
 * @dev Implements Chainlink VRFv2
 */

contract Raffle {
    error Raffle__NotEnoughEthSent();
    error Raffle__TransferFailed();

    /** State Variables */
    uint16 private constant REQUEST_CONFIRMATIONS = 3;
    uint32 private constant NUM_WORDS = 1;

    uint256 private immutable s_entranceFee;
    uint256 private immutable s_interval;
    VRFCoordinatorV2Interface private immutable i_vrfCoordinator;
    address private immutable i_vrfCoordinator;
    bytes32 private immutable i_gasLane;
    uint64 private immutable i_subscriptionId;
    uint32 private immutable i_callbackGasLimit;

    address payable[] private s_players;
    uint256 private  s_lastTimeStamp;
    address private s_winner;

   /** Events */
   event EnteredRaffle(address indexed player);

    constructor(
        uint256 entranceFee, 
        uint256 interval,
        address vrfCoordinator, 
        bytes32 gasLane,
        uint64 i_subscriptionId,
        uint32 callbackGasLimit
        ) VRFConsumerBaseV2(vrfCoordinator){
        i_entranceFee = entranceFee;
        i_interval = interval;
        i_interval = interval;
        i_vrfCoordinator = VRFCoordinatorV2Interface(vrfCoordinator);
        i_gasLane = gasLane;
        i_subscriptionId = subscriptionId;
        i_callbackGasLimit = callbackGasLimit;
        s_lastTimeStamp = block.timestamp;
    }

    function enterRaffle() external payable {
        // require(msg.value >= i_entranceFee, "Not enough ETH sent!")
        if(msg.value < i_entranceFee) {
            revert Raffle__NotEnoughEthSent();
        }

        s_players.push(payable(msg.sender));
        // 1. Events making migration easier
        // 2. Makes indexing easier for the front end
        emit EnteredRaffle(msg.sender);
    }

function pickWinner() public {
    // check to see if enough time has passed
    if((block.timestamp - s_lastTimeStamp) < i_interval) {
       revert();
    }
      uint256 requestId = i_vrfCoordinator.requestRandomWords(
            i_gasLane,
            i_subscriptionId,
            REQUEST_CONFIRMATIONS,
            i_callbackGasLimit,
            NUM_WORDS
        );
    }

    function fulfillRandomWords(
        uint256 requestId,
        uint256[] memory randomWords
    ) interval override {}
     // s_players = 10;
     // rng = 12
     // 12 % 10 = 2 <- 
     // 123403u353u5iu3583u5up3u
     uint256 indexOfWinner = randomwords[0] % s_players.length;
     address payable winner = s_players[indexOfWinner];
     s_recentWinner = winner;
     (bool success,) = winner.call{value: address(this).balance}("");
     if(!success) {
        revert Raffle__TransferFailed();
     }

    /** Getter Function */

    function getEntranceFee() external view returns(uint256){
        returns i_entranceFee;
    }

}
