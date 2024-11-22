//
//  SwipayModel.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/18/24.
//

import Foundation

struct RecentUsageModel: Codable{
    var id: Int64
    var region: String
    var title: String
    var date: String
    var type: String
    var price: String
}

struct SwipayCardModel: Codable{
    var id: Int64
    var region: String
    var cardImage: String
    var point: String
}

struct SwipayPointModel: Codable {
    var id: Int64
    var region: String
    var cardImage: String
    var point: Int
}

struct SwipayNewsModel: Codable{
    var id: Int64
    var title: String
    var content: String
}
