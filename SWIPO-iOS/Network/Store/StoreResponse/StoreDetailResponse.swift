//
//  StoreDetailResponse.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/23/24.
//

import Foundation

struct StoreDetailResponse: Codable {
    let status: Int
    let message: String
    let data: StoreDetailData
}

struct StoreDetailData: Codable {
    let storeId: String
    let name: String
    let address: String
    let percent: Int
    let stars: Double
    let isWish: Bool
    let reviewsNum: Int
    let reviews: [String]?
    let imagesNum: Int
    let images: [String]
}
