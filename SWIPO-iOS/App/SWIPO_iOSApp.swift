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

@main
struct SWIPO_iOSApp: App {
    @StateObject var appState = AppState.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    init() {
        KakaoSDK.initSDK(appKey: Secrets.kakaoLoginNativeTestAppKey)
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appState.navigationPath) {
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
