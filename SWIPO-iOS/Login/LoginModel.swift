//
//  LoginModel.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/21/24.
//

import Foundation
struct LoginModel: Codable{
    var userId: Int64?
    var accessToken: String?
    var refreshToken: String?
    var providerId: String?
    var profileImage: String?
}

struct refreshTokenModel: Codable{
    var accessToken: String?
}
