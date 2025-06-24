// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {Operand} from "rain.interpreter.interface/interface/deprecated/IInterpreterV2.sol";
import {MerkleProof} from "openzeppelin-contracts/contracts/utils/cryptography/MerkleProof.sol";

library LibOpMerkleProofVerify {
    function integrity(Operand, uint256 inputs, uint256) internal pure returns (uint256, uint256) {
        // Merkle proof requires dynamic proof inputs and produces 1 output.
        // Inputs must be at least 3: the root, the leaf, and at least one proof.
        return (inputs < 3 ? 3 : inputs, 1);
    }

    function run(Operand, uint256[] memory inputs) internal pure returns (uint256[] memory) {
        bytes32 root;
        bytes32 leaf;
        bytes32[] memory proof;

        assembly ("memory-safe") {
            // The first input is the root of the Merkle tree.
            root := mload(add(inputs, 0x20))
            // The second input is the leaf to verify.
            leaf := mload(add(inputs, 0x40))
            // The rest are the Merkle proof elements.
            // Mutate the inputs array to be a proof elements array.
            let proofLength := sub(mload(inputs), 2)
            proof := add(inputs, 0x40)
            mstore(proof, proofLength)
        }

        // Verify the Merkle proof.
        uint256 isValid = MerkleProof.verify(proof, root, leaf) ? 1 : 0;
        assembly ("memory-safe") {
            // We can mutate inputs again to be outputs.
            mstore(inputs, 1)
            mstore(add(inputs, 0x20), isValid)
        }
        return inputs;
    }
}
