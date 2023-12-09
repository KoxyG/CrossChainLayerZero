# Cross-Chain Smart Contract with LayerZero

## Overview

This repository contains the source code and deployment information for a cross-chain smart contract built on LayerZero with remix. The contract facilitates the transfer of assets and data between the Sepolia source chain and the Mumbai destination chain.

## Features

- **Cross-Chain Compatibility:** Enables seamless transfer of assets and data between Sepolia and Mumbai chains.
- **LayerZero Framework:** Built on LayerZero architecture for optimal performance and scalability.
- **Secure:** Follows best practices for smart contract development to ensure security.



## FUNCTIONS USAGE

# Constructor

The constructor function sets the source chain and destination ID on deployment.

```Solidity
// Example: Deploy the contract on Sepolia
const { deployContract } = require('./scripts/deploy');

const sourceChain = 'Sepolia';
const destinationID = 'Mumbai';

deployContract(sourceChain, destinationID);
