//
//  CustomService.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/23/24.
//

import Foundation
struct CustomService {
    
    //accessToken 재발급
    static func registerCard(region: String, custom_image: [Foundation.Data?]) async -> BaseResponse<EmptyResponseModel>? {
        return await NetworkManager.shared.request(CustomEndPoint.registerCard(region: region, custom_image: custom_image))
    }

}

