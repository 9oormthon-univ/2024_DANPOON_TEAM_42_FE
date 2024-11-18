//
//  SWIPO_iOSApp.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/18/24.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct SWIPO_iOSApp: App {
    @StateObject var appState = AppState.shared
    
    init() {
        KakaoSDK.initSDK(appKey: Secrets.kakaoLoginNativeTestAppKey)
        }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appState.navigationPath) {
                LoginView()
                    .onOpenURL(perform: { url in
                        if AuthApi.isKakaoTalkLoginUrl(url) {
                            AuthController.handleOpenUrl(url: url)
                        }
                    })
            }
        }
    }
}
