// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;

import "./IMyData.sol";

contract HealthCareContract is IMyData {
    
    struct OwnerHealthCareMyData {
        bytes32 dataHash;
        bool flag;
        uint256 price;
    }
    
    mapping (address => mapping(string => mapping(string => OwnerHealthCareMyData))) public healthCareMyData;

    // mapping (address => OwnerHealthCareMyData) public healthCareMyDataList;
    mapping (address => uint256) public bal;
    mapping (address => mapping(string => mapping(string => address[]))) public buyers;

    function storeMyDataHash(address owner, string memory part, string memory name, bytes32 dataHash, bool flag, uint256 price) public {
        healthCareMyData[owner][part][name] = OwnerHealthCareMyData(dataHash, flag, price);
    }

    function getMyDataHash(address owner, string memory part, string memory name) public view returns(OwnerHealthCareMyData memory ownerHealthCareMyData) {
        return healthCareMyData[owner][part][name];
    }

    function storeMyDataSell(address owner, string memory part, string memory name, bool flag) public {
        OwnerHealthCareMyData memory ownerHealthCareMyData = healthCareMyData[owner][part][name];
        ownerHealthCareMyData.flag = flag;
        healthCareMyData[owner][part][name] = ownerHealthCareMyData;
    }

    function storeMyDataPrice(address owner, string memory part, string memory name, uint256 price) public {
        OwnerHealthCareMyData memory ownerHealthCareMyData = healthCareMyData[owner][part][name];
        ownerHealthCareMyData.price = price;
        healthCareMyData[owner][part][name] = ownerHealthCareMyData;
    }

    function buyMydata(address owner, string memory part, string memory name, address buyer) public payable  {
        OwnerHealthCareMyData memory ownerHealthCareMyData = healthCareMyData[owner][part][name];
        require(msg.value == ownerHealthCareMyData.price, "HealthCareContract: incorrect value");
        bal[owner] += msg.value;
        buyers[owner][part][name].push(buyer);
    }

    function getBalance(address owner) public view returns(uint256) {
        return bal[owner];
    }

}