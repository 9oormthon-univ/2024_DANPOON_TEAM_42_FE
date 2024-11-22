//
//  SwipayEndPoint.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/23/24.
//

import Foundation
import Alamofire

enum SwipayEndPoint {
    case getSwipay // 카카오 로그인
}

extension SwipayEndPoint: EndPoint {
    var baseURL: String {
        return "\(Secrets.baseUrl)/point"
    }
    
    var path: String {
        switch self {
        case .getSwipay:
            return "/home"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getSwipay:
            return .get
        }
    }
    
    var task: APITask {
        switch self {
        case let .getSwipay:
            return .requestPlain
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .getSwipay:
            if let accessToken = KeyChainManager.readItem(key: "accessToken") {
                return ["Authorization": "Bearer \(accessToken)"]
            } else {
                return nil
            }
        }
    }
}

