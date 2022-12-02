// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/SimpleWallet.sol";

contract SimpleWalletTest is Test {
    SimpleWallet public simpleWallet;
    uint256 internal ownerPrivateKey;
    uint256 internal spenderPrivateKey;

    address internal owner;
    address internal spender;

    function setUp() public {
        ownerPrivateKey = 0xA11CE;
        spenderPrivateKey = 0xB0B;

        owner = vm.addr(ownerPrivateKey);
        spender = vm.addr(spenderPrivateKey);

        vm.prank(owner);
        simpleWallet = new SimpleWallet();
        vm.deal(address(simpleWallet), 1 ether);
    }

    function testFundsTransfer() public {
        uint256 prevBalance = address(simpleWallet).balance;
        vm.prank(owner);
        simpleWallet.transfer(payable(spender), 1);
        assertEq(address(simpleWallet).balance, prevBalance - 1);
    }

    function testValidateTransfer() public {
        string memory messageText = "verify this!";
        bytes32 hashBytes = keccak256(abi.encodePacked(messageText));
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(ownerPrivateKey, hashBytes);
        SimpleWallet.TransferStruct memory message = SimpleWallet.TransferStruct({
            dest: address(owner),
            amount: 1,
            nonce: simpleWallet.nonce() + 1,
            hash: hashBytes,
            v: v,
            r: r,
            s: s
        });
        simpleWallet.validateTransfer(message);
    }
}
