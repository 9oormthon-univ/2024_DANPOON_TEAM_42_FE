//
//  JoinFinishView.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/21/24.
//

import SwiftUI

struct JoinFinishView: View {
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                NavigationBar(title: "", showBackButton: true)
                
                JoinFinishMainView()
                Spacer()
            }
        }
        .toolbar(.hidden)
        .navigationDestination(for: joinFinishType.self) { view in
            switch view{
            case .main:
                MainView()
            }
        }
    }
}

struct JoinFinishMainView: View {
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                
                Spacer()
                
                Image("join_finish_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 393 * Constants.ControlWidth, height: 604 * Constants.ControlHeight)
            }
            
            Image("join_finish_black")
                .resizable()
                .scaledToFit()
                .frame(width: 393 * Constants.ControlWidth, height: 720 * Constants.ControlHeight)
            
            VStack(spacing: 0){
                Text("환영해요 엄재웅님!")
                    .font(.Body2)
                    .foregroundColor(.white)
                    .padding(.bottom, 8 * Constants.ControlHeight)
                
                Text("모든 준비가 끝났어요 🎉")
                    .font(.Display2)
                    .foregroundColor(.white)
                    .padding(.bottom, 6 * Constants.ControlHeight)
                
                Text("즐거운 스위포인트 모으기 시작해 볼까요?")
                    .font(.Body2)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    AppState.shared.navigationPath.append(joinFinishType.main)
                }, label: {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 360 * Constants.ControlWidth, height: 54 * Constants.ControlHeight)
                        .scaledToFit()
                        .foregroundColor(.mainNormal)
                        .overlay {
                            Text("메인 화면으로")
                                .font(.Subhead3)
                                .foregroundColor(.white)
                        }
                })
            }
        }
    }
}

enum joinFinishType{
    case main
}

#Preview {
    JoinFinishView()
}
