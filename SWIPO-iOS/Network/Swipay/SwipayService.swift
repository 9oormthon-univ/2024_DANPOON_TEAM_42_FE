//
//  SwipayService.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/23/24.
//

import Foundation
struct SwipayService {
    //전화번호 인증
    static func getSwipay() async -> BaseResponse<SwipayModel>? {
        return await NetworkManager.shared.request(SwipayEndPoint.getSwipay)
    }
}

