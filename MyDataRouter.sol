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
    function setMyDataMerkleRoot(string calldata myDataContractName, address owner, bytes32 myDataMerkleRoot, bool flag, uint256 price) public {
        IMyData(myDataList[myDataContractName]).storeMyDataMerkleRoot(owner, myDataMerkleRoot, flag, price);
    }

    // 사용자 myData 판매 여부 설정
    function setMyDataSell(string calldata myDataContractName, address owner, bool flag) public {
        IMyData(myDataList[myDataContractName]).storeMyDataSell(owner, flag);
    }

    // 사용자 myData 가격 설정
    function setMyDataPrice(string calldata myDataContractName, address owner, uint256 price) public {
        IMyData(myDataList[myDataContractName]).storeMyDataPrice(owner, price);
    }

    // 사용자 myData 구매
    function buyMyData(string calldata myDataContractName, address owner) public payable {
        IMyData(myDataList[myDataContractName]).buyMydata{value: msg.value}(owner, msg.sender);
    }
}