//
//  NavigationBar.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/18/24.
//

import SwiftUI

struct NavigationBar: View {
    @Environment(\.dismiss) var dismiss
    
    let title: String
    let showBackButton: Bool
    
    var body: some View {
        ZStack{
            
            HStack {
                
                Button(action: {
                    AppState.shared.navigationPath.removeLast()
                }, label: {
                    Image("back_btn")
                })
                
                Spacer()
                
                Text("\(title)")
                    .font(.Headline)
                    .foregroundColor(Color(hex: "F5F4F3"))
                
                Spacer()
                
                Image("back_blank")
                    .scaledToFit()
            }
            .frame(height: 58 * Constants.ControlHeight)
            
    
        }
    }
}

#Preview {
    NavigationBar(title: "회원가입", showBackButton: true)
}
