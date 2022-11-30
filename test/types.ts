import type { SignerWithAddress } from "@nomiclabs/hardhat-ethers/dist/src/signer-with-address";

import type { SimpleWallet } from "../types/SimpleWallet.sol";

type Fixture<T> = () => Promise<T>;

declare module "mocha" {
  export interface Context {
    simpleWallet: SimpleWallet;
    loadFixture: <T>(fixture: Fixture<T>) => Promise<T>;
    signers: Signers;
  }
}

export interface Signers {
  owner: SignerWithAddress;
  johnDoe: SignerWithAddress;
}
