// SPDX-License-Identifier: MIT

// 사용법
// solidity버전을 0.8.0으로 맞춰서 컴파일 후 디플로이.
// seatedPerson함수에 trainNumber, seatNumber, gettingOffSubwayStationNumber
pragma solidity ^0.8.0;

contract TrainSeatReservation {
    struct TrainInfo {
        uint256 seatNumber;
        uint256 gettingOffSubwayStationNumber;
    }

    mapping (uint256 => TrainInfo[]) trainSeats;

    function seatedPerson(uint256 trainNumber, uint256 seatNumber, uint256 gettingOffSubwayStationNumber) public {
        TrainInfo[] storage trainInfoArray = trainSeats[trainNumber];
        trainInfoArray.push(TrainInfo(seatNumber, gettingOffSubwayStationNumber));
    }

    function wantToSitPerson(uint256 trainNumber) public view returns (string memory) {
        TrainInfo[] memory trainInfoArray = trainSeats[trainNumber];

        string memory result = "";

        for (uint256 i = 0; i < trainInfoArray.length; i++) {
            uint256 seatNumber = trainInfoArray[i].seatNumber;
            uint256 gettingOffSubwayStationNumber = trainInfoArray[i].gettingOffSubwayStationNumber;

            result = string(abi.encodePacked(result, '"', toString(i + 1), '":"', toString(seatNumber), '","', toString(gettingOffSubwayStationNumber), '"'));

            if (i < trainInfoArray.length - 1) {
                result = string(abi.encodePacked(result, ", "));
            }
        }

        return string(abi.encodePacked("{", result, "}"));
    }

    function toString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0";
        }

        uint256 temp = value;
        uint256 digits;

        while (temp != 0) {
            digits++;
            temp /= 10;
        }

        bytes memory buffer = new bytes(digits);

        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }

        return string(buffer);
    }
}


// 앉은자가 함수 i를 호출할때 열차번호를 변수a에 담고 좌석번호를 변수b에 담음
// 변수 b는 복호화 가능한 형태로 암호화되어서 저장됨

// 앉고싶은자가 함수 j를 호출할때 변수a에 열차번호를 입력함.
// 이때 어떤 앉은자가 함수 i를 호출하여 변수a에 입력해놓은 좌석번호가 앉고싶은자가 함수 j를 호출할때 입력한 변수a와 같다면 함수i의 암호화된 변수b를 복호화하여 함수 j를 호출한 사람에게 출력함.


// 3호선의 역번호가 제일 깔끔하기에 우선 3호선만 만들어 보겠다.
// 출처 - https://ko.wikipedia.org/wiki/%EC%88%98%EB%8F%84%EA%B6%8C_%EC%A0%84%EC%B2%A0_3%ED%98%B8%EC%84%A0
// 309번 대화역 ~ 352번 오금역까지이다. 변수는 그냥 역 번호를 그대로 사용하겠다.


//*추가적으로 해야 할 일
//1.[완]내리는역 변수 추가(함수 i,j 둘다)
//2.함수 i를 호출한 사람에게 토큰보내기
//3.함수 j를 호출한 사람에게 토큰받기
//4.함수 i에서 받은 열차번호에 해당하는열차가 함수i의 내리는역 변수에 도착 시 해당 데이터를 블록체인에서 지우기
//5.[완]함수 i를 호출할 때 배열에 timestamp기준으로 1씩 증가하는 id넣기(만약 같은 열차에 타서 내리지 않고 앉아있는 사람이 많을 때 좌석번호가 리셋되지 않고 빨리 내리는 순서대로 배열에 담기게 만들기) 생각만해도 어렵....
