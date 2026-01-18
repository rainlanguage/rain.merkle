// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity =0.8.25;

import {MerkleExtern, BaseRainterpreterExternNPE2} from "../abstract/MerkleExtern.sol";
import {MerkleSubParser, BaseRainterpreterSubParserNPE2} from "../abstract/MerkleSubParser.sol";
import {DESCRIBED_BY_META_HASH} from "../generated/MerkleWords.pointers.sol";
import {IDescribedByMetaV1} from "rain.metadata/interface/IDescribedByMetaV1.sol";

/// @title MerkleWords
/// Minimal boilerplate to build a deployable concrete contract out of the extern
/// and subparser abstract contracts.
contract MerkleWords is MerkleExtern, MerkleSubParser {
    /// @inheritdoc IDescribedByMetaV1
    function describedByMetaV1() external pure returns (bytes32) {
        return DESCRIBED_BY_META_HASH;
    }

    /// This is only needed because the parser and extern base contracts both
    /// implement IERC165, and the compiler needs to be told how to resolve the
    /// ambiguity.
    /// @inheritdoc BaseRainterpreterSubParserNPE2
    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(BaseRainterpreterSubParserNPE2, BaseRainterpreterExternNPE2)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
