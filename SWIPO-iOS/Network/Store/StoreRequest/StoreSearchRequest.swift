//
//  StoreSearchRequest.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/23/24.
//

import Foundation

struct StoreSearchRequest: Encodable {
    let keyword: String
    let category: String
    let type: String
    let page: Int
}
