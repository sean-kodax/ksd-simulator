// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./KSD.sol";

contract KSDAirdrop {
    address public owner;
    KSD public ksd;
    uint256 public ethPerUser = 0.002 ether;
    uint256 public ksdPerUser = 100e6; // 100 KSD (6 decimals)

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    constructor(address _ksd) {
        owner = msg.sender;
        ksd = KSD(_ksd);
    }

    function airdrop(address[] calldata recipients) external onlyOwner {
        for (uint i = 0; i < recipients.length; i++) {
            payable(recipients[i]).transfer(ethPerUser);
            ksd.mint(recipients[i], ksdPerUser);
        }
    }

    function withdraw() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    }

    receive() external payable {}
}
