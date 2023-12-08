// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.17;


import "https://github.com/LayerZero-Labs/solidity-examples/blob/main/contracts/lzApp/NonblockingLzApp.sol";



contract CrossChainSayHelloKoxy is NonblockingLzApp {

    
    string public data = "Waiting for incoming meessage";
    uint16 destChainId;

    constructor(address _lzEndpoint, address initialOwner) NonblockingLzApp(_lzEndpoint) Ownable(initialOwner) {

        // when source chain is sepolia, then Destination Chain is mumbia
        if (_lzEndpoint == 0xae92d5aD7583AD66E49A0c67BAd18F6ba52dDDc1) destChainId = 10109;
        
        // when Source chain is mumbai, then Destination Chain is sepolia.
        if (_lzEndpoint == 0xf69186dfBa60DdB133E91E9A4B5673624293d8F8) destChainId = 10161;   
    }

    

    function _nonblockingLzReceive(uint16, bytes memory, uint64, bytes memory _payload) internal override {
       data = abi.decode(_payload, (string));
    }

    function send(string memory _message) public payable {

        bytes memory payload = abi.encode(_message);

        _lzSend(destChainId, payload, payable(msg.sender), address(0x0), bytes(""), msg.value);
    
    }
    
    function trustAddress(address _otherContract) public onlyOwner {

        trustedRemoteLookup[destChainId] = abi.encodePacked(_otherContract, address(this));   

    }


    function estimateFees(uint16 dstChainId, bytes calldata adapterParams, string memory _message) public view returns (uint nativeFee, uint zroFee) {

        bytes memory payload = abi.encode(_message);
        return lzEndpoint.estimateFees(dstChainId, address(this), payload, false, adapterParams);
    }
}
