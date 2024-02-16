// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "forge-std/Script.sol";
import "../src/MyToken.sol";
import "../src/MyTokenV2.sol";
import {Upgrades} from "@openzeppelin/foundry-upgrades/UpgradesMappingWithDeploy.sol";
import "@openzeppelin/foundry-upgrades/Options.sol";
import {IBeacon} from "@openzeppelin/contracts/proxy/beacon/IBeacon.sol";
import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract MyTokenScript is Script {
  function setUp() public {
    vm.createSelectFork("https://rpc.sepolia.org");
  }

  mapping(string => string) opts;

  function run() public {

    console.log('MSG sender is %s', msg.sender);

    // Since opts is a contract, it needs to be created outside of a broadcast
    Options opts = new Options();
    // opts.setUsePlatformDeploy(true);

    uint256 deployerPrivateKey = vm.envUint("PRI_KEY");
    vm.startBroadcast(deployerPrivateKey);

    
    // MyToken v1 = new MyToken();
    // console.log("Impl: %s", address(v1));
    
    // Direct  ( use direct)
    // ERC1967Proxy proxy = new ERC1967Proxy(address(v1), abi.encodeWithSelector(MyToken.initialize.selector, "hello"));
    
    // UUPS with Options
    // ERC1967Proxy proxy = Upgrades.deployUUPSProxy(address(v1), abi.encodeCall(MyToken.initialize, ("hello", msg.sender)), opts);

  

    // UUPS with env options. The drawback compared to Options contract is that these env vars do not get cleared between calls, so has more possibility for user error.
    // vm.setEnv(Options.usePlatformDeploy, 'true');
    
    // opts[Options.usePlatformDeploy] = 'true';
    // Proxy proxy = Upgrades.deployUUPSProxy('MyToken.sol', abi.encodeCall(MyToken.initialize, ("hello", msg.sender)), opts);

    // Transparent
    // address deplpoyerAddress = 0x443fF7c9Df218591C4bC83eCF937Ba56fA17447f;
    // Proxy proxy = Upgrades.deployTransparentProxy(address(v1), deplpoyerAddress, abi.encodeCall(MyToken.initialize, ("hello", deplpoyerAddress)));
    
    // Beacon
    // MyToken instance = new MyToken();
    // IBeacon beacon = Upgrades.deployBeacon(address(instance), msg.sender);
    // Proxy proxy = Upgrades.deployBeaconProxy(address(beacon), abi.encodeCall(MyToken.initialize, ("hello", msg.sender)));

    // MyToken instance = MyToken(address(proxy));

    // console.log("Proxy: %s", address(proxy));

    // console.log("name: %s", instance.name());
    // console.log("greeting: %s", instance.greeting());
    // console.log("owner: %s", instance.owner());
    
    // MyTokenV2 v2 = new MyTokenV2();
    // console.log("Impl V2: %s", address(v2));

    // address proxy = 0xeddF2F5ECbdf55837A93dCaD3B81ECA0C3684cF8;
    // console.log("Proxy impl address before upgrade %s", Upgrades.getImplementationAddress(address(proxy)));

    // ITransparentUpgradeableProxy(address(proxy)).upgradeToAndCall(address(v2), abi.encodeCall(MyTokenV2.resetGreeting, ()));
    Upgrades.upgradeProxy(address(proxy), address(v2), msg.sender, abi.encodeCall(MyTokenV2.resetGreeting, ()));

    // console.log("upgraded greeting: %s", instance.greeting());

    // console.log("Proxy impl address after upgrade %s", Upgrades.getImplementationAddress(address(proxy)));

    vm.stopBroadcast();
  }
}
