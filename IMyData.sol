// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;

interface IMyData {
    
    function storeMyDataMerkleRoot(address owner, bytes32 allMyDataHash, bool flag, uint256 price) external;

    function storeMyDataSell(address owner, bool flag) external;

    function storeMyDataPrice(address owner, uint256 price) external;

    function buyMydata(address owner, address buyer) external payable;
} 