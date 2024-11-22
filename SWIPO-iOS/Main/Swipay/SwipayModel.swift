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

struct SwipayNewsModel: Codable{
    var id: Int64
    var title: String
    var content: String
}


struct SwipayModel: Codable{
    var balance:  Int64
    var totalCards: Int64
    var cards: [cardInfo]
    var paylistInfos: [paylistInfo]
}

struct cardInfo: Codable {
    var cardId: String
    var region: String
    var point: Int64
    var customImage: String
}

struct paylistInfo: Codable{
    var paylistId: String
    var amount: Int64
    var storeName: String
    var createAt: String
}



struct SwipayPointModel: Codable {
    var id: Int64
    var region: String
    var cardImage: String
    var point: Int
}
