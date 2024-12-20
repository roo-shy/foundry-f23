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

import {VRFCoordinatorV2Interface} from "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import {VRFConsumerBaseV2} from "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

/**
 * @title A sample Raffle contract
 * @author
 * @notice This contract is for creating a sample raffle
 * @dev Implements Chainlink VRFv2
 */

contract Raffle is VRFConsumerBaseV2 {
    error Raffle__NotEnoughEthSent();
    error Raffle__TransferFailed();
    error Raffle_RaffleNotOpen();

    // bool lotteryState = open, closed, calculating
    /* Type declarations */
    enum RaffleState {
        OPEN,    //0
        CALCULATING  // 1
        // 

    }



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
    address private s_recentWinner;
    RaffleState private s_raffleState;


   /** Events */
   event EnteredRaffle(address indexed player);
   event PickedWinner(address indexed winner); 
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

        s_raffelState = RaffleState.OPEN;
        s_lastTimeStamp = block.timestamp;
    }

    function enterRaffle() external payable {
        // require(msg.value >= i_entranceFee, "Not enough ETH sent!")
        if(msg.value < i_entranceFee) {
            revert Raffle__NotEnoughEthSent();
        }
        if (s_raffleState != RaffleState.OPEN) {
            revert Raffle_RaffleNotOpen();
        }

        s_players.push(payable(msg.sender));
        // 1. Events making migration easier
        // 2. Makes indexing easier for the front end
        emit EnteredRaffle(msg.sender);
    }

/**
 * @dev This is the function that the Chainlink Automation nodes call
 * to see if it's time to perform the upkeep
 * The following should be true for this to return true;
 * 1. The time interval has passed between raffle runs
 * 2. The raffle is in the OPEN state
 * 3. The contract has ETH (aka, players)
 * 4. (Implicit) The subscription is funded with $LINK
 */

function CheckUpKeep(bytes memory /*checkData*/) public view (bool upkeepNeeded, bytes memory /*performData*/) {
    

}     

function pickWinner() public {
    // check to see if enough time has passed
    if((block.timestamp - s_lastTimeStamp) < i_interval) {
       revert();
    }
    s_raffelState = RaffleState.CALCULATING;
      uint256 requestId = i_vrfCoordinator.requestRandomWords(
            i_gasLane,
            i_subscriptionId,
            REQUEST_CONFIRMATIONS,
            i_callbackGasLimit,
            NUM_WORDS
        );
    }

    CEI: Checks, Effects, Interactions
    function fulfillRandomWords(
        uint256 requestId,
        uint256[] memory randomWords
    ) interval override {}
        // Checks
        // Effects (Our own contract)
     // s_players = 10;
     // rng = 12
     // 12 % 10 = 2 <- 
     // 123403u353u5iu3583u5up3u
     uint256 indexOfWinner = randomwords[0] % s_players.length;
     address payable winner = s_players[indexOfWinner];
     s_recentWinner = winner;
     s_raffeState = RaffleState.OPEN;
     s_players = new address payable[](0);
     s_lastTimeStamp = block.timestamp;
     emit PickedWinner(winner); 
     // Interactions (Other contracts)

     (bool success,) = winner.call{value: address(this).balance}("");
     if(!success) {
        revert Raffle__TransferFailed();
     }

    /** Getter Function */

    function getEntranceFee() external view returns(uint256){
        returns i_entranceFee;
    }

}
