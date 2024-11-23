//
//  SWIPO_iOSApp.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/18/24.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoMapsSDK
import Lottie

@main
struct SWIPO_iOSApp: App {
    @StateObject var appState = AppState.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var isAnimationCompleted = false
    
    init() {
        KakaoSDK.initSDK(appKey: Secrets.kakaoLoginNativeTestAppKey)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appState.navigationPath) {
                if isAnimationCompleted {
                    // 다음 화면으로 전환
                    if let userId = UserDefaults.standard.string(forKey: "userId") {
                        MainView()
                            .onOpenURL(perform: { url in
                                if AuthApi.isKakaoTalkLoginUrl(url) {
                                    AuthController.handleOpenUrl(url: url)
                                }
                            })
                    } else {
                        LoginView()
                            .onOpenURL(perform: { url in
                                if AuthApi.isKakaoTalkLoginUrl(url) {
                                    AuthController.handleOpenUrl(url: url)
                                }
                            })
                    }
                } else {
//                    // LottieView 표시
                    LottieView(jsonName: "splashsplash", onAnimationCompleted: {
                        // 애니메이션 완료 시 상태 변경
                        isAnimationCompleted = true
                    })
                    .ignoresSafeArea() // 전체 화면 표시 (옵션)
                }
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let kakaoAppKey = Bundle.main.object(forInfoDictionaryKey: "KAKAO_APP_KEY") as? String {
            SDKInitializer.InitSDK(appKey: kakaoAppKey)
        } else {
            fatalError("Kakao App Key is missing in Info.plist")
        }
        return true
    }
}
