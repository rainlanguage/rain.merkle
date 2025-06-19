// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {Script} from "forge-std/Script.sol";
import {MerkleWords} from "src/concrete/MerkleWords.sol";
import {LibFs} from "rain.sol.codegen/lib/LibFs.sol";
import {LibCodeGen} from "rain.sol.codegen/lib/LibCodeGen.sol";
import {LibGenParseMeta} from "rain.interpreter.interface/lib/codegen/LibGenParseMeta.sol";
import {LibMerkleSubParser} from "src/lib/parse/LibMerkleSubParser.sol";
import {PARSE_META_BUILD_DEPTH} from "src/abstract/MerkleSubParser.sol";

contract BuildPointers is Script {
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
