// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.26;

// import { ERC20 } from "solmate/tokens/ERC20.sol";
// solmate v4-core remapping
// solmate/=lib/v4-core/lib/solmate/
import { ERC20 } from "solmate/src/tokens/ERC20.sol";

contract ElectronDevice2 is ERC20 {

    constructor() ERC20("ElectronDevice2", "CHARGE", 18){ //Name, symbol and decimal places.
        _mint(msg.sender, 100 ether); // 100 ether = 100% charge.
    }

}