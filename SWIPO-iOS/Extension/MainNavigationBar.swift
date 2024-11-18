//
//  NavigationBar.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/18/24.
//

import SwiftUI

struct MainNavigationBar: View {
    
    var body: some View {
        ZStack{
            HStack {
                Image("main_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 116 * Constants.ControlWidth, height: 36 * Constants.ControlHeight)
                    .padding()
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    Image("main_mypage_button")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24 * Constants.ControlWidth)
                })
                .padding()
                
            }
            .frame(height: 58 * Constants.ControlHeight)
            
    
        }
    }
}

#Preview {
    MainNavigationBar()
}
