//
//  SwipointViewModel.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/19/24.
//

import Foundation
class SwipointViewModel: ObservableObject {
    struct State {
        
//        //스위포인트 카드
//        var getSwipointCardResponse: [cardInfo] = [cardInfo(cardId: "1", region: "울산", point: 2000, customImage: ""), cardInfo(cardId: "2", region: "부산", point: 2000, customImage: "")]
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
