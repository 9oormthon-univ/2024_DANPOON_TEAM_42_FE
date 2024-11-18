//
//  StoreModel.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/18/24.
//

import Foundation

struct Store: Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let imageName: String
    let point: String
    let rating: Double
    let reviewCount: Int
    let isFavorite: Bool
    let isHot: Bool
    let category: String
}

let sampleStores = [
    Store(name: "맛찬들왕소금구이 울산 무거점", address: "울산 남구 신복로22번길 21", imageName: "sample1", point: "Point 5%", rating: 5.0, reviewCount: 35, isFavorite: true, isHot: false, category: "음식점"),
    Store(name: "의도카페", address: "울산 남구 대학로52번길 5-17 1층", imageName: "sample2", point: "Point 15%", rating: 4.5, reviewCount: 549, isFavorite: false, isHot: true, category: "카페"),
    Store(name: "울리정", address: "울산 울주군 청량읍 울밀로영해1길 170-6", imageName: "sample3", point: "Point 10%", rating: 4.8, reviewCount: 89, isFavorite: true, isHot: false, category: "음식점")
]
