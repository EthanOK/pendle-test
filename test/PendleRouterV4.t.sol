// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {IPMarketV3} from "@pendle/core-v2/contracts/interfaces/IPMarketV3.sol";
import {IStandardizedYield} from "@pendle/core-v2/contracts/interfaces/IStandardizedYield.sol";
import {IPPrincipalToken} from "@pendle/core-v2/contracts/interfaces/IPPrincipalToken.sol";
import {IPYieldToken} from "@pendle/core-v2/contracts/interfaces/IPYieldToken.sol";
import {IPActionStorageV4} from "@pendle/core-v2/contracts/interfaces/IPActionStorageV4.sol";
import {PendleRouterV4} from "@pendle/core-v2/contracts/router/PendleRouterV4.sol";
import {IPActionAddRemoveLiqV3} from "@pendle/core-v2/contracts/interfaces/IPActionAddRemoveLiqV3.sol";
import {IPActionSwapYTV3} from "@pendle/core-v2/contracts/interfaces/IPActionSwapYTV3.sol";
import {IPActionSwapPTV3} from "@pendle/core-v2/contracts/interfaces/IPActionSwapPTV3.sol";

contract PendleRouterV4Test is Test {
    address public constant eETH_market = 0x08bF93c8F85977c64069Dd34C5da7b1c636E104f;
    address public constant pendle_router4 = 0x888888888889758F76e7103c6CbF23ABbF58F946;
    uint256 public amount = 100 * 1e18;

    IStandardizedYield public eETH_SY;
    IPPrincipalToken public eETH_PT;
    IPYieldToken public eETH_YT;

    IPMarketV3 market;
    PendleRouterV4 router;

    function setUp() public {
        vm.createSelectFork("https://1rpc.io/eth");
        // deal(address, amount);
        market = IPMarketV3(eETH_market);
        router = PendleRouterV4(payable(pendle_router4));
        (eETH_SY, eETH_PT, eETH_YT) = market.readTokens();
    }

    function test_readRouter() public view {
        address router_owner = IPActionStorageV4(address(router)).owner();
        console.log("owner:", router_owner);
        address router_pendingOwner = IPActionStorageV4(address(router)).pendingOwner();
        console.log("pendingOwner:", router_pendingOwner);
        address setSelectorToFacets_facet =
            IPActionStorageV4(address(router)).selectorToFacet(IPActionStorageV4.setSelectorToFacets.selector);
        console.log("setSelectorToFacets_facet:", setSelectorToFacets_facet);
        address swapExactPtForSy_facet =
            IPActionStorageV4(address(router)).selectorToFacet(IPActionSwapPTV3.swapExactPtForSy.selector);
        console.log("swapExactPtForSy_facet:", swapExactPtForSy_facet);
        address swapExactYTForSy_facet =
            IPActionStorageV4(address(router)).selectorToFacet(IPActionSwapYTV3.swapExactYtForSy.selector);
        console.log("swapExactYTForSy_facet:", swapExactYTForSy_facet);
    }
}
