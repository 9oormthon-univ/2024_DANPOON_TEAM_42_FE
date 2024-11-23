//
//  StoreService.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/23/24.
//

import Foundation

struct StoreService {
    
    // 지도 조회
    static func getStoreMap(request: StoreMapRequest) async -> BaseResponse<StoreMapResponse>? {
        return await NetworkManager.shared.request(StoreEndPoint.getStoreMap)
    }
    
    // 지도 가게 상세보기
    static func getStoreDetail(storeId: Int) async -> BaseResponse<StoreDetailResponse>? {
        return await NetworkManager.shared.request(StoreEndPoint.getStoreDetail(storeId: storeId))
    }
    
    // 지도 하단 탭 조회
    static func getStoreTab() async -> BaseResponse<StoreTabResponse>? {
        return await NetworkManager.shared.request(StoreEndPoint.getStoreTab)
    }
    
    // 동네 가맹점 검색
    static func getStoreSearch(request: StoreSearchRequest) async -> BaseResponse<StoreSearchResponse>? {
        return await NetworkManager.shared.request(StoreEndPoint.getStoreSearch(request: request))
    }
    
    // 관심 등록
    static func postStoreWish(request: StoreWishRequest) async -> BaseResponse<EmptyResponseModel>? {
        return await NetworkManager.shared.request(StoreEndPoint.postStoreWish(request: request))
    }

    // 리뷰 등록
    static func postStoreReview(request: StoreReviewRequest) async -> BaseResponse<EmptyResponseModel>? {
        return await NetworkManager.shared.request(StoreEndPoint.postStoreReview(request: request))
    }
}
