//
//  StoreModel.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/18/24.
//

import Foundation
import SwiftUI

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
