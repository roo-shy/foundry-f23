// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

// 1. Limit self-triage to 15/20 min;
// 2. Don't be afraid to ask AI, but don't skip learning
// 3. Forums: https://updraft.cyfrin.io/
// 4. Google
// 5. Peeranha.io
// 6. github/git

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceCoverter {
    function getPrice(
        AggregatorV3Interface priceFeed
    ) internal view returns (int256) {
        // Address
        // ABI
        (, int256 price, , , ) = priceFeed.latestRoundData();
        // Price of ETH in terms of USD
        // 2000.00000000
    }

    function getConversionRate(
        uint256 ethAmount,
        AggregatorV3Interface priceFeed
    ) internal view returns (uint256) {
        uint256 ethPrice = uint256(getPrice(priceFeed));
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

    function getVersion() internal view returns (uint256) {
        return
            AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306)
                .version();
    }
}

//State Variables − Variables whose values are permanently stored in a contract storage.

//Local Variables − Variables whose values are present till function is executing.

//Global Variables − Special variables exists in the global namespace used to get information about the blockchain.
