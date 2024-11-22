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
        var getKakaoLoginResponse = LoginModel(userId: 0, accessToken: "", refreshToken: "", providerId: "", profileImage: "")
        
        //애플 로그인
        var getAppleLoginResponse = LoginModel(userId: 0, accessToken: "", refreshToken: "", providerId: "", profileImage: "")
    }
    
    enum Action {
        case getKakaoLogin(token: String)
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
        case let .getKakaoLogin(token):
            if let response = await AuthService.getKakaoLogin(token: token) {
                print("로그인 response: \(response)")
                await MainActor.run {
                    print("\(response.code)")
                    
                    if response.code == 200, let responseData = response.data {
                        state.getKakaoLoginResponse = responseData
                        
                        // Keychain 저장
                        saveUserDefaultsData(responseData: responseData, provider: "KAKAO")
                        AppState.shared.navigationPath.append(loginType.main)
                    } else if response.code == 418 {
                        AppState.shared.navigationPath.append(loginType.term(type: "kakao"))
                    } else {
                        print("Unhandled Status Code: \(response.code)")
                    }
                }
            } else {
                print("Error")
            }
            
        case let .getAppleLogin(token):
            if let response = await AuthService.getAppleLogin(token: token) {
                
                print("애플 로그인 response: \(response)")
                await MainActor.run {
                    print("\(response.code)")
                    
                    if response.code == 200, let responseData = response.data {
                        
                        state.getAppleLoginResponse = responseData
                        
                        
                        // Keychain 저장
                        saveUserDefaultsData(responseData: responseData, provider: "APPLE")
                        AppState.shared.navigationPath.append(loginType.main)
                    } else if response.code == 418 {
                        AppState.shared.navigationPath.append(loginType.term(type: "apple"))
                    } else {
                        print("Unhandled Status Code: \(response.code)")
                    }
                }
            } else {
                print("Error")
            }
        }
    }
    
    func saveUserDefaultsData(responseData: LoginModel, provider: String) {
        let defaults = UserDefaults.standard
        
        if  defaults.string(forKey: "userId") == nil{
            // 데이터를 UserDefaults에 저장
            defaults.set(responseData.userId, forKey: "userId")
            defaults.set(responseData.profileImage, forKey: "profileImage")
            
            KeyChainManager.addItem(key: "providerId", value: responseData.providerId ?? "")
            KeyChainManager.addItem(key: "provider", value: provider)
            
            KeyChainManager.addItem(key: "accessToken", value: responseData.accessToken ?? "")
            KeyChainManager.addItem(key: "refreshToken", value: responseData.refreshToken ?? "")
            defaults.synchronize()
        } else {
            defaults.set(responseData.userId, forKey: "userId")
            defaults.set(responseData.profileImage, forKey: "profileImage")
            KeyChainManager.updateItem(key: "providerId", value: responseData.providerId ?? "")
            KeyChainManager.updateItem(key: "provider", value: provider)
            KeyChainManager.updateItem(key: "accessToken", value: responseData.accessToken ?? "")
            KeyChainManager.updateItem(key: "refreshToken", value: responseData.refreshToken ?? "")
            
            // 동기화 (선택 사항, 즉시 저장을 보장하려면 사용)
            defaults.synchronize()
        }
    }
    
}

