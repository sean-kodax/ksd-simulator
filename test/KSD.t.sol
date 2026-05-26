// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/KSD.sol";

contract KSDTest is Test {
    KSD public ksd;
    address public alice = makeAddr("alice");
    address public bob = makeAddr("bob");

    function setUp() public {
        ksd = new KSD();
    }

    function test_name() public view {
        assertEq(ksd.name(), "K Stable Dollar");
    }

    function test_symbol() public view {
        assertEq(ksd.symbol(), "KSD");
    }

    function test_decimals() public view {
        assertEq(ksd.decimals(), 6);
    }

    function test_initialReservesAreZero() public view {
        assertEq(ksd.totalReserves(), 0);
    }

    function test_mint_increasesBalance() public {
        ksd.mint(alice, 100e6);
        assertEq(ksd.balanceOf(alice), 100e6);
    }

    function test_mint_increasesTotalSupply() public {
        ksd.mint(alice, 100e6);
        assertEq(ksd.totalSupply(), 100e6);
    }

    function test_mint_increasesReserves() public {
        ksd.mint(alice, 100e6);
        assertEq(ksd.totalReserves(), 100e6);
    }

    function test_mint_emitsEvent() public {
        vm.expectEmit(true, false, false, true);
        emit KSD.Minted(alice, 100e6, 100e6);
        ksd.mint(alice, 100e6);
    }

    function test_mint_multipleTimes() public {
        ksd.mint(alice, 100e6);
        ksd.mint(bob, 200e6);
        assertEq(ksd.totalSupply(), 300e6);
        assertEq(ksd.totalReserves(), 300e6);
    }

    function test_burn_decreasesBalance() public {
        ksd.mint(alice, 100e6);
        vm.prank(alice);
        ksd.burn(40e6);
        assertEq(ksd.balanceOf(alice), 60e6);
    }

    function test_burn_decreasesReserves() public {
        ksd.mint(alice, 100e6);
        vm.prank(alice);
        ksd.burn(40e6);
        assertEq(ksd.totalReserves(), 60e6);
    }

    function test_burn_emitsEvent() public {
        ksd.mint(alice, 100e6);
        vm.prank(alice);
        vm.expectEmit(true, false, false, true);
        emit KSD.Burned(alice, 40e6, 60e6);
        ksd.burn(40e6);
    }

    function test_burn_revertsIfInsufficientBalance() public {
        ksd.mint(alice, 100e6);
        vm.prank(alice);
        vm.expectRevert();
        ksd.burn(200e6);
    }

    function test_mintAndBurn_reservesTrackCorrectly() public {
        ksd.mint(alice, 500e6);
        ksd.mint(bob, 300e6);
        vm.prank(alice);
        ksd.burn(200e6);
        assertEq(ksd.totalReserves(), 600e6);
        assertEq(ksd.totalSupply(), 600e6);
    }
}
