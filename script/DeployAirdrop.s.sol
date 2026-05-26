// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/KSDAirdrop.sol";

contract DeployAirdrop is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address ksdAddress = vm.envAddress("KSD_ADDRESS");

        vm.startBroadcast(deployerPrivateKey);

        KSDAirdrop airdrop = new KSDAirdrop(ksdAddress);
        console.log("KSDAirdrop deployed at:", address(airdrop));

        vm.stopBroadcast();
    }
}
