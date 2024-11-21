//
//  JoinService.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/22/24.
//

import Foundation
struct JoinService {
    //전화번호 인증
    static func getPhoneChk(phone: String) async -> BaseResponse<EmptyResponseModel>? {
        return await NetworkManager.shared.request(JoinEndPoint.getPhoneChk(phone: phone))
    }
    
    //전화번호 인증번호 확인
    static func getVerificationChk(phone: String, code: String) async -> BaseResponse<EmptyResponseModel>? {
        return await NetworkManager.shared.request(JoinEndPoint.getVerificationChk(phone: phone, code: code))
    }
    
    //회원 가입
    static func getJoin(provider: String, providerId: String, name: String, address: String, birth: String, telecom: String, phone: String, isMarket: Bool, pwd: String) async -> BaseResponse<JoinModel>? {
        return await NetworkManager.shared.request(JoinEndPoint.getJoin(provider: provider, providerId: providerId, name: name, address: address, birth: birth, telecom: telecom, phone: phone, isMarket: isMarket, pwd: pwd))
    }
}
