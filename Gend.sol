// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;

contract GenD {

    uint256 id;
    bool test;
    address payable owner;

    struct myDataImage {
        bytes32 prompt;
        uint256 price;
        address[] owners;
    }
    
    mapping (uint256 => myDataImage) public myDataImages;

    constructor() {
        owner = payable(msg.sender);
    }

    function storeMyData(bytes32 _prompt) public returns (uint256) {

        // string[] tempOwners;
        // tempOwners.push(_owners);
        address[] memory temp;
        myDataImages[id] = myDataImage({
            prompt: _prompt,
            price: 10000,
            owners: temp
        });
        myDataImages[id].owners.push(msg.sender);

        uint256 _id = id;
        id++;

        return _id;
    }

    function getMyData(uint256 unuque_id) public view returns (bytes32, uint256, address[] memory) {
        bytes32 _prompt = myDataImages[unuque_id].prompt;
        uint256 _price = myDataImages[unuque_id].price;
        address[] memory _owners = myDataImages[unuque_id].owners;

        return (_prompt, _price, _owners);
    }

    function buyMyData(uint256 unique_id) payable public returns (uint256) {
        
        require(msg.value != myDataImages[unique_id].price, "buyMyData: not matched balances");

        uint256 amt = msg.value / 10;
        uint256 len = myDataImages[unique_id].owners.length;
        for(uint256 i=0; i < len; i++) {
            address payable recipient = payable(myDataImages[unique_id].owners[i]);
            recipient.transfer((msg.value - amt) / len);
        }

        myDataImages[unique_id].price += 10000;
        myDataImages[unique_id].owners.push(msg.sender);
        owner.transfer(amt);
        return unique_id;
    }

    function setTest(bool _test) public {
        test = _test;
    }

    function getTest() public view returns (bool) {
		return test;
	}
}