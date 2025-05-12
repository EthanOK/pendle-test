// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {IPMarketV3} from "@pendle/core-v2/contracts/interfaces/IPMarketV3.sol";
import {IStandardizedYield} from "@pendle/core-v2/contracts/interfaces/IStandardizedYield.sol";
import {IPPrincipalToken} from "@pendle/core-v2/contracts/interfaces/IPPrincipalToken.sol";
import {IPYieldToken} from "@pendle/core-v2/contracts/interfaces/IPYieldToken.sol";

contract PendleMarketTest is Test {
    address public constant susde_market = address(0x4339Ffe2B7592Dc783ed13cCE310531aB366dEac);
    IPMarketV3 market;

    function setUp() public {
        vm.createSelectFork("https://1rpc.io/eth");
        market = IPMarketV3(susde_market);
    }

    function test_readTokens() public view {
        (IStandardizedYield _SY, IPPrincipalToken _PT, IPYieldToken _YT) = market.readTokens();

        console.log(_SY.symbol(), ":", address(_SY));
        console.log(_PT.symbol(), ":", address(_PT));
        console.log(_YT.symbol(), ":", address(_YT));
    }
}
