## Cross-Chain Smart Contract DApp with LayerZero

# Overview

This repository contains the source code and deployment information for a cross-chain smart contract built on LayerZero with remix. The contract facilitates the transfer of assets and data between the Sepolia source chain and the Mumbai destination chain.

# Features

- **Cross-Chain Compatibility:** Enables seamless transfer of assets and data between Sepolia and Mumbai chains.
- **LayerZero Framework:** Built on LayerZero architecture for optimal performance and scalability.
- **Secure:** Follows best practices for smart contract development to ensure security.



# FUNCTIONS USAGE

# Constructor

The constructor function sets the source chain and destination ID on deployment.

```Solidity
constructor(address _lzEndpoint, address initialOwner) NonblockingLzApp(_lzEndpoint) Ownable(initialOwner) {

        // when source chain is sepolia, then Destination Chain is mumbia
        if (_lzEndpoint == 0xae92d5aD7583AD66E49A0c67BAd18F6ba52dDDc1) destChainId = 10109;
        
        // when Source chain is mumbai, then Destination Chain is sepolia.
        if (_lzEndpoint == 0xf69186dfBa60DdB133E91E9A4B5673624293d8F8) destChainId = 10161;   
    }
```


# Non-Blocking LayerZero Receive

The _nonblockingLzReceive function is used to receive data coming from the source chain.

```Solidity
// Example: Receive data on the Mumbai chain
function _nonblockingLzReceive(uint16, bytes memory, uint64, bytes memory _payload) internal override {
       data = abi.decode(_payload, (string));
    }

    function send(string memory _message) public payable {

        bytes memory payload = abi.encode(_message);

        _lzSend(destChainId, payload, payable(msg.sender), address(0x0), bytes(""), msg.value);
    
    }

```


# Send

The send function encodes and sends data from the source chain to the destination chain of both DApp.

```Solidity
// Example: Receive data on the Mumbai chain
function send(string memory _message) public payable {

        bytes memory payload = abi.encode(_message);

        _lzSend(destChainId, payload, payable(msg.sender), address(0x0), bytes(""), msg.value);
    
    }

```


# Trust Address

The trustAddress function sets the deployed contract address on both chains.

```Solidity
// Example: Receive data on the Mumbai chain
function trustAddress(address _otherContract) public onlyOwner {

        trustedRemoteLookup[destChainId] = abi.encodePacked(_otherContract, address(this));   

    }
```

# Estimate Fees

The estimateFees function is used to estimate the gas fee for the cross-chain interaction of both DApp.

```Solidity
// Example: Receive data on the Mumbai chain

function estimateFees(uint16 dstChainId, bytes calldata adapterParams, string memory _message) public view returns (uint nativeFee, uint zroFee) {

        bytes memory payload = abi.encode(_message);
        return lzEndpoint.estimateFees(dstChainId, address(this), payload, false, adapterParams);
    }
```


# Deployed Contracts

- **Sepolia:** [Sepolia DApp](https://sepolia.etherscan.io/tx/0x87eabcb7c393bdec9db64415a2758dc5a948fa2d1fd9d97c7f6bf2cef28c5007)
- **Mumbai:** [Mumbai DApp](https://mumbai.polygonscan.com/tx/0xd63bc9b3d885d81c6b553b0a34012b47d8844e80b27547f9a2c694097fddbf42)



# Additional Cross-Chain Interoperability Protocol (xCall)

Check out another cross-chain interoperability protocol xCall codebase, designed to enhance decentralized communication between different blockchain networks. This protocol complements the functionality provided by layer Zero in this repository.

[Link to xCall Codebase](https://github.com/KoxyG/xCall/tree/main)

Feel free to explore and compare the features of both implementations for a more comprehensive understanding of cross-chain interoperability.


