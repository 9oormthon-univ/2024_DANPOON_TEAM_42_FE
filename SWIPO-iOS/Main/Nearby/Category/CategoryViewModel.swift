//
//  CategoryViewModel.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/21/24.
//

import Foundation

class CategoryViewModel: ObservableObject {
    struct State {
        // 카테고리 종류
        var categoryType = [CategoryModel(title: "관심등록 가맹점 💛", content: "윤다희님의 관심 가맹점들 가보고 싶어지네요!"),
                            CategoryModel(title: "스위포 PICK 👍", content: "내 주변에도 숨겨진 흑요리사가? 맛보장 리스트!"),
                            CategoryModel(title: "윤다희님 이런 가맹점 어때요? 🔥", content: "24세 여성 사용자들에게 아주 HOT해요!"),
                            CategoryModel(title: "윤다희님 취향 가득 🥰", content: "“의도 카페” 자주 방문하시네요! 이곳은 어때요?")]
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
