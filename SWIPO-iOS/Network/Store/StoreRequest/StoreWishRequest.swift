//
//  StoreWishRequest.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/23/24.
//

import Foundation

struct StoreWishRequest: Encodable {
    let storeId: String
    let isWish: Bool
}
