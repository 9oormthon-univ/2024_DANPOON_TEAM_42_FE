//
//  LoginEndPoint.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/21/24.
//

import Foundation
import Alamofire

enum LoginEndPoint {
    case getKakaoLogin(kakaoCode: String) // 카카오 로그인
    case getAppleLogin(token: String) //애플 로그인
}

extension LoginEndPoint: EndPoint {
    var baseURL: String {
        return "https://duoh.site/v1"
    }
    
    var path: String {
        switch self {
        case .getKakaoLogin:
            return "/user/kakao"
        case .getAppleLogin:
            return "/user/apple"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getKakaoLogin:
            return .post
        case .getAppleLogin:
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
        }
    }
}

