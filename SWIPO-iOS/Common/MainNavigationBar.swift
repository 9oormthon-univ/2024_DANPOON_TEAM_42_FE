//
//  NavigationBar.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/18/24.
//

import SwiftUI

struct MainNavigationBar: View {
    
    @Binding var selectedTab: Tab
    
    var body: some View {
        ZStack{
            HStack {
                Image("main_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 116 * Constants.ControlWidth, height: 36 * Constants.ControlHeight)
                    .padding()
                
                Spacer()
                
                if selectedTab == Tab.swipStone {
                    Button(action: {
                        AppState.shared.navigationPath.append(swipstoneType.guide)
                    }, label: {
                        Image("question_circle_mark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24 * Constants.ControlWidth)
                    })
                }
                
                Button(action: {
                    
                }, label: {
                    Image("main_mypage_button")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24 * Constants.ControlWidth)
                })
                .padding(.trailing)
                .padding(.top)
                .padding(.bottom)
                
            }
            .frame(height: 58 * Constants.ControlHeight)
            
    
        }
    }
}

#Preview {
    MainNavigationBar(selectedTab: .constant(Tab.swipStone))
}
