// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundMeTest is Test {
    function setUp() external {
        FundMe fundMe = new FundMe();
    }

    function testMinimumDollarIsFive() public {}
      assertEq(fundMe.MINIMUM_USD(), 5e18);
}
