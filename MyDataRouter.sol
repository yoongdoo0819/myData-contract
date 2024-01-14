// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;

import "./IMyData.sol";

contract MyDataRouter {
    
    address conttractOwner;

    mapping(string => address) private myDataList;

    constructor() {
        // Set the transaction sender as the owner of the contract.
        conttractOwner = msg.sender;
    }

    // Modifier to check that the caller is the owner of
    // the contract.
    modifier onlyOwner() {
        require(msg.sender == conttractOwner, "Not owner");
        // Underscore is a special character only used inside
        // a function modifier and it tells Solidity to
        // execute the rest of the code.
        _;
    }

    // Modifiers can take inputs. This modifier checks that the
    // address passed in is not the zero address.
    modifier validAddress(address _addr) {
        require(_addr != address(0), "Not valid address");
        _;
    }

    function changeOwner(address _newOwner) public onlyOwner validAddress(_newOwner) {
        conttractOwner = _newOwner;
    }

    // 새로운 myData 컨트랙트 주소 저장
    function setMyDataContractAddr(string calldata myDataContractName, address myDataContractAddr) public onlyOwner {
        myDataList[myDataContractName] = myDataContractAddr;
    }

    function getMyDataContractAddr(string calldata myDataContractName) public view returns(address myDataContractAddr) {
        return myDataList[myDataContractName];
    }

    // 사용자 myData hash 값 저장
    function setMyDataHash(string calldata myDataContractName, address owner, string memory part, string memory name, bytes32 dataHash, bool flag, uint256 price) public onlyOwner {
        IMyData(myDataList[myDataContractName]).storeMyDataHash(owner, part, name, dataHash, flag, price);
    }

    // 사용자 myData 판매 여부 설정
    function setMyDataSell(string calldata myDataContractName, address owner, string memory part, string memory name, bool flag) public onlyOwner {
        IMyData(myDataList[myDataContractName]).storeMyDataSell(owner, part, name, flag);
    }

    // 사용자 myData 가격 설정
    function setMyDataPrice(string calldata myDataContractName, address owner, string memory part, string memory name, uint256 price) public onlyOwner {
        IMyData(myDataList[myDataContractName]).storeMyDataPrice(owner, part, name, price);
    }

    // 사용자 myData 구매
    function buyMyData(string calldata myDataContractName, address owner, string memory part, string memory name) public payable {
        IMyData(myDataList[myDataContractName]).buyMydata{value: msg.value}(owner, part, name, msg.sender);
    }

    // 도메인 컨트랙트 콜을 위한 test 함수
    function setTestValue(string calldata myDataContractName, bool _test) public {
        IMyData(myDataList[myDataContractName]).setTest(_test);
    }

    // 도메인 컨트랙트 콜을 위한 test 함수
    function getTestValue(string calldata myDataContractName) public returns (bool) {
        return IMyData(myDataList[myDataContractName]).getTest();
    }
}