// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {OPCODE_MERKLE_PROOF_VERIFY} from "./MerkleExtern.sol";
import {Operand, BaseRainterpreterSubParserNPE2} from "rain.interpreter/abstract/BaseRainterpreterSubParserNPE2.sol";
import {LibSubParse} from "rain.interpreter/lib/parse/LibSubParse.sol";
import {LibConvert} from "rain.lib.typecast/LibConvert.sol";
import {
    SUB_PARSER_WORD_PARSERS_LENGTH, SUB_PARSER_WORD_MERKLE_PROOF_VERIFY
} from "../lib/parse/LibMerkleSubParser.sol";
import {IInterpreterExternV3} from "rain.interpreter.interface/interface/IInterpreterExternV3.sol";
import {LibParseOperand} from "rain.interpreter/lib/parse/LibParseOperand.sol";
import {
    OPERAND_HANDLER_FUNCTION_POINTERS as SUB_PARSER_OPERAND_HANDLERS,
    PARSE_META as SUB_PARSER_PARSE_META,
    SUB_PARSER_WORD_PARSERS
} from "../generated/MerkleWords.pointers.sol";

uint8 constant PARSE_META_BUILD_DEPTH = 1;

abstract contract MerkleSubParser is BaseRainterpreterSubParserNPE2 {
    // slither-disable-next-line dead-code
    function extern() internal view virtual returns (address) {
        return address(this);
    }

    /// @inheritdoc BaseRainterpreterSubParserNPE2
    function subParserParseMeta() internal pure override returns (bytes memory) {
        return SUB_PARSER_PARSE_META;
    }

    /// @inheritdoc BaseRainterpreterSubParserNPE2
    function subParserWordParsers() internal pure override returns (bytes memory) {
        return SUB_PARSER_WORD_PARSERS;
    }

    /// @inheritdoc BaseRainterpreterSubParserNPE2
    function subParserOperandHandlers() internal pure override returns (bytes memory) {
        return SUB_PARSER_OPERAND_HANDLERS;
    }

    function buildOperandHandlerFunctionPointers() external pure returns (bytes memory) {
        function(uint256[] memory) internal pure returns (Operand)[] memory fs = new function(uint256[] memory)
                internal
                pure
                returns (Operand)[](SUB_PARSER_WORD_PARSERS_LENGTH);
        fs[SUB_PARSER_WORD_MERKLE_PROOF_VERIFY] = LibParseOperand.handleOperandDisallowed;

        uint256[] memory pointers;
        assembly ("memory-safe") {
            pointers := fs
        }
        return LibConvert.unsafeTo16BitBytes(pointers);
    }

    function buildLiteralParserFunctionPointers() external pure returns (bytes memory) {
        return "";
    }

    function buildSubParserWordParsers() external pure returns (bytes memory) {
        function(uint256, uint256, Operand)
            internal
            view
            returns (bool, bytes memory, uint256[] memory)[] memory fs = new function(uint256, uint256, Operand)
                internal
                view
                returns (bool, bytes memory, uint256[] memory)[](SUB_PARSER_WORD_PARSERS_LENGTH);
        fs[SUB_PARSER_WORD_MERKLE_PROOF_VERIFY] = merkleProofVerifySubParser;

        uint256[] memory pointers;
        assembly ("memory-safe") {
            pointers := fs
        }
        return LibConvert.unsafeTo16BitBytes(pointers);
    }

    // slither-disable-next-line dead-code
    function merkleProofVerifySubParser(uint256 constantsHeight, uint256 ioByte, Operand operand)
        internal
        view
        returns (bool, bytes memory, uint256[] memory)
    {
        // slither-disable-next-line unused-return
        return LibSubParse.subParserExtern(
            IInterpreterExternV3(extern()), constantsHeight, ioByte, operand, OPCODE_MERKLE_PROOF_VERIFY
        );
    }
}
