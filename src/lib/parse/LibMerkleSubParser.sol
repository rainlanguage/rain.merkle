// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {AuthoringMetaV2} from "rain.interpreter.interface/interface/deprecated/IParserV1.sol";

uint256 constant SUB_PARSER_WORD_MERKLE_PROOF_VERIFY = 0;

uint256 constant SUB_PARSER_WORD_PARSERS_LENGTH = 1;

library LibMerkleSubParser {
    function authoringMetaV2() internal pure returns (bytes memory) {
        AuthoringMetaV2[] memory meta = new AuthoringMetaV2[](SUB_PARSER_WORD_PARSERS_LENGTH);

        meta[SUB_PARSER_WORD_MERKLE_PROOF_VERIFY] = AuthoringMetaV2(
            "merkle-proof-verify",
            "Verifies a Merkle proof according to Open Zeppelin 4.x logic. Returns true if the proof is valid (caller must ensure). First value is the merkle root. Second is the leaf. Tail are the proof values."
        );
        return abi.encode(meta);
    }
}
