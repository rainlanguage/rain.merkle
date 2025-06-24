// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {MerkleWords} from "src/concrete/MerkleWords.sol";
import {OpTest} from "rain.interpreter/../test/abstract/OpTest.sol";
import {Strings} from "openzeppelin-contracts/contracts/utils/Strings.sol";

contract MerkleWordsMerkleProofVerifyTest is OpTest {
    using Strings for address;
    using Strings for uint256;

    function testMerkleWordsMerkleProofVerifyHappy() external {
        MerkleWords merkleWords = new MerkleWords();

        uint256 root = 0xd4dee0beab2d53f2cc83e567171bd2820e49898130a22622b10ead383e90bd77;
        uint256 proof = 0xb92c48e9d7abe27fd8dfd6b5dfdbfb1c9a463f80c712b66f3a5180a090cccafc;
        uint256 leaf = uint256(
            keccak256(
                bytes.concat(keccak256(abi.encode(0x1111111111111111111111111111111111111111, 5000000000000000000)))
            )
        );

        uint256[] memory expectedStack = new uint256[](4);
        expectedStack[0] = 1;
        expectedStack[1] = proof;
        expectedStack[2] = leaf;
        expectedStack[3] = root;

        checkHappy(
            bytes(
                string.concat(
                    "using-words-from ",
                    address(merkleWords).toHexString(),
                    "\n",
                    "root: ",
                    root.toHexString(),
                    ",",
                    "leaf: ",
                    leaf.toHexString(),
                    ",",
                    "proof: ",
                    proof.toHexString(),
                    ",",
                    " _: merkle-proof-verify(root leaf proof);"
                )
            ),
            expectedStack,
            "merkle-proof-verify(root leaf proof)"
        );
    }

    function testMerkleWordsMerkleProofVerifyUnhappy(uint256 proof, uint256 leaf, uint256 root) external {
        MerkleWords merkleWords = new MerkleWords();

        uint256[] memory expectedStack = new uint256[](4);
        expectedStack[0] = 0;
        expectedStack[1] = proof;
        expectedStack[2] = leaf;
        expectedStack[3] = root;

        checkHappy(
            bytes(
                string.concat(
                    "using-words-from ",
                    address(merkleWords).toHexString(),
                    "\n",
                    "root: ",
                    root.toHexString(),
                    ",",
                    "leaf: ",
                    leaf.toHexString(),
                    ",",
                    "proof: ",
                    proof.toHexString(),
                    ",",
                    " _: merkle-proof-verify(root leaf proof);"
                )
            ),
            expectedStack,
            "merkle-proof-verify(root leaf proof)"
        );
    }

    function testMerkleWordsMerkleProofVerifyNoInputs() external {
        MerkleWords merkleWords = new MerkleWords();

        checkBadInputs(
            bytes(
                string.concat(
                    "using-words-from ", address(merkleWords).toHexString(), "\n", " _: merkle-proof-verify();"
                )
            ),
            0,
            3,
            0
        );
    }

    function testMerkleWordsMerkleProofVerifyOnlyRoot(uint256 root) external {
        MerkleWords merkleWords = new MerkleWords();

        checkBadInputs(
            bytes(
                string.concat(
                    "using-words-from ",
                    address(merkleWords).toHexString(),
                    "\n",
                    "root: ",
                    root.toHexString(),
                    ",",
                    " _: merkle-proof-verify(root);"
                )
            ),
            2,
            3,
            1
        );
    }

    function testMerkleWordsMerkleProofVerifyOnlyRootAndLeaf(uint256 root, uint256 leaf) external {
        MerkleWords merkleWords = new MerkleWords();

        checkBadInputs(
            bytes(
                string.concat(
                    "using-words-from ",
                    address(merkleWords).toHexString(),
                    "\n",
                    "root: ",
                    root.toHexString(),
                    ",",
                    "leaf: ",
                    leaf.toHexString(),
                    ",",
                    " _: merkle-proof-verify(root leaf);"
                )
            ),
            4,
            3,
            2
        );
    }
}
