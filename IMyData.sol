// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;

interface IMyData {
    
    function storeMyDataHash(address owner, string memory part, string memory name, bytes32 dataHash, bool flag, uint256 price) external;

    function storeMyDataSell(address owner, string memory part, string memory name, bool flag) external;

    function storeMyDataPrice(address owner, string memory part, string memory name, uint256 price) external;

    function buyMydata(address owner, string memory part, string memory name, address buyer) external payable;

    function setTest(bool _test) external;

    function getTest() external returns (bool);
} 