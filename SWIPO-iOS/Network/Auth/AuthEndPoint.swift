//
//  AuthEndPoint.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/22/24.
//

import Foundation
import Alamofire

enum AuthEndPoint {
    case getKakaoLogin(kakaoCode: String) // 카카오 로그인
    case getAppleLogin(token: String) //애플 로그인
    case getPhoneChk(phone: String) // 전화번호 인증
    case getVerificationChk(phone: String, code: String) // 전화번호 인증번호 확인
    case getJoin(provider: String, providerId: String, name: String, address: String, birth: String, telecom: String, phone: String, isMarket: Bool, pwd: String)
    case refreshingToken(refreshToken: String)
}

extension AuthEndPoint: EndPoint {
    var baseURL: String {
        return "\(Secrets.baseUrl)/user"
    }
    
    var path: String {
        switch self {
        case .getKakaoLogin:
            return "/kakao"
        case .getAppleLogin:
            return "/apple"
        case .getPhoneChk:
            return "/phone"
        case .getVerificationChk:
            return "/phone-verification"
        case .getJoin:
            return "/register"
        case .refreshingToken:
            return "/tokenRefresh"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getKakaoLogin:
            return .post
        case .getAppleLogin:
            return .post
        case .getPhoneChk:
            return .post
        case .getVerificationChk:
            return .post
        case .getJoin:
            return .post
        case .refreshingToken:
            return .post
        }
    }
    
    var task: APITask {
        switch self {
        case let .getKakaoLogin(kakaoCode):
            let param = ["kakaoCode": kakaoCode] as [String: Any]
            return .requestParameters(parameters: param)
        case let .getAppleLogin(token):
            let body = ["token": token]
            return .requestWithoutInterceptor(body: body)
        case let .getPhoneChk(phone):
            let body = ["phone": phone]
            return .requestWithoutInterceptor(body: body)
        case let .getVerificationChk(phone, code):
            let body = ["phone": phone, "code":code]
            return .requestWithoutInterceptor(body: body)
        case let .getJoin(provider, providerId, name, address, birth, telecom, phone, isMarket, pwd):
            let body = JoinRequestBody(
                    provider: provider,
                    providerId: providerId,
                    name: name,
                    address: address,
                    birth: birth,
                    telecom: telecom,
                    phone: phone,
                    isMarket: isMarket,
                    pwd: pwd
                )
            return .requestWithoutInterceptor(body: body)
        case let .refreshingToken(refreshToken):
            let body = ["refreshToken": refreshToken]
            return .requestWithoutInterceptor(body: body)
        }
    }
}
