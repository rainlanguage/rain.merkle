// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Test} from "forge-std/Test.sol";
import {LibOpMerkleProofVerify, Operand} from "src/lib/op/LibOpMerkleProofVerify.sol";
import {MerkleProof} from "openzeppelin-contracts/contracts/utils/cryptography/MerkleProof.sol";
import {ROOT, LEAF0_0, PROOF0_0} from "test/proof/LibTestProof.sol";

contract LibOpMerkleProofVerifyTest is Test {
    function testIntegrity(Operand operand, uint256 inputs, uint256 outputs) external pure {
        (uint256 calculatedInputs, uint256 calculatedOutputs) =
            LibOpMerkleProofVerify.integrity(operand, inputs, outputs);
        assertEq(calculatedInputs, inputs);
        assertEq(calculatedOutputs, 1);
    }

    function testRunHappy(Operand operand) external pure {
        uint256[] memory inputs = new uint256[](3);

        inputs[0] = ROOT;
        inputs[1] = LEAF0_0;
        inputs[2] = PROOF0_0;

        uint256[] memory outputs = LibOpMerkleProofVerify.run(
            operand,
            inputs
        );

        assertEq(outputs.length, 1);
        assertEq(outputs[0], 1, "Merkle proof should be valid");
    }

    function testRunUnhappy(Operand operand, uint256[] memory inputs) external pure {
        vm.assume(inputs.length > 2);

        uint256[] memory outputs = LibOpMerkleProofVerify.run(operand, inputs);

        assertEq(outputs.length, 1);
        assertEq(outputs[0], 0, "Merkle proof should be invalid");
    }

}
