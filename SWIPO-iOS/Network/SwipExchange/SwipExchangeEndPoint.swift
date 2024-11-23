//
//  SwipExchangeEndPoint.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/24/24.
//

import Foundation
import Alamofire

enum SwipExchangeEndPoint {
    case getSwipointCard
    case exchangePoint(fromCardId: String, toCardId: String, point: Int)
}

extension SwipExchangeEndPoint: EndPoint {
    var baseURL: String {
        return "\(Secrets.baseUrl)/point"
    }
    
    var path: String {
        switch self {
        case .getSwipointCard:
            return "/transfer-info"
        case .exchangePoint:
            return "/transefer"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getSwipointCard:
            return .get
        case .exchangePoint:
            return .post
        }
    }
    
    var task: APITask {
        switch self {
        case let .getSwipointCard:
            return .requestPlain
        case let .exchangePoint(fromCardId, toCardId, point):
            let body: [String : Any] = ["fromCardId": fromCardId, "toCardId": toCardId, "point": point]
            return .requestParameters(parameters: body)
        }
    }
}
