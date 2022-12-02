// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.4;
import "openzeppelin-contracts/utils/cryptography/ECDSA.sol";

contract SimpleWallet {
    using ECDSA for bytes32;
    address public owner;
    uint256 public nonce = 1;

    struct TransferStruct {
        address dest;
        uint256 amount;
        uint256 nonce;
        bytes32 hash;
        uint8 v;
        bytes32 r;
        bytes32 s;
    }

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        //only authorized from owner
        require(msg.sender == owner, "only owner");
        _;
    }

    // solhint-disable-next-line no-empty-blocks
    receive() external payable {}

    /**
     * transfer eth value to a destination address
     */
    function transfer(address payable dest, uint256 amount) external onlyOwner {
        dest.transfer(amount);
        ++nonce;
    }

    function _validateSignature(bytes32 hash, uint8 v, bytes32 r, bytes32 s) internal view {
        require(owner == hash.recover(v, r, s), "wallet: wrong signature");
    }

    /**
     * transfer eth value to a destination address using signature
     */
    function validateTransfer(TransferStruct memory _transferStruct) external {
        _validateSignature(_transferStruct.hash, _transferStruct.v, _transferStruct.r, _transferStruct.s);
        require(++nonce == _transferStruct.nonce, "wallet: incorrect nonce");
        require(address(this).balance > _transferStruct.amount, "wallet: insufficient balance");
    }
}
