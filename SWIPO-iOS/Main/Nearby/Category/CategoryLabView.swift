//
//  CategoryLabView.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/21/24.
//

import SwiftUI

struct CategoryLabView: View {
    @StateObject var viewModel = CategoryViewModel()

    var body: some View {
            VStack(alignment: .center) {
                Text("스윕 Lab에 오신걸 환영해요!")
                    .font(.Body2)
                    .foregroundStyle(.white)
                    .padding(.bottom, 10)
                Text("윤다희님의 3km 반경을\n분석해 볼까요?")
                    .font(.Display1)
                    .foregroundStyle(.white)
                    .padding(.bottom, 15)
                Image("lab")
                    .resizable()
                    .frame(width: 132 * Constants.ControlWidth,
                           height: 106 * Constants.ControlHeight)
                    .padding(.bottom, 5)
                Text("울산 남구 무거동")
                    .font(.Body2)
                    .foregroundStyle(.white)
                    .padding(.bottom, 30)
                
                VStack(spacing: 14) {
                    ForEach(viewModel.state.labType, id: \.title) { type in
                        CategoryLabItemView(title: type.title, content: type.content)
                    }
                }
                .padding(.bottom, 30)
                
                VStack(alignment: .leading) {
                    Text("울산 남구 무거동")
                        .font(.Body2)
                        .foregroundStyle(.greyLightHover)
                        .padding(.bottom, 2)

                    Text("윤다희님의 취향과 찰떡궁합이네요!! 🎉")
                        .font(.Headline)
                        .foregroundStyle(.white)
                        .padding(.bottom, 11)

                    Text("내 취향이 가득한 이곳 애정을 가져봐도 되겠어요!\n마음에 드는 매장은 관심등록으로 보관해봐요 🥰\n관련있는 추천을 더 받고 싶으시다면\n맞춤 가맹점들을 자주 방문해 보시는게 어떨까요?")
                        .font(.Subhead3)
                        .foregroundStyle(.white)
                }
                .frame(width: 360 * Constants.ControlWidth,
                       height: 205 * Constants.ControlHeight)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(.greyDark)
                )
            }
        }
}

#Preview {
    CategoryLabView()
}

struct CategoryLabItemView: View {
    let title: String
    let content: String

    var body: some View {
        HStack(spacing: 8) {
            Text(title)
                .font(.Subhead3)
                .foregroundStyle(.white)
                .frame(width: 117 * Constants.ControlWidth, alignment: .leading)
                .padding(.leading, 8)
            Image("divider")
                .resizable()
                .frame(width: 2 * Constants.ControlWidth, height: 22 * Constants.ControlHeight)
            Text(content)
                .font(.Subhead3)
                .foregroundStyle(.white)
                .frame(width: 198 * Constants.ControlWidth, alignment: .leading)
        }
        .frame(width: 360 * Constants.ControlWidth,
               height: 46 * Constants.ControlHeight)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(.greyDark)
        )
    }
}

#Preview {
    CategoryLabItemView(title: "👍 스위포 PICK!", content: "12개의 추천을 해드렸어요!")
}
