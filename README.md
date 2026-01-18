# rain.merkle

Exposes the merkle proof logic from Open Zeppelin 5.x to rainlang as a single
subparsed word `merkle-proof-verify`.

The useage is as per the [https://docs.openzeppelin.com/contracts/5.x/api/utils/cryptography#MerkleProof-verify-bytes32---bytes32-bytes32-](Open Zeppelin documentation), where the first argument to
`merkle-proof-verify` is the root, the second is the leaf and the tail is the
proof.

As merkle proofs have a length that depends on the size of the merkle tree the
proof is for, the rainlang word is variadic. The whole tail is used as the proof
but must be at least length 1.

Note that the `merkle-proof-verify` word returns `0` or `1` where `1` indicates
that the proof is valid. The rainlang author is responsible for applying `ensure`
to the return value to revert the transaction on invalid proofs if that is the
desired behaviour.