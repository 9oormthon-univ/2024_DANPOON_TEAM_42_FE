//
//  LoginViewModel.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/21/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    struct State {
        //카카오 로그인
        var getKakaoLoginResponse = LoginModel(user_id: 0, accessToken: "", refreshToken: "", providerId: "", profileImage: "")
        
        //애플 로그인
        var getAppleLoginResponse = LoginModel(user_id: 0, accessToken: "", refreshToken: "", providerId: "", profileImage: "")
    }
    
    enum Action {
        case getKakaoLogin(kakaoCode: String)
        case getAppleLogin(token: String)
    }
    
    @Published var state: State
    
    init(
        state: State = .init()
    ) {
        self.state = state
    }
    
    func action(_ action: Action) async {
        switch action {
        case let .getKakaoLogin(kakaoCode):
            // 카카오 로그인 API 호출
            if let response = await LoginService.getKakaoLogin(kakaoCode: kakaoCode),
               let responseData = response.data {
                await MainActor.run {
                    print(response)
                    state.getKakaoLoginResponse = responseData
                }
            } else {
                print("Error")
            }
        case let .getAppleLogin(token):
            // 애플 로그인 API 호출
            if let response = await LoginService.getAppleLogin(token: token),
               let responseData = response.data {
                await MainActor.run {
                    print(response)
                    state.getAppleLoginResponse = responseData
                    KeyChainManager.addItem(key: "providerId", value: responseData.providerId)
                    KeyChainManager.addItem(key: "profileImage", value: responseData.profileImage)
                    KeyChainManager.addItem(key: "provider", value: "APPLE")
                }
            } else {
                print("Error")
            }
        }
    }
}
