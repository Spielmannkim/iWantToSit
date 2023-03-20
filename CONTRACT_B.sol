// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./CONTRACT_A.sol";

contract ContractB {
    address public constant CONTRACT_A_ADDRESS = address(0x393F9254A5DB11A0d3Ada6712e3B4002819D8784); // ContractA의 주소 입력
    address public constant TOKEN_ADDRESS = address(0x0bFad5854579b508b056f46faf532B64e55e1997); // ERC-20 토큰의 주소 입력
    uint256 public constant TOKEN_AMOUNT = 10 * 10**18; // 전송할 ERC-20 토큰의 양

    function processArray(uint256[] memory input) public {
        bytes memory encryptedArray = ContractA(CONTRACT_A_ADDRESS).encryptArray(input);
        bytes32 key = keccak256(abi.encodePacked(msg.sender)); // msg.sender를 키로 사용
        bytes memory encryptedKey = abi.encodePacked(key ^ bytes32(uint256(uint160(address(this))))); // 키를 암호화
        bytes memory encryptedData = abi.encodePacked(encryptedKey, encryptedArray); // 키와 암호화된 배열을 합침
        bytes32 storageKey = keccak256(abi.encodePacked("encryptedData", msg.sender)); // 저장할 데이터의 스토리지 키 생성
        assembly {
            sstore(storageKey, mload(add(encryptedData, 32)))
        }
        IERC20(TOKEN_ADDRESS).transfer(msg.sender, TOKEN_AMOUNT); // ERC-20 토큰 전송
    }
}
