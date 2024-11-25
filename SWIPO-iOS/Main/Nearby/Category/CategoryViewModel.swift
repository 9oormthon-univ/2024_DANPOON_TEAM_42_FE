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
        var categoryType = [CategoryTitleModel(title: "관심등록 가맹점 💛", content: "엄재웅님의 관심 가맹점들 가보고 싶어지네요!"),
                            CategoryTitleModel(title: "스위포 PICK 👍", content: "내 주변에도 숨겨진 흑요리사가? 맛보장 리스트!"),
                            CategoryTitleModel(title: "엄재웅님 이런 가맹점 어때요? 🔥", content: "25세 남성 사용자들에게 아주 HOT해요!"),
                            CategoryTitleModel(title: "엄재웅님 취향 가득 🥰", content: "의도 카페 자주 방문하시네요! 이곳은 어때요?")]

        // 큐레이션
        var sampleCuration = [CategoryCurationModel(title: "반복되는 데이트가 질린다면?\n신원시장의 MZ저격 데이트 코스 💛",
                                                    imageName: "sample5",
                                                    content: "메리네 정원에서 시작하는 분식 데이트 🍙\n신원시장의 인기 분식집인 '메리네 정원'에서 김밥과 튀김으로 가볍게 시작해보세요. 특히 계란 김밥과 바삭한 튀김이 유명하니 꼭 맛보시길 추천합니다."),
                              CategoryCurationModel(title: "두번째 큐레이션 제목", imageName: "sample1", content: "두번째 큐레이션 내용"),
                              CategoryCurationModel(title: "세번째 큐레이션 제목", imageName: "sample2", content: "세번째 큐레이션 내용"),
                              CategoryCurationModel(title: "네번째 큐레이션 제목", imageName: "sample3", content: "네번째 큐레이션 내용"),
                              CategoryCurationModel(title: "다섯번째 큐레이션 제목", imageName: "sample4", content: "다섯번째 큐레이션 내용")]

        // Lab 종류
        var labType = [CategoryTitleModel(title: "👍 스위포 PICK!", content: "12개의 추천을 해드렸어요!"),
                       CategoryTitleModel(title: "🔥 사용자 트렌드", content: "AI가 24곳을 추천해 줬어요!"),
                       CategoryTitleModel(title: "🥰 내 취향 가득", content: "34곳의 맞춤 가맹점이 있네요!"),
                       CategoryTitleModel(title: "💛 관심 등록", content: "30곳을 관심 등록 하셨군요?"),
                       CategoryTitleModel(title: "👦 주요 소비자", content: "이곳은 20대 남성이 많네요!")]
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
