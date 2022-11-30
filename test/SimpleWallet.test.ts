import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import type { SignerWithAddress } from "@nomiclabs/hardhat-ethers/dist/src/signer-with-address";
import { expect } from "chai";
import { ethers } from "hardhat";

import type { SimpleWallet } from "../types/SimpleWallet.sol";
import type { SimpleWallet__factory } from "../types/factories/SimpleWallet.sol";
import type { Signers } from "./types";

const { hashMessage } = require("@ethersproject/hash");

describe("Unit tests", function () {
  before(async function () {
    this.signers = {} as Signers;

    const signers: SignerWithAddress[] = await ethers.getSigners();
    this.signers.owner = signers[0];
    this.signers.johnDoe = signers[1];

    const walletFactory: SimpleWallet__factory = <SimpleWallet__factory>await ethers.getContractFactory("SimpleWallet");
    this.wallet = <SimpleWallet>await walletFactory.connect(this.signers.owner).deploy();
    await this.wallet.deployed();
    await this.signers.owner.sendTransaction({
      value: ethers.utils.parseEther("1.0"), // Sends exactly 1.0 ether
      to: this.wallet.address,
    });
  });

  it("should transfer funds", async function () {
    expect(await this.wallet.owner()).to.equal(this.signers.owner.address);
    await this.wallet.connect(this.signers.owner).transfer(this.signers.johnDoe.address, "1");
    await this.wallet.connect(this.signers.owner).transfer(this.signers.johnDoe.address, "1");
  });

  it("should validate a transfer", async function () {
    const nonce = await this.wallet.nonce();
    const message = {
      dest: this.signers.johnDoe.address,
      amount: 1,
      nonce: nonce.add(1),
      hash: "",
      signature: "",
    };

    const messageText = "verify this!";

    message.hash = ethers.utils.hashMessage(messageText);
    message.signature = await this.signers.owner.signMessage(messageText);

    console.log("reached here");
    await this.wallet.validateTransfer(message);
  });
});
