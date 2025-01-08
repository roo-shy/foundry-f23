// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelpConfig} from "./HelperConfig.s.sol";

// import {PriceConverter} from "../PriceConverter.sol";

contract DeployFundMe is Script {
    function run() external {
        HelpConfig helperConfig = new HelpConfig();
        address ethUsdPriceFeed = helperConfig.activeNetworkConfig();

        vm.startBroadcast();
        new FundMe();
        vm.stopBroadcast();
    }
}
