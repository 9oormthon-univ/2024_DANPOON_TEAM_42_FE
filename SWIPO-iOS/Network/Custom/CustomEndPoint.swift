//
//  CustomEndPoint.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/23/24.
//

import Foundation
import Alamofire

enum CustomEndPoint {
    case registerCard(region: String, custom_image: String, multipartFile: [Foundation.Data?])
}

extension CustomEndPoint: EndPoint {
    var baseURL: String {
        return "\(Secrets.baseUrl)/point"
    }
    
    var path: String {
        switch self {
        case .registerCard:
            return "/card-register"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .registerCard:
            return .post
        }
    }
    
    var task: APITask {
        switch self {
        case let .registerCard(region, custom_image, multipartFile):
            let body = ["region": region, "custom_image": custom_image]
            return .requestJSONWithImage(multipartFile: multipartFile, body: body, withInterceptor: true)
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .registerCard:
            if let accessToken = KeyChainManager.readItem(key: "accessToken") {
                return ["Authorization": "Bearer \(accessToken)",  "Content-Type": "multipart/form-data",]
            } else {
                return nil
            }
        }
    }
}
