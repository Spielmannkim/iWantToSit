// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ContractA {
    function encryptArray(uint256[] memory input) public pure returns (bytes memory) {
        bytes memory output = new bytes(input.length * 32);
        for (uint256 i = 0; i < input.length; i++) {
            assembly {
                mstore(add(output, mul(i, 32)), mload(add(input, mul(i, 32))))
            }
        }
        return output;
    }
}
