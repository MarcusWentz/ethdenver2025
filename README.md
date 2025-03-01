# v4-template

## Source 

https://github.com/uniswapfoundation/v4-template

### **A template for writing Uniswap v4 Hooks 🦄**

[`Use this Template`](https://github.com/uniswapfoundation/v4-template/generate)

1. The example hook [Counter.sol](src/Counter.sol) demonstrates the `beforeSwap()` and `afterSwap()` hooks
2. The test template [Counter.t.sol](test/Counter.t.sol) preconfigures the v4 pool manager, test tokens, and test liquidity.

<details>
<summary>Updating to v4-template:latest</summary>

This template is actively maintained -- you can update the v4 dependencies, scripts, and helpers: 
```bash
git remote add template https://github.com/uniswapfoundation/v4-template
git fetch template
git merge template/main <BRANCH> --allow-unrelated-histories
```

</details>

---

### Check Forge Installation
*Ensure that you have correctly installed Foundry (Forge) Stable. You can update Foundry by running:*

```
foundryup
```

> *v4-template* appears to be _incompatible_ with Foundry Nightly. See [foundry announcements](https://book.getfoundry.sh/announcements) to revert back to the stable build



## Set up

*requires [foundry](https://book.getfoundry.sh)*

```
forge install
forge test
```

<details>
<summary><h2>Troubleshooting</h2></summary>



### *Permission Denied*

When installing dependencies with `forge install`, Github may throw a `Permission Denied` error

Typically caused by missing Github SSH keys, and can be resolved by following the steps [here](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh) 

Or [adding the keys to your ssh-agent](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent), if you have already uploaded SSH keys

### Hook deployment failures

Hook deployment failures are caused by incorrect flags or incorrect salt mining

1. Verify the flags are in agreement:
    * `getHookCalls()` returns the correct flags
    * `flags` provided to `HookMiner.find(...)`
2. Verify salt mining is correct:
    * In **forge test**: the *deployer* for: `new Hook{salt: salt}(...)` and `HookMiner.find(deployer, ...)` are the same. This will be `address(this)`. If using `vm.prank`, the deployer will be the pranking address
    * In **forge script**: the deployer must be the CREATE2 Proxy: `0x4e59b44847b379578588920cA78FbF26c0B4956C`
        * If anvil does not have the CREATE2 deployer, your foundry may be out of date. You can update it with `foundryup`

</details>

---

Additional resources:

[Uniswap v4 docs](https://docs.uniswap.org/contracts/v4/overview)

[v4-periphery](https://github.com/uniswap/v4-periphery) contains advanced hook implementations that serve as a great reference

[v4-core](https://github.com/uniswap/v4-core)

[v4-by-example](https://v4-by-example.org)


# v4-constant-sum

## Source

https://github.com/saucepoint/v4-constant-sum

### **Constant-sum swap on Uniswap v4 🦄**

> **This repo is not production ready, and only serves as an example for custom curves on v4**

With [recent changes](https://github.com/Uniswap/v4-core/pull/404) to v4, Hooks can swap on custom curves!

`v4-constant-sum` implements constant-sum swaps (*x + y = k*), allowing for an exact 1:1 swap everytime

---

## Methodology

2. The hook will hold its own token balances (as liquidity for the constant-sum curve)

3. The `beforeSwap` hook will handle the constant-sum curve:
    1. inbound tokens are taken from the PoolManager
        * this creates a debt, that is paid for by the swapper via the swap router
        * the inbound token is added to the hook's reserves
    2. an *equivalent* number of outbound tokens is sent from the hook to the PoolManager
        * the outbound token is removed from the hook's reserves
        * this creates a credit -- the swap router claims it and sends it to the swapper

---

Additional resources:

[v4-template](https://github.com/uniswapfoundation/v4-template) provides a minimal template and environment for developing v4 hooks

[Uniswap v4 docs](https://docs.uniswap.org/contracts/v4/overview)

[v4-periphery](https://github.com/uniswap/v4-periphery) contains advanced hook implementations that serve as a great reference

[v4-core](https://github.com/uniswap/v4-core)

[v4-by-example](https://v4-by-example.org)


## Unichain Deploy and Verify 

### Token

#### Deploy and Verify Blockscout
```shell
forge create src/ElectronDevice1.sol:ElectronDevice1 \
--private-key $devTestnetPrivateKey \
--rpc-url https://sepolia.unichain.org \
--verify \
--verifier blockscout \
--verifier-url https://unichain-sepolia.blockscout.com/api/ \
--broadcast
```

#### Verify Blockscout Contract Already Deployed
```shell
forge verify-contract \
--rpc-url https://sepolia.unichain.org \
<contract_address> \
src/ElectronDevice1.sol:ElectronDevice1 \
--verifier blockscout \
--verifier-url https://unichain-sepolia.blockscout.com/api/
```

### Hook

#### Deploy and Verify Blockscout

```shell
forge script script/00_Counter.s.sol:CounterScript \
--private-key $devTestnetPrivateKey \
--rpc-url https://sepolia.unichain.org \
--broadcast 
```

#### Verify Blockscout Contract Already Deployed

Use the `contractAddress` from CREATE2 from

```
broadcast/00_Counter.s.sol/1301/run-latest.json
```

then run

```shell
forge verify-contract \
--rpc-url https://sepolia.unichain.org \
<contract_address> \
src/Counter.sol:Counter \
--verifier blockscout \
--verifier-url https://unichain-sepolia.blockscout.com/api/
```

## Unichain Deployments 

### ElectronDevice1.sol

https://unichain-sepolia.blockscout.com/address/0x7CD3D2360d0410654695e8c57F7Bf744EA13b14f?tab=contract


### ElectronDevice2.sol

https://unichain-sepolia.blockscout.com/address/0x3c2E6D8C3Fee9BEC55d72D60f1537Db6522D6D18?tab=contract


#### PoolManager.sol (Uniswap V4)

https://unichain-sepolia.blockscout.com/address/0x00B036B58a818B1BC34d502D3fE730Db729e62AC?tab=contract

#### Counter.sol (Hook)

https://unichain-sepolia.blockscout.com/address/0xc1e5df1c14e28cbe8443fb268d74d5e48a00cac0?tab=contract

#### Uniswap V4 Unichain Sepolia Deployments

https://docs.uniswap.org/contracts/v4/deployments#unichain-sepolia-1301