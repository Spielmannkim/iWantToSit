// SPDX-License-Identifier: MIT

// 사용법
// solidity버전을 0.8.0으로 맞춰서 컴파일 후 디플로이.
// seatedPerson함수에 3호선 기준 trainNumber, seatNumber, gettingOffSubwayStationNumber 번호들 넣는 규칙
// trainNumber = 지하철을 타면 승하차하는 문의 유리창에 쓰여있다.(참고-https://github.com/Spielmannkim/iWantToSit/blob/main/img/3%ED%98%B8%EC%84%A0%EC%B0%A8%EB%9F%89%EB%B2%88%ED%98%B8.jfif)
// seatNumber = 노약자석은 제외하고 1번부터 (7석기준)48번까지, (6석기준)36번까지 있다.(참고-https://github.com/Spielmannkim/iWantToSit/blob/main/img/%EC%A7%80%ED%95%98%EC%B2%A0%EC%A2%8C%EC%84%9D%EB%B2%88%ED%98%B8%ED%91%9C.png)
// gettingOffSubwayStationNumber = 309번 대화역 ~ 352번 오금역까지있다.(참고-https://ko.wikipedia.org/wiki/%EC%88%98%EB%8F%84%EA%B6%8C_%EC%A0%84%EC%B2%A0_3%ED%98%B8%EC%84%A0)

// 사용예시(seatedPerson)
// [입력] trainNumber : 3123, seatNumber : 7, gettingOffSubwayStationNumber:311

// 사용예시(wantToSitPerson)
// [입력] trainNumber : 3123
// [출력] 0: string: {"1":"7","311"}

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


//1.함수 i를 호출한 사람에게 토큰보내기
//2.함수 j를 호출한 사람에게 토큰받기
//3.함수 i에서 받은 열차번호에 해당하는열차가 함수i의 내리는역 변수에 도착 시 해당 데이터를 블록체인에서 지우기

