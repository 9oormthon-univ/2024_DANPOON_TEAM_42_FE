//
//  MainView.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/18/24.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab: Tab = .nearby // 초기 탭을 설정 (예: 스위페이)
    @StateObject var swipayViewModel = SwipayViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            MainNavigationBar(selectedTab: $selectedTab)
            
            // 커스텀 탭 바
            HStack {
                TabButton(title: "내 주변", isSelected: selectedTab == .nearby) {
                    selectedTab = .nearby
                }
                
                TabButton(title: "스위페이", isSelected: selectedTab == .swipPay) {
                    selectedTab = .swipPay
                }
                
                TabButton(title: "스윕스톤", isSelected: selectedTab == .swipStone) {
                    selectedTab = .swipStone
                }
                
                TabButton(title: "", isSelected: false) {
                }
                
                TabButton(title: "", isSelected: false) {
                }
            }
            .padding(.top, 10 * Constants.ControlHeight)
            .padding(.leading)
            .background(Color.black)
            
            Spacer()
            
            // 선택된 탭에 따른 콘텐츠
            TabContentView(selectedTab: selectedTab)
                .padding(.top, selectedTab != .nearby ? 13 * Constants.ControlHeight : 0)

            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
        .toolbar(.hidden)
        .onAppear(){
            let token = KeyChainManager.readItem(key: "accessToken")
            print("token: \(token)")
        }
        .onChange(of: selectedTab) { newValue in
            if newValue == .swipPay {
                Task {
                    await swipayViewModel.action(.getSwipay)
                }
            }
        }
        .onAppear(){
            Task {
                await swipayViewModel.action(.getSwipay)
            }
        }
    }
}

// 탭 바의 각 버튼 뷰
struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                VStack(spacing: 0){
                    
                    if title == "스위페이"{
                        HStack(spacing: 0){
                            Spacer()
                            
                            Circle()
                                .scaledToFit()
                                .frame(width: 6)
                                .foregroundColor(.danger)
                            
                        }
                    } else {
                        HStack(spacing: 0){
                            Spacer()
                            
                            Circle()
                                .scaledToFit()
                                .frame(width: 6)
                                .foregroundColor(.clear)
                            
                        }
                    }
                    
                    Text(title)
                        .font(isSelected ? .Subhead3 : .Body2)
                        .foregroundColor(isSelected ? .white : .greyLighter)
                }
                
                if isSelected {
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.white)
                } else {
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.clear)
                }
            }
        }
    }
}

// 선택된 탭에 따른 콘텐츠 뷰
struct TabContentView: View {
    let selectedTab: Tab
    
    var body: some View {
        switch selectedTab {
        case .nearby:
            NearbyView()
            
        case .swipPay:
            SwipayView()
            
        case .swipStone:
            SwipstoneView()
        }
    }
}

// 탭을 정의한 열거형
enum Tab {
    case nearby
    case swipPay
    case swipStone
}


#Preview {
    MainView()
}
