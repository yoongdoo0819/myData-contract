// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;

import "./IMyData.sol";

contract HealthCareContract is IMyData {
    
    address router;
    bool test;

    struct OwnerHealthCareMyData {
        bytes32 dataHash;
        bool flag;
        uint256 price;
    }
    
    mapping (address => mapping(string => mapping(string => OwnerHealthCareMyData))) public healthCareMyData;
    mapping (address => uint256) public bal;
    mapping (address => mapping(string => mapping(string => address[]))) public buyers;

    constructor(address _router) {
        router = _router;
    }

    modifier onlyRouter() {
        require(router == msg.sender, "HealthCareContract: msg.sender is not router");
        _;
    }

    function storeMyDataHash(address owner, string memory part, string memory name, bytes32 dataHash, bool flag, uint256 price) public onlyRouter {
        healthCareMyData[owner][part][name] = OwnerHealthCareMyData(dataHash, flag, price);
    }

    function getMyDataHash(address owner, string memory part, string memory name) public view returns(OwnerHealthCareMyData memory ownerHealthCareMyData) {
        return healthCareMyData[owner][part][name];
    }

    function storeMyDataSell(address owner, string memory part, string memory name, bool flag) public onlyRouter {
        OwnerHealthCareMyData memory ownerHealthCareMyData = healthCareMyData[owner][part][name];
        ownerHealthCareMyData.flag = flag;
        healthCareMyData[owner][part][name] = ownerHealthCareMyData;
    }

    function storeMyDataPrice(address owner, string memory part, string memory name, uint256 price) public onlyRouter {
        OwnerHealthCareMyData memory ownerHealthCareMyData = healthCareMyData[owner][part][name];
        ownerHealthCareMyData.price = price;
        healthCareMyData[owner][part][name] = ownerHealthCareMyData;
    }

    function buyMydata(address owner, string memory part, string memory name, address buyer) public onlyRouter payable  {
        OwnerHealthCareMyData memory ownerHealthCareMyData = healthCareMyData[owner][part][name];
        require(ownerHealthCareMyData.flag == true, "HealthCareContract: flag is false");
        require(msg.value == ownerHealthCareMyData.price, "HealthCareContract: incorrect value");
        bal[owner] += msg.value;
        buyers[owner][part][name].push(buyer);
    }

    function getBuyers(address owner, string memory part, string memory name) public view returns (address[] memory addr) {
        return buyers[owner][part][name];
    }

    function getBalance(address owner) public view returns(uint256) {
        return bal[owner];
    }

    function setTest(bool _test) public onlyRouter {
        test = _test;
    }

    function getTest() public view returns (bool) {
		return test;
	}
}