//
//  LoginView.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/18/24.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices

struct LoginView: View {
    
    @ObservedObject var authManager = AuthManager()
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack(spacing: 0){
                    Image("login_background")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 393 * Constants.ControlWidth, height: 641 * Constants.ControlHeight)
                    
                    Spacer()
                }
                .edgesIgnoringSafeArea(.top)
                
                VStack(spacing: 15){
                    Image("login_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 212 * Constants.ControlWidth, height: 67 * Constants.ControlHeight)
                    Text("지역 상생 가맹점을 즐겁게!")
                        .font(.Subhead3)
                        .tracking(-0.6)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.top, 174 * Constants.ControlHeight)
                
                VStack(spacing: 0) {
                    
                    Spacer()
                    
                    Text("5초만에 빠른 회원가입🔥")
                        .font(.Subhead2)
                        .foregroundColor(Color(hex: "4F4FFD"))
                        .padding(.bottom, 10)
                        .padding(.leading, 3)
                        .background(){
                            Image("login_cloud")
                                .resizable()
                                .frame(width: 200 * Constants.ControlWidth, height: 80 * Constants.ControlHeight)
                                .scaledToFit()
                        }
                }
                .padding(.bottom, 249 * Constants.ControlHeight)
                .zIndex(1)
                
                VStack(spacing: 14){
                    
                    Spacer()
                    
                    Button(action: {
                        authManager.kakaoLogin()
                    }, label: {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: 360 * Constants.ControlWidth, height: 54 * Constants.ControlHeight)
                            .foregroundColor(Color(hex: "FEE500"))
                            .scaledToFit()
                            .overlay {
                                HStack(spacing: 10) {
                                    Image("kakao_logo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 18 * Constants.ControlWidth, height: 18 * Constants.ControlHeight)
                                    
                                    Text("카카오로 시작하기")
                                        .font(.Subhead3)
                                        .foregroundColor(Color(hex: "171717"))
                                }
                            }
                    })
                    .onChange(of: authManager.kakaoAccessToken) { token in
                        // 액세스 토큰이 업데이트되었을 때 Task 실행
                        if let token = token {
                            Task {
                                await kakaoLogin(token: token)
                            }
                        }
                    }
                    
                    // Apple 로그인 버튼 사용
                    SignInWithAppleButton(
                        onRequest: { request in
                            request.requestedScopes = [.fullName, .email]
                        },
                        onCompletion: { result in
                            switch result {
                            case .success(let authResults):
                                print("Apple Login Successful")
                                switch authResults.credential{
                                case let appleIDCredential as ASAuthorizationAppleIDCredential:
                                    // 계정 정보 가져오기
                                    let IdentityToken = String(data: appleIDCredential.identityToken!, encoding: .utf8)
                                    Task{
                                        await appleLogin(token: IdentityToken ?? "")
                                    }
                                    
                                default:
                                    break
                                }
                            case .failure(let error):
                                print(error.localizedDescription)
                                print("error")
                            }
                        }
                    )
                    .signInWithAppleButtonStyle(.black) // 버튼 스타일 설정
                    .frame(width: 360 * Constants.ControlWidth, height: 54 * Constants.ControlHeight)
                    .cornerRadius(16)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: 360 * Constants.ControlWidth, height: 54 * Constants.ControlHeight)
                            .foregroundColor(Color(hex: "333333"))
                            .scaledToFit()
                            .overlay {
                                HStack(spacing: 10) {
                                    Image("apple_logo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 18 * Constants.ControlWidth, height: 18 * Constants.ControlHeight)
                                    
                                    Text("애플로 시작하기")
                                        .font(.Subhead3)
                                        .foregroundColor(Color.white)
                                }
                            }
                            .allowsHitTesting(false)
                    }
                    
                    Button(action: {
                        AppState.shared.navigationPath.append(loginType.term)
                    }, label: {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: 360 * Constants.ControlWidth, height: 54 * Constants.ControlHeight)
                            .foregroundColor(Color(hex: "4F4FFD"))
                            .scaledToFit()
                            .overlay {
                                HStack(spacing: 0) {
                                    Text("전화번호로 시작하기")
                                        .font(.Subhead3)
                                        .foregroundColor(Color.white)
                                }
                            }
                    })
                }
                .padding(.bottom, 53 * Constants.ControlHeight)
            }
            .navigationDestination(for: loginType.self) { viewType in
                switch viewType {
                case let .term:
                    TermsView()
                case let .main:
                    MainView()
                }
            }
        }
    }
    
    func kakaoLogin(token: String) async {
        await viewModel.action(.getKakaoLogin(token: token))
    }
    
    func appleLogin(token: String) async {
        await viewModel.action(.getAppleLogin(token: token))
    }
}

enum loginType: Hashable {
    case term  // 약관 동의 화면
    case main  // 메인 화면
}

#Preview {
    LoginView()
}

