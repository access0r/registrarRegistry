// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./AccessControl.sol";


contract registrarRegistry is AccessControl {
    bytes32 public constant REGISTRAR_ROLE = keccak256("REGISTRAR_ROLE");
    mapping(address => bool) public approvedAddresses;
    mapping(address => uint256) public addressRegistrationCount;

    uint256 public fee;

    event AddressAdded(address indexed _address);
    event AddressRemoved(address indexed _address);
    event UserRegistered(address indexed registrar, address indexed user);

    constructor(uint256 _fee) {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        fee = _fee;
    }

    function addAddress(address _address) external payable {
        require(hasRole(REGISTRAR_ROLE, msg.sender), "Caller is not a registrar");
        require(msg.value >= fee, "Insufficient fee");
        approvedAddresses[_address] = true;
        emit AddressAdded(_address);
    }

    function removeAddress(address _address) external {
        require(hasRole(REGISTRAR_ROLE, msg.sender), "Caller is not a registrar");
        approvedAddresses[_address] = false;
        emit AddressRemoved(_address);
    }

    function isApproved(address _address) public view returns (bool) {
        return approvedAddresses[_address];
    }

    function registerUser(address _registrar) external {
        require(approvedAddresses[_registrar], "Registrar is not approved");
        addressRegistrationCount[_registrar]++;
        emit UserRegistered(_registrar, msg.sender);
    }

    function getRegistrationCount(address _registrar) public view returns (uint256) {
        return addressRegistrationCount[_registrar];
    }
}