// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {Test, console2} from "forge-std/Test.sol";

uint256 constant ROOT = 0xd4dee0beab2d53f2cc83e567171bd2820e49898130a22622b10ead383e90bd77;
uint256 constant PROOF0_0 = 0xb92c48e9d7abe27fd8dfd6b5dfdbfb1c9a463f80c712b66f3a5180a090cccafc;

address constant LEAF0_0_VALUE = 0x1111111111111111111111111111111111111111;
uint256 constant LEAF0_0_AMOUNT = 5000000000000000000;
uint256 constant LEAF0_0 = 0xeb02c421cfa48976e66dfb29120745909ea3a0f843456c263cf8f1253483e283;

address constant LEAF1_0_VALUE = 0x2222222222222222222222222222222222222222;
uint256 constant LEAF1_0_AMOUNT = 2500000000000000000;
uint256 constant LEAF1_0 = 0xb92c48e9d7abe27fd8dfd6b5dfdbfb1c9a463f80c712b66f3a5180a090cccafc;

uint256 constant PROOF1_0 = 0xeb02c421cfa48976e66dfb29120745909ea3a0f843456c263cf8f1253483e283;

contract TestProofTest is Test {
    function testDerivedConstants() external pure {
        uint256 leaf0_0Calculated =
            uint256(keccak256(bytes.concat(keccak256(abi.encode(LEAF0_0_VALUE, LEAF0_0_AMOUNT)))));

        assertEq(LEAF0_0, leaf0_0Calculated, "LEAF0_0 should match the calculated value");
        assertEq(PROOF0_0, LEAF1_0, "PROOF0_0 should match LEAF1_0");

        uint256 leaf1_0Calculated =
            uint256(keccak256(bytes.concat(keccak256(abi.encode(LEAF1_0_VALUE, LEAF1_0_AMOUNT)))));

        assertEq(LEAF1_0, leaf1_0Calculated, "LEAF1_0 should match the calculated value");
        assertEq(PROOF1_0, LEAF0_0, "PROOF1_0 should match LEAF0_0");
    }

    function testTreeConstants() external view {
        string memory tree = vm.readFile("test/proof/tree.json");
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

    function testLeafConstants() external view {
        string memory tree = vm.readFile("test/proof/tree.json");

        bytes memory leaf0_0ValueBytes = vm.parseJson(tree, ".values[0].value[0]");
        address leaf0_0Value = abi.decode(leaf0_0ValueBytes, (address));

        assertEq(LEAF0_0_VALUE, leaf0_0Value, "LEAF0_0_VALUE should match the value in the tree.json file");

        bytes memory leaf0_0AmountBytes = vm.parseJson(tree, ".values[0].value[1]");
        string memory leaf0_0AmountString = abi.decode(leaf0_0AmountBytes, (string));
        uint256 leaf0_0Amount = vm.parseUint(leaf0_0AmountString);
        assertEq(LEAF0_0_AMOUNT, leaf0_0Amount, "LEAF0_0_AMOUNT should match the value in the tree.json file");

        bytes memory leaf1_0ValueBytes = vm.parseJson(tree, ".values[1].value[0]");
        address leaf1_0Value = abi.decode(leaf1_0ValueBytes, (address));
        assertEq(LEAF1_0_VALUE, leaf1_0Value, "LEAF1_0_VALUE should match the value in the tree.json file");

        bytes memory leaf1_0AmountBytes = vm.parseJson(tree, ".values[1].value[1]");
        string memory leaf1_0AmountString = abi.decode(leaf1_0AmountBytes, (string));
        uint256 leaf1_0Amount = vm.parseUint(leaf1_0AmountString);
        assertEq(LEAF1_0_AMOUNT, leaf1_0Amount, "LEAF1_0_AMOUNT should match the value in the tree.json file");
    }
}
