// SPDX-License-Identifier: MIT
// 앉은자가 함수 i를 호출할때 열차번호를 변수a에 담고 좌석번호를 변수b에 담음
// 변수 b는 복호화 가능한 형태로 암호화되어서 저장됨

// 앉고싶은자가 함수 j를 호출할때 변수a에 열차번호를 입력함.
// 이때 어떤 앉은자가 함수 i를 호출하여 변수a에 입력해놓은 좌석번호가 앉고싶은자가 함수 j를 호출할때 입력한 변수a와 같다면 함수i의 암호화된 변수b를 복호화하여 함수 j를 호출한 사람에게 출력함.
pragma solidity ^0.8.0;

contract TrainSeatReservation {
    struct TrainInfo {
        uint256 seatNumber;
        uint256 subwayStationNumber;
    }

    mapping (uint256 => TrainInfo[]) trainSeats;

    function seatedPerson(uint256 trainNumber, uint256 seatNumber, uint256 subwayStationNumber) public {
        TrainInfo[] storage trainInfoArray = trainSeats[trainNumber];
        trainInfoArray.push(TrainInfo(seatNumber, subwayStationNumber));
    }

    function wantToSitPerson(uint256 trainNumber) public view returns (TrainInfo[] memory) {
        TrainInfo[] memory trainInfoArray = trainSeats[trainNumber];

        return trainInfoArray;
    }
}



// 3호선의 역번호가 제일 깔끔하기에 우선 3호선만 만들어 보겠다.
// 출처 - https://ko.wikipedia.org/wiki/%EC%88%98%EB%8F%84%EA%B6%8C_%EC%A0%84%EC%B2%A0_3%ED%98%B8%EC%84%A0
// 309번 대화역 ~ 352번 오금역까지이다. 변수는 그냥 역 번호를 그대로 사용하겠다.



//앉을 때 열차번호,좌석번호,내리는역을(내리는역 코드는 추가 할 예정) 블록체인에 mapping으로 저장하고
//앉고 싶을 때 열차번호를 입력해서 좌석번호와 내리는역(추가예정)을 받기.

//*추가적으로 해야 할 일
//1.내리는역 변수 추가(함수 i,j 둘다)
//2.함수 i를 호출한 사람에게 토큰보내기
//3.함수 j를 호출한 사람에게 토큰받기
//4.함수 i에서 받은 열차번호에 해당하는열차가 함수i의 내리는역 변수에 도착 시 해당 데이터를 블록체인에서 지우기
//5.함수 i를 호출할 때 배열에 timestamp기준으로 1씩 증가하는 id넣기(만약 같은 열차에 타서 내리지 않고 앉아있는 사람이 많을 때 좌석번호가 리셋되지 않고 빨리 내리는 순서대로 배열에 담기게 만들기) 생각만해도 어렵....
