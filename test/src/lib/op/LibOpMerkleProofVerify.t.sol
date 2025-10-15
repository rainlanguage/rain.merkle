// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";
import {LibOpMerkleProofVerify, OperandV2, StackItem} from "src/lib/op/LibOpMerkleProofVerify.sol";
import {ROOT, LEAF0_0, PROOF0_0} from "test/proof/LibTestProof.sol";

contract LibOpMerkleProofVerifyTest is Test {
    function testIntegrityEnoughInputs(OperandV2 operand, uint256 inputs, uint256 outputs) external pure {
        inputs = bound(inputs, 3, type(uint256).max);
        (uint256 calculatedInputs, uint256 calculatedOutputs) =
            LibOpMerkleProofVerify.integrity(operand, inputs, outputs);
        assertEq(calculatedInputs, inputs);
        assertEq(calculatedOutputs, 1);
    }

    function testIntegrityNotEnoughInputs(OperandV2 operand, uint256 inputs, uint256 outputs) external pure {
        inputs = bound(inputs, 0, 2);
        (uint256 calculatedInputs, uint256 calculatedOutputs) =
            LibOpMerkleProofVerify.integrity(operand, inputs, outputs);
        assertEq(calculatedInputs, 3);
        assertEq(calculatedOutputs, 1);
    }

    function testRunHappy(OperandV2 operand) external pure {
        StackItem[] memory inputs = new StackItem[](3);

        inputs[0] = StackItem.wrap(ROOT);
        inputs[1] = StackItem.wrap(LEAF0_0);
        inputs[2] = StackItem.wrap(PROOF0_0);

        StackItem[] memory outputs = LibOpMerkleProofVerify.run(operand, inputs);

        assertEq(outputs.length, 1);
        assertEq(StackItem.unwrap(outputs[0]), bytes32(uint256(1)), "Merkle proof should be valid");
    }

    function testRunUnhappy(OperandV2 operand, StackItem[] memory inputs) external pure {
        vm.assume(inputs.length > 2);

        StackItem[] memory outputs = LibOpMerkleProofVerify.run(operand, inputs);

        assertEq(outputs.length, 1);
        assertEq(StackItem.unwrap(outputs[0]), 0, "Merkle proof should be invalid");
    }
}
