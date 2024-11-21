//
//  LoginModel.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/21/24.
//

import Foundation
struct LoginModel: Codable{
    var user_id: String
    var accessToken: String
    var refreshToken: String
}
