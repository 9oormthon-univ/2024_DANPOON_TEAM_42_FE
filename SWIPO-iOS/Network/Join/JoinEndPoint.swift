//
//  JoinEndPoint.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/22/24.
//

import Foundation
import Alamofire
enum JoinEndPoint {
    case getPhoneChk(phone: String) // 전화번호 인증
    case getVerificationChk(phone: String, code: String) // 전화번호 인증번호 확인
    case getJoin(provider: String, providerId: String, name: String, address: String, birth: String, telecom: String, phone: String, isMarket: Bool, pwd: String)
}

extension JoinEndPoint: EndPoint {
    var baseURL: String {
        return "https://duoh.site/v1"
    }
    
    var path: String {
        switch self {
        case .getPhoneChk:
            return "/user/phone"
        case .getVerificationChk:
            return "/user/phone-verification"
        case .getJoin:
            return "/user/register"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPhoneChk:
            return .post
        case .getVerificationChk:
            return .post
        case .getJoin:
            return .post
        }
    }
    
    var task: APITask {
        switch self {
        case let .getPhoneChk(phone):
            let body = ["phone": phone] // 요청 바디를 JSON 형식으로 생성
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
        }
    }
}

