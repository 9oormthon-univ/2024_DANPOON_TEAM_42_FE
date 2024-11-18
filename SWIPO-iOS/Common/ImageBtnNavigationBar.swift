//
//  ImageBtnNavigationBar.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/19/24.
//

import SwiftUI

struct ImageBtnNavigationBar: View {
    @Environment(\.dismiss) var dismiss
    
    
    let title: String
    let imageType: String
    let showBackButton: Bool
    @Binding var barBtn: Bool

    var body: some View {
        ZStack{
            HStack {
                Button(action: {
                    AppState.shared.navigationPath.removeLast()
                }, label: {
                    Image("back_btn")
                })

                Spacer()

                Text(title)
                    .font(.Headline)
                    .foregroundColor(.greyLighter)

                Spacer()

                Button(action: {
                    barBtn = true
                }, label: {
                    Image(imageType)
                        .frame(width: 38 * Constants.ControlWidth)
                })
            }
            .frame(height: 58 * Constants.ControlHeight)
        }
    }
}

#Preview {
    ImageBtnNavigationBar(title: "스위포인트", imageType: "question_circle_mark", showBackButton: true, barBtn: .constant(false))
}
