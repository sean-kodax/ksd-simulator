// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/KSD.sol";
import "../src/KSDAirdrop.sol";

contract KSDAirdropTest is Test {
    KSD ksd;
    KSDAirdrop airdrop;
    address owner;
    address alice = makeAddr("alice");
    address bob = makeAddr("bob");
    address charlie = makeAddr("charlie");

    function setUp() public {
        owner = address(this);
        ksd = new KSD();
        airdrop = new KSDAirdrop(address(ksd));
        vm.deal(address(airdrop), 1 ether);
    }

    function test_airdrop_sends_eth_and_ksd_to_all_recipients() public {
        address[] memory recipients = new address[](3);
        recipients[0] = alice;
        recipients[1] = bob;
        recipients[2] = charlie;

        airdrop.airdrop(recipients);

        assertEq(alice.balance, 0.002 ether);
        assertEq(bob.balance, 0.002 ether);
        assertEq(charlie.balance, 0.002 ether);

        assertEq(ksd.balanceOf(alice), 100e6);
        assertEq(ksd.balanceOf(bob), 100e6);
        assertEq(ksd.balanceOf(charlie), 100e6);
    }

    function test_airdrop_single_recipient() public {
        address[] memory recipients = new address[](1);
        recipients[0] = alice;

        airdrop.airdrop(recipients);

        assertEq(alice.balance, 0.002 ether);
        assertEq(ksd.balanceOf(alice), 100e6);
    }

    function test_airdrop_reverts_insufficient_eth() public {
        // Drain the contract ETH first
        airdrop.withdraw();

        address[] memory recipients = new address[](1);
        recipients[0] = alice;

        vm.expectRevert();
        airdrop.airdrop(recipients);
    }

    function test_airdrop_reverts_non_owner() public {
        address[] memory recipients = new address[](1);
        recipients[0] = alice;

        vm.prank(alice);
        vm.expectRevert("Not owner");
        airdrop.airdrop(recipients);
    }

    function test_contract_can_receive_eth() public {
        uint256 balBefore = address(airdrop).balance;
        vm.deal(address(this), 1 ether);
        (bool ok,) = address(airdrop).call{value: 0.5 ether}("");
        assertTrue(ok);
        assertEq(address(airdrop).balance, balBefore + 0.5 ether);
    }

    function test_owner_can_withdraw() public {
        uint256 contractBal = address(airdrop).balance;
        uint256 ownerBalBefore = address(this).balance;

        airdrop.withdraw();

        assertEq(address(airdrop).balance, 0);
        assertEq(address(this).balance, ownerBalBefore + contractBal);
    }

    receive() external payable {}
}
