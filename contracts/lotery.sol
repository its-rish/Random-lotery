// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.4.22 <0.9.0;
contract Lotry{
    address public manager;
    address payable[] public participant;//we use payable function as an arry to store the data of participants
    
    constructor(){
        manager=msg.sender;
    }
    //receive is a one time use function for receiving the money
    receive()external payable
    {
        require(msg.value==1 ether);
        participant.push(payable(msg.sender));
    }
    //for balance check only by manager
    function Balance_Check()public view returns(uint){
        require(msg.sender==manager);
        return address(this).balance;

    }
    function random()public view returns(uint){
      return uint ( keccak256(abi.encodePacked(block.difficulty,block.timestamp,participant.length)));
    }
    function select_Winner()public {
        require(msg.sender== manager);
        require(participant.length>=3);
        uint rand_Value = random();
        uint players = rand_Value % participant.length;
        address payable winner;
        winner=participant[players];
        winner.transfer (Balance_Check());
        participant= new address payable[](0);  

    }

    }
