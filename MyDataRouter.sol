// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;

import "./IMyData.sol";

contract MyDataRouter {
    
    mapping(string => address) private myDataList;

    // 새로운 myData 컨트랙트 주소 저장
    function setMyDataContractAddr(string calldata myDataContractName, address myDataContractAddr) public {
        myDataList[myDataContractName] = myDataContractAddr;
    }

    
    function getMyDataContractAddr(string calldata myDataContractName) public view returns(address myDataContractAddr) {
        return myDataList[myDataContractName];
    }

    // 사용자 myData 머클루트 값 저장
    function setMyDataHash(string calldata myDataContractName, address owner, string memory part, string memory name, bytes32 dataHash, bool flag, uint256 price) public {
        IMyData(myDataList[myDataContractName]).storeMyDataHash(owner, part, name, dataHash, flag, price);
    }

    // 사용자 myData 판매 여부 설정
    function setMyDataSell(string calldata myDataContractName, address owner, string memory part, string memory name, bool flag) public {
        IMyData(myDataList[myDataContractName]).storeMyDataSell(owner, part, name, flag);
    }

    // 사용자 myData 가격 설정
    function setMyDataPrice(string calldata myDataContractName, address owner, string memory part, string memory name, uint256 price) public {
        IMyData(myDataList[myDataContractName]).storeMyDataPrice(owner, part, name, price);
    }

    // 사용자 myData 구매
    function buyMyData(string calldata myDataContractName, address owner, string memory part, string memory name) public payable {
        IMyData(myDataList[myDataContractName]).buyMydata{value: msg.value}(owner, part, name, msg.sender);
    }
}