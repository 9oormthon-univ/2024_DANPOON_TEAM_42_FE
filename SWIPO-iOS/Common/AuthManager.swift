//
//  AuthManager.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/18/24.
//

import Foundation
import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices
import Alamofire

final class AuthManager: NSObject, ObservableObject{
    @Published var kakaoSuccess: Bool = false // 로그인 성공 여부를 나타내는 변수
    
    //카카오톡 로그인
    func kakaoLogin(){
        // 카카오톡 실행 가능 여부 확인
        if UserApi.isKakaoTalkLoginAvailable() {
           // 카카오톡 로그인
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    print(error)
                    self.kakaoSuccess = false // 로그인 실패 시 false로 설정
                } else {
                   print("카카오톡 로그인 success")
                    
                   // 추가작업
                   _ = oauthToken
                    print("\(oauthToken!.accessToken)")
                    self.kakaoSuccess = true // 로그인 성공 시 true로 설정
                }
             }
         } else {
            // 카카오계정 로그인
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    print(error)
                    self.kakaoSuccess = false // 로그인 실패 시 false로 설정
                } else {
                    print("카카오계정 로그인 success")

                    // 추가작업
                   _ = oauthToken
                    print("\(oauthToken!.accessToken)")
                    self.kakaoSuccess = true // 로그인 성공 시 true로 설정
                }
            }
        }
    }
}

