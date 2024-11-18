//
//  SwipayViewModel.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/18/24.
//

import Foundation

class SwipayViewModel: ObservableObject {
    struct State {
        //최근 이용내역
        var getRecentUsageResponse: [RecentUsageModel] = [RecentUsageModel(id: 1, region: "ulsan", title: "맛찬들왕소금구이 울산 무거점", date: "11.12 14:17", type: "결제", price: "10,500"), RecentUsageModel(id: 2, region: "busan", title: "맛찬들왕소금구이 울산 무거점", date: "11.12 14:17", type: "결제", price: "10,500"), RecentUsageModel(id: 3, region: "seoul", title: "맛찬들왕소금구이 울산 무거점", date: "11.12 14:17", type: "결제", price: "10,500"), RecentUsageModel(id: 4, region: "daegu", title: "맛찬들왕소금구이 울산 무거점", date: "11.12 14:17", type: "결제", price: "10,500"), RecentUsageModel(id: 5, region: "daejeon", title: "맛찬들왕소금구이 울산 무거점", date: "11.12 14:17", type: "결제", price: "10,500"), RecentUsageModel(id: 6, region: "jeju", title: "맛찬들왕소금구이 울산 무거점", date: "11.12 14:17", type: "결제", price: "10,500")]
        
        //스위포인트 카드
        var getSwipointCardResponse: [SwipayCardModel] = [SwipayCardModel(id: 1, region: "부산", cardImage: "", point: "2,111"), SwipayCardModel(id: 2, region: "서울", cardImage: "", point: "2,222"), SwipayCardModel(id: 3, region: "울산", cardImage: "", point: "2,000"), SwipayCardModel(id: 4, region: "제주", cardImage: "", point: "4,000")]
        
        //스위페이 뉴스
        var getSwipayNewsResponse: [SwipayNewsModel] = [SwipayNewsModel(id: 1, title: "지역 화폐의 새로운 패러다임! 🎉\n스위포의 탄생배경 알고 계셨나요?", content: "지역화폐의 효과는 '역외 소비지출 차단'으로, 즉 쓸 수 있는 지역 안에서만 소비를 늘리는 데 있습니다. 대부분의 지자체가 지역화폐를 발행한 지금, 지역경제 활성화 효과가 무의미 하다는 사실 알고 계셨나요?"), SwipayNewsModel(id: 2, title: "지역 화폐의 새로운 패러다임! 🎉\n스위포의 탄생배경 알고 계셨나요?", content: "지역화폐의 효과는 '역외 소비지출 차단'으로, 즉 쓸 수 있는 지역 안에서만 소비를 늘리는 데 있습니다. 대부분의 지자체가 지역화폐를 발행한 지금, 지역경제 활성화 효과가 무의미 하다는 사실 알고 계셨나요?"), SwipayNewsModel(id: 3, title: "지역 화폐의 새로운 패러다임! 🎉\n스위포의 탄생배경 알고 계셨나요?", content: "지역화폐의 효과는 '역외 소비지출 차단'으로, 즉 쓸 수 있는 지역 안에서만 소비를 늘리는 데 있습니다. 대부분의 지자체가 지역화폐를 발행한 지금, 지역경제 활성화 효과가 무의미 하다는 사실 알고 계셨나요?"), SwipayNewsModel(id: 4, title: "지역 화폐의 새로운 패러다임! 🎉\n스위포의 탄생배경 알고 계셨나요?", content: "지역화폐의 효과는 '역외 소비지출 차단'으로, 즉 쓸 수 있는 지역 안에서만 소비를 늘리는 데 있습니다. 대부분의 지자체가 지역화폐를 발행한 지금, 지역경제 활성화 효과가 무의미 하다는 사실 알고 계셨나요?"), SwipayNewsModel(id: 5, title: "지역 화폐의 새로운 패러다임! 🎉\n스위포의 탄생배경 알고 계셨나요?", content: "지역화폐의 효과는 '역외 소비지출 차단'으로, 즉 쓸 수 있는 지역 안에서만 소비를 늘리는 데 있습니다. 대부분의 지자체가 지역화폐를 발행한 지금, 지역경제 활성화 효과가 무의미 하다는 사실 알고 계셨나요?"), SwipayNewsModel(id: 6, title: "지역 화폐의 새로운 패러다임! 🎉\n스위포의 탄생배경 알고 계셨나요?", content: "지역화폐의 효과는 '역외 소비지출 차단'으로, 즉 쓸 수 있는 지역 안에서만 소비를 늘리는 데 있습니다. 대부분의 지자체가 지역화폐를 발행한 지금, 지역경제 활성화 효과가 무의미 하다는 사실 알고 계셨나요?")]
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

