function testPriceFeedVersionIsAccurate() public {
    uint256 version = fundMe.getVersion();
    assertEq(version, 4);
}

function testFundFailsWithoutEnoughEth() public {
    vm.expectRevert();

    // assert(This tx fails/reverts)
    fundMe.fund();
}

function testFundUpdatesFundedDataStructure() public {}
