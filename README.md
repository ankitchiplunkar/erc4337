# ERC4337 gas estimates [![Open in Gitpod][gitpod-badge]][gitpod] [![Github Actions][gha-badge]][gha] [![Hardhat][hardhat-badge]][hardhat] [![License: MIT][license-badge]][license]

[gitpod]: https://gitpod.io/#https://github.com/paulrberg/hardhat-template
[gitpod-badge]: https://img.shields.io/badge/Gitpod-Open%20in%20Gitpod-FFB45B?logo=gitpod
[gha]: https://github.com/paulrberg/hardhat-template/actions
[gha-badge]: https://github.com/paulrberg/hardhat-template/actions/workflows/ci.yml/badge.svg
[hardhat]: https://hardhat.org/
[hardhat-badge]: https://img.shields.io/badge/Built%20with-Hardhat-FFDB1C.svg
[license]: https://opensource.org/licenses/MIT
[license-badge]: https://img.shields.io/badge/License-MIT-blue.svg

Hardhat based package to estimate gas costs mentioned in
[ERC4337](https://www.notion.so/frontier-tech/Unpacking-ERC-4337-a128a685a776463484f8a34f432dd141?d=116e2028e25f4d438122d9f4fca0ebdc#905596aaa83948629048a3ea8264e5f3)
article

Gas used in simple transfer via SC wallet: 38k

EVM gas estimate in validating transfer via p2p mempool: 35k

To get the above results run

```
$ yarn install
$ yarn typechain
$ REPORT_GAS=TRUE yarn test
```

## Usage

### Pre Requisites

Before being able to run any command, you need to create a `.env` file and set a BIP-39 compatible mnemonic as an
environment variable. You can follow the example in `.env.example`. If you don't already have a mnemonic, you can use
this [website](https://iancoleman.io/bip39/) to generate one.

Then, proceed with installing dependencies:

```sh
$ yarn install
```

### Compile

Compile the smart contracts with Hardhat:

```sh
$ yarn compile
```

### TypeChain

Compile the smart contracts and generate TypeChain bindings:

```sh
$ yarn typechain
```

### Test

Run the tests with Hardhat:

```sh
$ REPORT_GAS=TRUE yarn test
```

## License

[MIT](./LICENSE.md) © Paul Razvan Berg
