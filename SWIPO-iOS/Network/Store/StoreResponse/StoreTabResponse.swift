//
//  StoreTabResponse.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/23/24.
//

import Foundation

struct StoreTabResponse: Codable {
    let data: StoreTabData
}

struct StoreTabData: Codable {
    let wishlists: [StoreTab]
    let picks: [StoreTab]
    let trends: [StoreTab]
    let tastes: [StoreTab]
    let labs: [StoreTab]
}

struct StoreTab: Codable {
    let storeId: String
    let name: String
    let address: String
    let percent: Int
    let reviewComment: String
    let imageUrl: String
}
