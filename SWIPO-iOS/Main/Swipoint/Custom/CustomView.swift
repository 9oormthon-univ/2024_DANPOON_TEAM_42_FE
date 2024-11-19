//
//  CustomView.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/19/24.
//

import SwiftUI

struct CustomView: View {
    
    @ObservedObject var appState = AppState.shared
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                
                if appState.swipointTutorial {
                    ImageBtnNavigationBar(title: "스위포인트",
                                          imageType: "question_circle_mark_8b8b8b",
                                          showBackButton: true, blur: true)
                    
                    CustomTutorialView()
                } else {
                    ImageBtnNavigationBar(title: "스위포인트",
                                          imageType: "question_circle_mark",
                                          showBackButton: true, blur: false)
                    
                    CustomMainView()
                }
                
                Spacer()
            }
            
        }
        .toolbar(.hidden)
    }
}

struct CustomTutorialView: View {
    
    let tutorial: [String] = ["swipoint_tutorial1", "swipoint_tutorial2", "swipoint_tutorial3"]
    @State private var currentIndex: Int = 0
    @ObservedObject var appState = AppState.shared
    
    var body: some View {
        ZStack{
            if currentIndex < tutorial.count {
                Image(tutorial[currentIndex])
                    .resizable()
                    .scaledToFit()
                    .onTapGesture {
                        if currentIndex < tutorial.count - 1 {
                            // 다음 이미지로 전환
                            currentIndex += 1
                        } else {
                            // 마지막 이미지에서 투토리얼 종료
                            appState.swipointTutorial = false
                        }
                    }
            }
        }
        .animation(.easeInOut, value: currentIndex) // 전환 애니메이션
    }
}

struct CustomMainView: View {
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                
            }
        }
    }
}

#Preview {
    CustomView()
}
