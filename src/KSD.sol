// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract KSD is ERC20 {
    uint256 public totalReserves;

    event Minted(address indexed to, uint256 amount, uint256 newReserves);
    event Burned(address indexed from, uint256 amount, uint256 newReserves);

    constructor() ERC20("K Stable Dollar", "KSD") {}

    function decimals() public pure override returns (uint8) {
        return 6;
    }

    function mint(address to, uint256 amount) external {
        totalReserves += amount;
        _mint(to, amount);
        emit Minted(to, amount, totalReserves);
    }

    function burn(uint256 amount) external {
        totalReserves -= amount;
        _burn(msg.sender, amount);
        emit Burned(msg.sender, amount, totalReserves);
    }
}
