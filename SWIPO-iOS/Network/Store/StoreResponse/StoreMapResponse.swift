//
//  StoreMapResponse.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/23/24.
//

import Foundation

struct StoreMapResponse: Codable {
    let wishlist: [StoreMap]
    let nonWishlist: [StoreMap]
}

struct StoreMap: Codable {
    let storeId: Int
    let percent: Int
    let type: String
    let latitude: Double
    let longitude: Double
}

// test용
struct StoreModel: Codable {
    let name: String
    let address: String
    let imageName: [String]
    let point: Int
    let rating: Double
    let reviewCount: Int
    var isFavorite: Bool
    let isHot: Bool
    let category: String
    let review: [String]
}
