// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts/utils/Address.sol";

contract MyToken is Initializable, ERC20Upgradeable, OwnableUpgradeable, UUPSUpgradeable {
    string public greeting;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(string memory _greeting, address initialOwner) initializer public {
        __ERC20_init("MyToken", "MTK");
        __Ownable_init(initialOwner);
        __UUPSUpgradeable_init();
        greeting = _greeting;
        // c1.log('owner: %s', owner());
        // c1.log('msg sender: %s', msg.sender);
    }

    function _authorizeUpgrade(address newImplementation)
        internal
        onlyOwner
        override
    {

    }

    // function _msgSender() internal override view virtual returns (address) {
    //     return tx.origin;
    // }
}
