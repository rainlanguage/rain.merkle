// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {Test, console2} from "forge-std/Test.sol";

uint256 constant ROOT = 0xd4dee0beab2d53f2cc83e567171bd2820e49898130a22622b10ead383e90bd77;
uint256 constant PROOF0_0 = 0xb92c48e9d7abe27fd8dfd6b5dfdbfb1c9a463f80c712b66f3a5180a090cccafc;
uint256 constant LEAF0_0 = 0xeb02c421cfa48976e66dfb29120745909ea3a0f843456c263cf8f1253483e283;

uint256 constant PROOF1_0 = 0xeb02c421cfa48976e66dfb29120745909ea3a0f843456c263cf8f1253483e283;

contract TestProofTest is Test {
    function testDerivedConstants() external pure {
        uint256 leaf0_0Calculated = uint256(
            keccak256(
                bytes.concat(keccak256(abi.encode(0x1111111111111111111111111111111111111111, 5000000000000000000)))
            )
        );

        assertEq(LEAF0_0, leaf0_0Calculated, "LEAF0_0 should match the calculated value");
    }

    function testTreeConstants() external view {
        string memory tree = vm.readFile("test/proof/tree.json");
        console2.log(tree);
        bytes memory rootBytes = vm.parseJson(tree, ".tree[0]");
        uint256 root = abi.decode(rootBytes, (uint256));

        assertEq(ROOT, root, "ROOT should match the value in the tree.json file");

        bytes memory proof0_0Bytes = vm.parseJson(tree, ".tree[2]");
        uint256 proof0_0 = abi.decode(proof0_0Bytes, (uint256));

        assertEq(PROOF0_0, proof0_0, "PROOF0_0 should match the value in the tree.json file");

        bytes memory proof1_0Bytes = vm.parseJson(tree, ".tree[1]");
        uint256 proof1_0 = abi.decode(proof1_0Bytes, (uint256));

        assertEq(PROOF1_0, proof1_0, "PROOF1_0 should match the value in the tree.json file");
    }
}