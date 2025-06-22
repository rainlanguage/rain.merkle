// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";
import {LibOpMerkleProofVerify, Operand} from "src/lib/op/LibOpMerkleProofVerify.sol";
import {MerkleProof} from "openzeppelin-contracts/contracts/utils/cryptography/MerkleProof.sol";

contract LibOpMerkleProofVerifyTest is Test {
    function testIntegrity(Operand operand, uint256 inputs, uint256 outputs) external pure {
        (uint256 calculatedInputs, uint256 calculatedOutputs) = LibOpMerkleProofVerify.integrity(operand, inputs, outputs);
        assertEq(calculatedInputs, inputs);
        assertEq(calculatedOutputs, 1);
    }

    function testRunHappy() external{
    }

    // function testRun() external {
    //     uint256[] memory inputs = new uint256[](4);
    //     inputs[0] = 0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef; // root
    //     inputs[1] = 0x
}