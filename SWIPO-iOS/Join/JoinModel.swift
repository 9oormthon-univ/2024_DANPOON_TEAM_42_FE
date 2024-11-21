//
//  JoinModel.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/22/24.
//

import Foundation

struct JoinModel: Codable{
    var user_id: Int64?
    var accessToken: String?
    var refreshToken: String?
}

struct JoinRequestBody: Encodable {
    let provider: String
    let providerId: String
    let name: String
    let address: String
    let birth: String
    let telecom: String
    let phone: String
    let isMarket: Bool
    let pwd: String
}
