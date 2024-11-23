//
//  SwipayViewModel.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/18/24.
//

import Foundation

class SwipayViewModel: ObservableObject {
    struct State {
        var getSwipayResponse: SwipayModel = SwipayModel(userName: "", balance: 0, totalCards: 0, cards: [cardInfo(cardId: "0", region: "", point: 0, customImage: "")], paylistInfos: [paylistInfo(paylistId: "", amount: 0, storeName: "", createAt: "")])
        
        //최근 이용내역
        var getRecentUsageResponse: [RecentUsageModel] = [RecentUsageModel(id: 1, region: "ulsan", title: "맛찬들왕소금구이 울산 무거점", date: "11.12 14:17", type: "결제", price: "10,500"), RecentUsageModel(id: 2, region: "busan", title: "맛찬들왕소금구이 울산 무거점", date: "11.12 14:17", type: "결제", price: "10,500"), RecentUsageModel(id: 3, region: "seoul", title: "맛찬들왕소금구이 울산 무거점", date: "11.12 14:17", type: "결제", price: "10,500"), RecentUsageModel(id: 4, region: "daegu", title: "맛찬들왕소금구이 울산 무거점", date: "11.12 14:17", type: "결제", price: "10,500"), RecentUsageModel(id: 5, region: "daejeon", title: "맛찬들왕소금구이 울산 무거점", date: "11.12 14:17", type: "결제", price: "10,500"), RecentUsageModel(id: 6, region: "jeju", title: "맛찬들왕소금구이 울산 무거점", date: "11.12 14:17", type: "결제", price: "10,500")]
        
        //스위포인트 카드
        var getSwipointCardResponse: [cardInfo] = []
        
        //스위페이 뉴스
        var getSwipayNewsResponse: [SwipayNewsModel] = [SwipayNewsModel(id: 1, title: "지역 화폐의 새로운 패러다임! 🎉\n스위포의 탄생배경 알고 계셨나요?", content: "지역화폐의 효과는 '역외 소비지출 차단'으로, 즉 쓸 수 있는 지역 안에서만 소비를 늘리는 데 있습니다. 대부분의 지자체가 지역화폐를 발행한 지금, 지역경제 활성화 효과가 무의미 하다는 사실 알고 계셨나요?"), SwipayNewsModel(id: 2, title: "지역 화폐의 새로운 패러다임! 🎉\n스위포의 탄생배경 알고 계셨나요?", content: "지역화폐의 효과는 '역외 소비지출 차단'으로, 즉 쓸 수 있는 지역 안에서만 소비를 늘리는 데 있습니다. 대부분의 지자체가 지역화폐를 발행한 지금, 지역경제 활성화 효과가 무의미 하다는 사실 알고 계셨나요?"), SwipayNewsModel(id: 3, title: "지역 화폐의 새로운 패러다임! 🎉\n스위포의 탄생배경 알고 계셨나요?", content: "지역화폐의 효과는 '역외 소비지출 차단'으로, 즉 쓸 수 있는 지역 안에서만 소비를 늘리는 데 있습니다. 대부분의 지자체가 지역화폐를 발행한 지금, 지역경제 활성화 효과가 무의미 하다는 사실 알고 계셨나요?"), SwipayNewsModel(id: 4, title: "지역 화폐의 새로운 패러다임! 🎉\n스위포의 탄생배경 알고 계셨나요?", content: "지역화폐의 효과는 '역외 소비지출 차단'으로, 즉 쓸 수 있는 지역 안에서만 소비를 늘리는 데 있습니다. 대부분의 지자체가 지역화폐를 발행한 지금, 지역경제 활성화 효과가 무의미 하다는 사실 알고 계셨나요?"), SwipayNewsModel(id: 5, title: "지역 화폐의 새로운 패러다임! 🎉\n스위포의 탄생배경 알고 계셨나요?", content: "지역화폐의 효과는 '역외 소비지출 차단'으로, 즉 쓸 수 있는 지역 안에서만 소비를 늘리는 데 있습니다. 대부분의 지자체가 지역화폐를 발행한 지금, 지역경제 활성화 효과가 무의미 하다는 사실 알고 계셨나요?"), SwipayNewsModel(id: 6, title: "지역 화폐의 새로운 패러다임! 🎉\n스위포의 탄생배경 알고 계셨나요?", content: "지역화폐의 효과는 '역외 소비지출 차단'으로, 즉 쓸 수 있는 지역 안에서만 소비를 늘리는 데 있습니다. 대부분의 지자체가 지역화폐를 발행한 지금, 지역경제 활성화 효과가 무의미 하다는 사실 알고 계셨나요?")]
        
        // 스위포인트 환전 샘플 데이터
        var sampleSwipointExchange: [SwipayPointModel] = [SwipayPointModel(id: 1, region: "부산", cardImage: "", point: 2124),
                                                          SwipayPointModel(id: 2, region: "서울", cardImage: "", point: 12124)]
    }
    
    enum Action {
        case getSwipay
    }
    
    @Published var state: State
    
    init(
        state: State = .init()
    ) {
        self.state = state
    }
    
    func action(_ action: Action) async {
        switch action {
        case let .getSwipay:
            if let response = await SwipayService.getSwipay() {
                print(response)
                await MainActor.run {
                    print("\(response.code)")
                    
                    if let reponseData = response.data {
                        state.getSwipayResponse = reponseData
                        state.getSwipointCardResponse = reponseData.cards
                    } else {
                        print("Error")
                    }
                }
            } else {
                print("Error")
            }
        }
        
    }
}

extension SwipayViewModel {
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
