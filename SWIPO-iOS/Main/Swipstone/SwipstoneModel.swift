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
    var achievedPieces: [String]? // 카드 완성 시 조각 스냅샷
}

struct SwipstonePieceModel: Codable{
    var picesNum: Int64
    var pieces: [PieceModel]
}

struct PieceModel: Codable {
    var myPieceId: String
    var pieceName: String
}

struct SwipstonePieceCountModel {
    var region: String
    var count: Int
}

struct UsedPieceInfo: Codable {
    let point: Int
    let usePieceNum: Int
    let myPieceIds: [String]
}

struct SubtractPieceModel: Codable {
    let totalPay: Int
}
