// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "/registrarRegistry.sol";
import "/registrarIssue.sol";

contract ContractBFactory is AccessControl {
    Registry public registry;
    address[] public deployedContracts;

    bytes32 public constant FACTORY_ADMIN_ROLE = keccak256("FACTORY_ADMIN_ROLE");

    constructor(Registry _registry) {
        registry = _registry;
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(FACTORY_ADMIN_ROLE, msg.sender);
    }

    function createContractB() public {
        require(hasRole(FACTORY_ADMIN_ROLE, msg.sender), "Caller is not a factory admin");
        ContractB newContractB = new ContractB(registry);
        deployedContracts.push(address(newContractB));
   }

    function getDeployedContracts() public view returns (address[] memory) {
        return deployedContracts;
    }
}
