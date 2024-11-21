//
//  LoginService.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/21/24.
//

import Foundation

struct LoginService {
    //카카오 로그인
    static func getKakaoLogin(kakaoCode: String) async -> BaseResponse<LoginModel>? {
        return await NetworkManager.shared.request(LoginEndPoint.getKakaoLogin(kakaoCode: kakaoCode))
    }
    
    //애플 로그인
    static func getAppleLogin(token: String) async -> BaseResponse<LoginModel>? {
        return await NetworkManager.shared.request(LoginEndPoint.getAppleLogin(token: token))
    }
}
