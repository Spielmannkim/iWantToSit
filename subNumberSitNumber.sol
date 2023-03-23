// SPDX-License-Identifier: MIT
// 앉은자가 함수 i를 호출할때 열차번호를 변수a에 담고 좌석번호를 변수b에 담음
// 변수 b는 복호화 가능한 형태로 암호화되어서 저장됨

// 앉고싶은자가 함수 j를 호출할때 변수a에 열차번호를 입력함.
// 이때 어떤 앉은자가 함수 i를 호출하여 변수a에 입력해놓은 좌석번호가 앉고싶은자가 함수 j를 호출할때 입력한 변수a와 같다면 함수i의 암호화된 변수b를 복호화하여 함수 j를 호출한 사람에게 출력함.
pragma solidity ^0.8.0;

contract TrainSeatReservation {
    mapping (uint256 => uint256) trainSeats; // 열차 번호와 좌석 번호를 매핑하는 변수

    // 열차번호는 '1234'일경우 1호선 2번째칸 34번째열차
    function i(uint256 trainNumber, uint256 seatNumber) public {
        trainSeats[trainNumber] = seatNumber; // 열차 번호와 좌석 번호를 매핑하여 저장
    }

    function j(uint256 trainNumber) public view returns (uint256) {
        uint256 seatNumber = trainSeats[trainNumber]; // 해당 열차 번호에 해당하는 좌석 번호를 가져옴

        return seatNumber; // 매칭되는 좌석 번호 반환
    }
}
