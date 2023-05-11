# registrarRegistry

    Registry contract:
        The main contract that maintains a list of approved addresses.
        Utilizes OpenZeppelin's AccessControl for role-based access control.
        Defines a REGISTRAR_ROLE for users authorized to add or remove addresses from the registry.
        Has a fee associated with adding addresses, which is set during contract deployment.
        Provides functions to add, remove, and check approval status for an address.
        Emits events when addresses are added or removed.

    registrarOwner contract:
        An individual contract that interacts with the Registry contract to check its approval status.
        Utilizes OpenZeppelin's AccessControl and Pausable contracts for role-based access control and pausable functionality.
        Defines an ADMIN_ROLE for users authorized to pause and unpause the contract.
        When checking for approval, the contract calls the isApproved() function in the Registry contract with its own address as the argument.
        The contract can be paused or unpaused by users with the ADMIN_ROLE.

    registrarFacorty contract:
        The factory contract that deploys instances of the registrarOwner contract.
        Utilizes OpenZeppelin's AccessControl for role-based access control.
        Defines a FACTORY_ADMIN_ROLE for users authorized to create new instances of registrarOwner.
        Keeps track of all deployed registrarOwner instances in an array.
        Provides a function to create new instances of registrarOwner and add their addresses to the deployedContracts array.
        Provides a function to retrieve the list of all deployed registrarOwner instances.
