//
//  StoreSearchRequest.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/23/24.
//

import Foundation

struct StoreSearchRequest: Encodable {
    let latitude: Double
    let longitude: Double
    let radius: Double
}
