// SPDX-License-Identifier: LicenseRef-DCL-1.0
// SPDX-FileCopyrightText: Copyright (c) 2020 Rain Open Source Software Ltd
pragma solidity ^0.8.25;

import {Vm} from "forge-std-1.17.0/src/Vm.sol";

/// @title LibReleasedSuitesAggregate
/// @notice Reads back which contracts a generated released-suites aggregate
/// imports, in order.
library LibReleasedSuitesAggregate {
    function declaredContractNames(Vm vm, string memory source) internal pure returns (string[] memory) {
        string[] memory chunks = vm.split(source, "\nimport {Lib");

        string[] memory names = new string[](chunks.length - 1);
        for (uint256 i = 1; i < chunks.length; i++) {
            names[i - 1] = vm.split(chunks[i], "Released}")[0];
        }
        return names;
    }
}
