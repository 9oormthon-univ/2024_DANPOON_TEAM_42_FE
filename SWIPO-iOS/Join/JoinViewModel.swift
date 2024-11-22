//
//  JoinViewModel.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/22/24.
//

import Foundation
class JoinViewModel: ObservableObject {
    struct State {
        var getJoinResponse = JoinModel(userId: 0, accessToken: "", refreshToken: "")
        var verification: Bool = false
    }
    
    enum Action {
        case getPhoneChk(phone: String)
        case getVerificationChk(phone: String, code: String)
        case getJoin(provider: String, providerId: String, name: String, address: String, birth: String, telecom: String, phone: String, isMarket: Bool, pwd: String)
    }
    
    @Published var state: State
    
    init(
        state: State = .init()
    ) {
        self.state = state
    }
    
    func action(_ action: Action) async {
        switch action {
        case let .getPhoneChk(phone):
            // 휴대폰 인증 API 호출
            if let response = await AuthService.getPhoneChk(phone: phone),
               let responseData = response.data {
                await MainActor.run {
                    print(response)
                }
            } else {
                print("Error")
            }
        case let .getVerificationChk(phone, code):
            // 휴대폰 인증번호 확인 API 호출
            if let response = await AuthService.getVerificationChk(phone: phone, code: code),
               let responseData = response.data {
                await MainActor.run {
                    state.verification = true
                    print(response)
                }
            } else {
                state.verification = false
                print("Error")
            }
        case let .getJoin(provider, providerId, name, address, birth, telecom, phone, isMarket, pwd):
            if let response = await AuthService.getJoin(provider: provider, providerId: providerId, name: name, address: address, birth: birth, telecom: telecom, phone: phone, isMarket: isMarket, pwd: pwd),
               let responseData = response.data {
                await MainActor.run {
                    state.getJoinResponse = responseData
                    UserDefaults.standard.set(String(responseData.userId ?? 0), forKey: "userId")
                    KeyChainManager.addItem(key: "accessToken", value: responseData.accessToken ?? "")
                    KeyChainManager.addItem(key: "refreshToken", value: responseData.refreshToken ?? "")
                    
                    print(response)
                }
            } else {
                print("Error")
            }
        }
    }
}
