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

//앉을 때 열차번호,좌석번호,내리는역을(내리는역 코드는 추가 할 예정) 블록체인에 mapping으로 저장하고
//앉고 싶을 때 열차번호를 입력해서 좌석번호와 내리는역(추가예정)을 받기.

//*추가적으로 해야 할 일
//1.내리는역 변수 추가(함수 i,j 둘다)
//2.함수 i를 호출한 사람에게 토큰보내기
//3.함수 j를 호출한 사람에게 토큰받기
//4.함수 i에서 받은 열차번호에 해당하는열차가 함수i의 내리는역 변수에 도착 시 해당 데이터를 블록체인에서 지우기
//5.함수 i를 호출할 때 배열에 timestamp기준으로 1씩 증가하는 id넣기(만약 같은 열차에 타서 내리지 않고 앉아있는 사람이 많을 때 좌석번호가 리셋되지 않고 빨리 내리는 순서대로 배열에 담기게 만들기) 생각만해도 어렵....
