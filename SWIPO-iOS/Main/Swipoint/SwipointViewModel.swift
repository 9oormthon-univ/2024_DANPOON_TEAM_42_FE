//
//  SwipointViewModel.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/19/24.
//

import Foundation
class SwipointViewModel: ObservableObject {
    struct State {
        
        //스위포인트 카드
        var getSwipointCardResponse: [SwipointCardModel] = [SwipointCardModel(id: 1, region: "부산", cardImage: "", point: "2,111"), SwipointCardModel(id: 2, region: "서울", cardImage: "", point: "2,222"), SwipointCardModel(id: 3, region: "대전", cardImage: "", point: "2,000"), SwipointCardModel(id: 4, region: "제주", cardImage: "", point: "4,000")]
    }
    
    enum Action {
        
    }
    
    @Published var state: State
    
    init(
        state: State = .init()
    ) {
        self.state = state
    }
    
    func action(_ action: Action) async {
        
    }
}

extension SwipointViewModel {
    // 정식 지역 명칭을 줄인 이름으로 변환하는 함수
    func convertFullRegionToShort(inputRegion: String) -> String? {
        let fullToShortRegionMapping: [String: String] = [
            "서울특별시": "서울",
            "경상남도": "경남",
            "경기도": "경기",
            "인천광역시": "인천",
            "강원특별자치도": "강원",
            "충청남도": "충남",
            "대전광역시": "대전",
            "충청북도": "충북",
            "세종특별자치시": "세종",
            "부산광역시": "부산",
            "울산광역시": "울산",
            "대구광역시": "대구",
            "경상북도": "경북",
            "전라남도": "전남",
            "광주광역시": "광주",
            "전라북도": "전북",
            "제주특별자치도": "제주"
        ]
        return fullToShortRegionMapping[inputRegion]
    }

    // 도로명 주소와 스윕스톤에서 출력하는 지역으로 전환 후 기존 카드에 존재하는지 비교하는 함수
    func isRegionAvailable(inputRegion: String) -> Bool {
        guard let shortRegion = convertFullRegionToShort(inputRegion: inputRegion) else {
            return true // 매핑에 없는 지역이라면 사용 가능(true)으로 간주
        }

        // 카드 리스트에 줄인 지역 이름이 존재하는지 확인
        let isCardExists = state.getSwipointCardResponse.contains(where: { $0.region == shortRegion })
        return !isCardExists // 카드가 존재하지 않으면 true, 존재하면 false 반환
    }
    
    // 지역 이름을 영어로 치환 (이미지 사용을 위함)
    func convertRegionToEnglish(koreanRegion: String) -> String? {
        let regionMapping: [String: String] = [
            "서울": "seoul",
            "경남": "gyeongnam",
            "경기": "gyeonggi",
            "인천": "incheon",
            "강원": "gangwon",
            "충남": "chungcheongnam",
            "대전": "daejeon",
            "충북": "chungcheongbuk",
            "세종": "sejong",
            "부산": "busan",
            "울산": "ulsan",
            "대구": "daegu",
            "경북": "gyeongsangbuk",
            "전남": "jeollanam",
            "광주": "gwanju",
            "전북": "jeollabuk",
            "제주": "jeju"
        ]
        return regionMapping[koreanRegion]
    }
}

