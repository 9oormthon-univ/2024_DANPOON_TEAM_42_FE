//
//  StoreReviewRequest.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/23/24.
//

import Foundation

struct StoreReviewRequest: Encodable {
    let storeId: Int
    let star: Double
    let comment: String
}
