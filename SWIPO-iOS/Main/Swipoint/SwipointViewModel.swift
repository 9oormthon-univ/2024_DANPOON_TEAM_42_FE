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
        var getSwipointCardResponse: [SwipointCardModel] = [SwipointCardModel(id: 1, region: "부산", cardImage: "", point: "2,111"), SwipointCardModel(id: 2, region: "서울", cardImage: "", point: "2,222"), SwipointCardModel(id: 3, region: "울산", cardImage: "", point: "2,000"), SwipointCardModel(id: 4, region: "제주", cardImage: "", point: "4,000")]
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

