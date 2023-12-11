// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;

import "./IMyData.sol";

contract HealthCareContract is IMyData {
    
    struct OwnerHealthCareMyData {
        bytes32 MerkleRoot;
        bool flag;
        uint256 price;
    }

    mapping (address => OwnerHealthCareMyData) public healthCareMyDataList;
    mapping (address => uint256) public bal;
    mapping (address => address[]) public buyers;

    function storeMyDataMerkleRoot(address owner, bytes32 myDataMerkleRoot, bool flag, uint256 price) public {
        healthCareMyDataList[owner] = OwnerHealthCareMyData(myDataMerkleRoot, flag, price);
    }

    function getMyDataMerkleRoot(address owner) public view returns(OwnerHealthCareMyData memory ownerHealthCareMyData) {
        return healthCareMyDataList[owner];
    }

    function storeMyDataSell(address owner, bool flag) public {
        OwnerHealthCareMyData memory ownerHealthCareMyData = healthCareMyDataList[owner];
        ownerHealthCareMyData.flag = flag;
        healthCareMyDataList[owner] = ownerHealthCareMyData;
    }

    function storeMyDataPrice(address owner, uint256 price) public {
        OwnerHealthCareMyData memory ownerHealthCareMyData = healthCareMyDataList[owner];
        ownerHealthCareMyData.price = price;
        healthCareMyDataList[owner] = ownerHealthCareMyData;
    }

    function buyMydata(address owner, address buyer) public payable  {
        OwnerHealthCareMyData memory ownerHealthCareMyData = healthCareMyDataList[owner];
        require(msg.value == ownerHealthCareMyData.price, "HealthCareContract: incorrect value");
        bal[owner] += msg.value;
        buyers[owner].push(buyer);
    }

    function getBalance(address owner) public view returns(uint256) {
        return bal[owner];
    }

}