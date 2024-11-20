//
//  StoreViewModel.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/21/24.
//

import Foundation

class StoreViewModel: ObservableObject {
    struct State {
        // 내 주변 가맹점
        var sampleStores = [
            StoreModel(name: "맛찬들왕소금구이 울산 무거점", address: "울산 남구 신복로22번길 21", imageName: ["sample1", "sample2"], point: 5, rating: 5.0, reviewCount: 35, isFavorite: true, isHot: false, category: "음식점",
                  review: ["친구들과 꼭 들리는 곳! 저렴하고 너무 맛있어요! 특히 소금구이가 가성비 굿굿 ㅠㅠ", "배곺아요............."]),
            StoreModel(name: "의도카페", address: "울산 남구 대학로52번길 5-17 1층", imageName: ["sample2"], point: 15, rating: 4.5, reviewCount: 549, isFavorite: false, isHot: true, category: "카페",
                  review: ["카공하기 좋아용", "느좋", "케이크 맛집 !!"]),
            StoreModel(name: "울리정", address: "울산 울주군 청량읍 울밀로영해1길 170-6", imageName: ["sample3", "sample4", "sample1"], point: 10, rating: 4.8, reviewCount: 89, isFavorite: true, isHot: false, category: "음식점",
                  review: ["친구들과 꼭 들리는 곳! 저렴하고 너무 맛있어요! 특히 소금구이가 가성비 굿굿 ㅠㅠ", "배곺아요............."]),
            StoreModel(name: "비케이로스터즈", address: "울산 남구 신복로21번길 8 1층", imageName: ["sample4"], point: 5, rating: 5.0, reviewCount: 999, isFavorite: false, isHot: true, category: "음식점",
                  review: ["친구들과 꼭 들리는 곳! 저렴하고 너무 맛있어요! 특히 파스타 가성비 굿굿 ㅠㅠ", "배곺아요............."])
        ]
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
