//
//  SwipstoneModel.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/20/24.
//

import Foundation

struct SwipstoneModel: Codable{
    var id: Int64
    var point: String
    var collect: Bool
    var achieve: Bool
    var piece: [String]
}

struct SwipstonePieceModel: Codable{
    var id: Int64
    var region: String
    var count: Int64
}
