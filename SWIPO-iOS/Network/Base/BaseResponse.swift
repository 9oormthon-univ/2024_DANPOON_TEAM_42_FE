//
//  BaseResponse.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/18/24.
//

import Foundation

struct EmptyResponseModel: Codable {
    
}

struct BaseResponse<T: Codable>: Codable {
    let code: Int
    let message: String
    let data: T?

    enum CodingKeys: String, CodingKey {
        case code
        case message
        case data
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(Int.self, forKey: .code)
        message = try container.decode(String.self, forKey: .message)
        data = try container.decodeIfPresent(T.self, forKey: .data)
    }
}

struct DeleteResponse: Codable {
    let code: Int
    let message: String

    enum CodingKeys: String, CodingKey {
        case code
        case message
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(Int.self, forKey: .code)
        message = try container.decode(String.self, forKey: .message)
    }
}

