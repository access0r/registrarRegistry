// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./AccessControl.sol";
import "./Pausable.sol";
import "./registrarRegistry.sol";

contract registrarRegistry is AccessControl, Pausable {
    Registry public registry;

    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");

    constructor(Registry _registry) {
        registry = _registry;
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(ADMIN_ROLE, msg.sender);
    }

    function checkApproval() public view whenNotPaused returns (bool) {
        return registry.isApproved(address(this));
    }

    function pause() public {
        require(hasRole(ADMIN_ROLE, msg.sender), "Caller is not an admin");
        _pause();
    }

    function unpause() public {
        require(hasRole(ADMIN_ROLE, msg.sender), "Caller is not an admin");
        _unpause();
    }
}
