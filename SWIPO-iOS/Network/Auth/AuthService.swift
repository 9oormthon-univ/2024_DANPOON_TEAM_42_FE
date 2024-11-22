//
//  AuthService.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/22/24.
//

import Foundation

struct AuthService {
    //전화번호 인증
    static func getPhoneChk(phone: String) async -> BaseResponse<EmptyResponseModel>? {
        return await NetworkManager.shared.request(AuthEndPoint.getPhoneChk(phone: phone))
    }
    
    //전화번호 인증번호 확인
    static func getVerificationChk(phone: String, code: String) async -> BaseResponse<EmptyResponseModel>? {
        return await NetworkManager.shared.request(AuthEndPoint.getVerificationChk(phone: phone, code: code))
    }
    
    //회원 가입
    static func getJoin(provider: String, providerId: String, name: String, address: String, birth: String, telecom: String, phone: String, isMarket: Bool, pwd: String) async -> BaseResponse<JoinModel>? {
        return await NetworkManager.shared.request(AuthEndPoint.getJoin(provider: provider, providerId: providerId, name: name, address: address, birth: birth, telecom: telecom, phone: phone, isMarket: isMarket, pwd: pwd))
    }
    
    //카카오 로그인
    static func getKakaoLogin(token: String) async -> BaseResponse<LoginModel>? {
        return await NetworkManager.shared.request(AuthEndPoint.getKakaoLogin(token: token))
    }
    
    //애플 로그인
    static func getAppleLogin(token: String) async -> BaseResponse<LoginModel>? {
        return await NetworkManager.shared.request(AuthEndPoint.getAppleLogin(token: token))
    }
    
    //accessToken 재발급
    static func refreshingToken(refreshToken: String) async -> BaseResponse<refreshTokenModel>? {
        return await NetworkManager.shared.request(AuthEndPoint.refreshingToken(refreshToken: refreshToken))
    }

}

