import { StandardMerkleTree } from "@openzeppelin/merkle-tree";
import fs from "fs";

// (1)
const tree = StandardMerkleTree.load(JSON.parse(fs.readFileSync("test/proof/tree.json", "utf8")));

// (2)
for (const [i, v] of tree.entries()) {
    // (3)
    const proof = tree.getProof(i);
    console.log('Value:', v);
    console.log('Proof:', proof);
}