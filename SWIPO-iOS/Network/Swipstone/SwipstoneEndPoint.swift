//
//  SwipEndPoint.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/23/24.
//

import Foundation
import Alamofire

enum SwipstoneEndPoint {
    case getSwipstonePiece
    case subtractPiece(point: Int, usePieceNum: Int, myPieceIds: [String])
}

extension SwipstoneEndPoint: EndPoint {
    var baseURL: String {
        return "\(Secrets.baseUrl)/point"
    }
    
    var path: String {
        switch self {
        case .getSwipstonePiece:
            return "/swipstone"
        case .subtractPiece:
            return "/swipstone-swap"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getSwipstonePiece:
            return .get
        case .subtractPiece:
            return .post
        }
    }
    
    var task: APITask {
        switch self {
        case let .getSwipstonePiece:
            return .requestPlain
        case let .subtractPiece(point, usePieceNum, myPieceIds):
            let body: [String: Any] = ["point": point, "usePieceNum": usePieceNum, "myPieceIds": myPieceIds]
            return .requestParameters(parameters: body)
        }
    }
}
