// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "forge-std/Script.sol";
import "../src/MyContract.sol";
import "../src/MyToken.sol";
import {Upgrades} from "@openzeppelin/foundry-upgrades/UpgradesStructWithDeploy.sol";

import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract MyTokenScript is Script {
  function setUp() public {
    vm.createSelectFork("https://rpc.sepolia.org");
   
  }

  function run() public {

    console.log('MSG sender is %s', msg.sender);

    // Since opts is a contract, it needs to be created outside of a broadcast
    // Options opts = new Options();
    // opts.setUsePlatformDeploy(true);

    uint256 deployerPrivateKey = vm.envUint("PRI_KEY");
    vm.startBroadcast(deployerPrivateKey);
    
    MyContract instance = new MyContract(123);
    instance.initialize('hello', msg.sender);

    // instance = new MyToken();

    vm.stopBroadcast();
  }
}




