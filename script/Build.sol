// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Script} from "forge-std-1.16.1/src/Script.sol";
import {MerkleWords} from "src/concrete/MerkleWords.sol";
import {LibFs} from "rain-sol-codegen-0.1.0/src/lib/LibFs.sol";
import {LibCodeGen} from "rain-sol-codegen-0.1.0/src/lib/LibCodeGen.sol";
import {LibGenParseMeta} from "rain-interpreter-interface-0.1.0/src/lib/codegen/LibGenParseMeta.sol";
import {LibMerkleSubParser} from "src/lib/parse/LibMerkleSubParser.sol";
import {PARSE_META_BUILD_DEPTH} from "src/abstract/MerkleSubParser.sol";

contract Build is Script {
    function buildMerkleWordsPointers() internal {
        MerkleWords merkleWords = new MerkleWords();

        string memory name = "MerkleWords";

        LibFs.buildFileForContract(
            vm,
            address(merkleWords),
            name,
            string.concat(
                LibCodeGen.describedByMetaHashConstantString(vm, name),
                LibGenParseMeta.parseMetaConstantString(
                    vm, LibMerkleSubParser.authoringMetaV2(), PARSE_META_BUILD_DEPTH
                ),
                LibCodeGen.subParserWordParsersConstantString(vm, merkleWords),
                LibCodeGen.operandHandlerFunctionPointersConstantString(vm, merkleWords),
                LibCodeGen.integrityFunctionPointersConstantString(vm, merkleWords),
                LibCodeGen.opcodeFunctionPointersConstantString(vm, merkleWords)
            )
        );
    }

    function run() external {
        buildMerkleWordsPointers();
    }
}
