//
//  StoreEndPoint.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/23/24.
//

import Foundation
import Alamofire

enum StoreEndPoint {
    case getStoreMap
    case getStoreDetail(storeId: Int)
    case getStoreTab
    case getStoreSearch(request: StoreSearchRequest)
    case postStoreWish(request: StoreWishRequest)
    case postStoreReview(request: StoreReviewRequest)
}

extension StoreEndPoint: EndPoint {
    var baseURL: String {
        return "\(Secrets.baseUrl)/store"
    }

    var path: String {
        switch self {
        case .getStoreMap:
            return "/map"
        case .getStoreDetail:
            return "/details"
        case .getStoreTab:
            return "/tabs"
        case .getStoreSearch:
            return "/search"
        case .postStoreWish:
            return "/wish"
        case .postStoreReview:
            return "/reviews"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getStoreMap, .getStoreDetail, .getStoreTab, .getStoreSearch:
            return .get
        case .postStoreWish, .postStoreReview:
            return .post
        }
    }

    var task: APITask {
        switch self {
        case .getStoreMap:
            return .requestPlain
        case let .getStoreDetail(storeId):
            return .requestParameters(parameters: ["storeId": storeId])
        case .getStoreTab:
            return .requestPlain
        case let .getStoreSearch(request):
            return .requestParameters(parameters: ["keyword": request.keyword,
                                                   "category": request.category,
                                                   "type": request.type,
                                                   "page": request.page])
        case let .postStoreWish(request):
            return .requestParameters(parameters: ["storeId": request.storeId,
                                                   "isWish": request.isWish])
        case let .postStoreReview(request):
            return .requestJSONEncodable(body: request)
        }
    }

    var headers: HTTPHeaders? {
        if let accessToken = KeyChainManager.readItem(key: "accessToken") {
            return ["Authorization": "Bearer \(accessToken)"]
        } else {
            return nil
        }
    }
}

