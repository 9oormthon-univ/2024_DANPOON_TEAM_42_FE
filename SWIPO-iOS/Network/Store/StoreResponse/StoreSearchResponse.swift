//
//  StoreSearchResponse.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/23/24.
//

import Foundation

struct StoreSearchResponse: Codable {
    let status: Int
    let message: String
    let data: StoreSearchData
}

struct StoreSearchData: Codable {
    let pageInfo: PageInfoData
    let stores: [StoreSearch]
}

struct PageInfoData: Codable {
    let currentPage: Int
    let totalPages: Int
    let totalItems: Int
}

struct StoreSearch: Codable {
    let storeId: String
    let name: String
    let address: String
    let percent: Int
    let stars: Double
    let isWish: Bool
    let reviewsNum: Int
    let reviews: [String]?
    let imagesNum: Int
    let imageUrls: [String]
}
