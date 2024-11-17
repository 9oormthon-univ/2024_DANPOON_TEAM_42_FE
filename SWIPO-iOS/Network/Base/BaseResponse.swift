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
    let status: Int
    let message: String
    let result: T?

    enum CodingKeys: String, CodingKey {
        case status
        case message
        case result
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(Int.self, forKey: .status)
        message = try container.decode(String.self, forKey: .message)
        result = try container.decodeIfPresent(T.self, forKey: .result)
    }
}

struct DeleteResponse: Codable {
    let status: Int
    let message: String

    enum CodingKeys: String, CodingKey {
        case status
        case message
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(Int.self, forKey: .status)
        message = try container.decode(String.self, forKey: .message)
    }
}

