//
//  CategoryTitleView.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/21/24.
//

import SwiftUI

struct CategoryTitleView: View {
    let title: String
    let content: String

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.Headline)

                Spacer()

                Button(action: {

                }, label: {
                    
                    Image("right")
                        .resizable()
                        .frame(width: 32 * Constants.ControlWidth, height: 32 * Constants.ControlHeight)
                        .foregroundColor(.white)
                })
            }
            Text(content)
                .font(.Body2)
        }
    }
}

#Preview {
    CategoryTitleView(title: "관심등록 가맹점 💛",
                 content: "엄재웅님의 관심 가맹점들 가보고 싶어지네요!")
}
