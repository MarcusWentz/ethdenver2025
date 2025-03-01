// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.26;

// import { ERC20 } from "solmate/tokens/ERC20.sol";
// solmate v4-core remapping
// solmate/=lib/v4-core/lib/solmate/
import { ERC20 } from "solmate/src/tokens/ERC20.sol";

contract TestTokenContract is ERC20 {

    constructor() ERC20("TestTokenContract", "TTC", 18){ //Name, symbol and decimal places.
        _mint(msg.sender, 1000000000 ether); // Mint 1 billion tokens to the address that deployed this contract.
    }

}