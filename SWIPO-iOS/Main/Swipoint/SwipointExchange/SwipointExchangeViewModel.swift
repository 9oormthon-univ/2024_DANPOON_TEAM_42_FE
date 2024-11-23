//
//  SwipointExchangeViewModel.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/24/24.
//

import Foundation

class SwipointExchangeViewModel: ObservableObject {
    struct State {
        var getSwipointCardResponse: ExchangeAvaliable = ExchangeAvaliable(cardNum: 0, cards: [Cards(cardId: "", region: "", point: 0, customImage: "")])
        var getExchangeResponse: ExchangeModel = ExchangeModel(fromCardId: "", toCardId: "", fromPoint: 0, toPoint: 0)
    }
    
    enum Action {
        case getSwipointCard
        case exchangePoint(fromCardId: String, toCardId: String, point: Int)
    }
    
    @Published var state: State
    
    init(
        state: State = .init()
    ) {
        self.state = state
    }
    
    func action(_ action: Action) async {
        switch action {
        case let .getSwipointCard:
            if let response = await SwipExchangeService.getSwipointCard() {
                print(response)
                await MainActor.run {
                    print("\(response.code)")
                    
                    if let reponseData = response.data {
                        state.getSwipointCardResponse = reponseData
                    } else {
                        print("Error")
                    }
                }
            } else {
                print("Error")
            }
        case let .exchangePoint(fromCardId, toCardId, point):
            if let response = await SwipExchangeService.exchangePoint(fromCardId: fromCardId, toCardId: toCardId, point: point) {
                print(response)
                await MainActor.run {
                    print("\(response.code)")
                    
                    if let reponseData = response.data {
                        state.getExchangeResponse = reponseData
                    } else {
                        print("Error")
                    }
                }
            } else {
                print("Error")
            }
        }
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
