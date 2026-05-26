// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/KSD.sol";

contract DeployKSD is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        KSD ksd = new KSD();
        console.log("KSD deployed at:", address(ksd));

        vm.stopBroadcast();
    }
}
