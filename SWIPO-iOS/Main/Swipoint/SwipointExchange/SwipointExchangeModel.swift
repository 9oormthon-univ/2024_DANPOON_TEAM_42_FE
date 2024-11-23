//
//  SwipointExchangeModel.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/24/24.
//

import Foundation

struct ExchangeAvaliable: Codable{
    var cardNum: Int
    var cards: [Cards]
}

struct Cards: Codable{
    var cardId: String
    var region: String
    var point: Int
    var customImage: String
}

struct ExchangeModel: Codable{
    var fromCardId: String
    var toCardId: String
    var fromPoint: Int
    var toPoint: Int
}

