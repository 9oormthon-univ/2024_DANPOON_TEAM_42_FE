//
//  SwipExchangeService.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/24/24.
//

import Foundation
struct SwipExchangeService {

    static func getSwipointCard() async -> BaseResponse<ExchangeAvaliable>? {
        return await NetworkManager.shared.request(SwipExchangeEndPoint.getSwipointCard)
    }
    
    static func exchangePoint(fromCardId: String, toCardId: String, point: Int) async -> BaseResponse<ExchangeModel>? {
        return await NetworkManager.shared.request(SwipExchangeEndPoint.exchangePoint(fromCardId: fromCardId, toCardId: toCardId, point: point))
    }
}
