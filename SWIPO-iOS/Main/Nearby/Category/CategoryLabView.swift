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
//                Text("스윕 Lab에 오신걸 환영해요!")
//                    .font(.Body2)
//                    .foregroundStyle(.white)
//                    .padding(.bottom, 10)
//                Text("윤다희님의 3km 반경을\n분석해 볼까요?")
//                    .font(.Display1)
//                    .foregroundStyle(.white)
//                    .padding(.bottom, 15)
//                Image("lab")
//                    .resizable()
//                    .frame(width: 132 * Constants.ControlWidth,
//                           height: 106 * Constants.ControlHeight)
//                    .padding(.bottom, 5)
//                Text("울산 남구 무거동")
//                    .font(.Body2)
//                    .foregroundStyle(.white)
//                    .padding(.bottom, 30)
//                
//                VStack(spacing: 14) {
//                    ForEach(viewModel.state.labType, id: \.title) { type in
//                        CategoryLabItemView(title: type.title, content: type.content)
//                    }
//                }
//                .padding(.bottom, 30)
                
                VStack(alignment: .leading) {
                    Text("울산 남구 무거동")
                        .font(.Body2)
                        .foregroundStyle(.greyLightHover)
                        .padding(.bottom, 1)

                    Text("윤다희님의 취향과 찰떡궁합이네요!! 🎉")
                        .font(.Headline)
                        .foregroundStyle(.white)
                        .padding(.bottom, 9)
                        .tracking(-0.6)

                    Text("내 취향이 가득한 이곳 애정을 가져봐도 되겠어요! 마음에 드는 매장은 관심등록으로 보관해봐요 🥰 관련있는 추천을 더 받고 싶으시다면 맞춤 가맹점들을 자주 방문해 보시는게 어떨까요?")
                        .font(.Subhead3)
                        .foregroundStyle(.greyLighter)
                        .lineSpacing(4)
                        .tracking(-0.6)
                }
                .padding(.horizontal, 20 * Constants.ControlWidth)
                .frame(width: 360 * Constants.ControlWidth,
                       height: 205 * Constants.ControlHeight)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(.greyDark)
                )
                .padding(.bottom, 30 * Constants.ControlHeight)

                VStack(alignment: .leading) {
                    Text("윤다희님과 잘 맞는 국내 핫플은?")
                        .font(.Headline)
                        .foregroundStyle(.white)
                        .tracking(-0.6)
                        .frame(height: 32 * Constants.ControlHeight)

                    Text("여행을 계획 중이시면 이곳 어떨까요?")
                        .font(.Body2)
                        .foregroundStyle(.greyLightHover)
                        .tracking(-0.6)
                        .padding(.bottom, 21 * Constants.ControlHeight)

                    HStack {
                        Spacer()
                        
                        VStack(alignment: .center) {
                            Image("lab_location")
                                .resizable()
                                .frame(width: 79 * Constants.ControlWidth,
                                       height: 76 * Constants.ControlHeight)
                                .padding(.bottom, 11 * Constants.ControlHeight)
                            
                            Text("신원시장")
                                .font(.Headline)
                                .foregroundStyle(.white)
                                .tracking(-0.6)
                                .frame(height: 32 * Constants.ControlHeight)

                            Text("서울 관악구 신림동 1587-39")
                                .font(.Body2)
                                .foregroundStyle(.greyLightHover)
                                .tracking(-0.6)
                                .frame(height: 24 * Constants.ControlHeight)
                        }
                        .frame(height: 145 * Constants.ControlHeight)

                        Spacer()
                    }

                    Spacer()

                    Text("평소에 시장 맛집을 좋아하는군요! 신원시장은 어떨까요? 신원시장은 서울 은평구에 위치한 곳으로, 전통 시장의 정겨운 분위기와 트렌디한 먹거리들이 조화롭게 어우러져 있는 곳이에요 주말 오전에 방문하면 더 신선한 재료와 음식을 즐길 수 있어요☺️ 시장 탐방 후 주변 은평 한옥마을이나 북한산 둘레길로 이어지는 나들이도 추천드려요!")
                        .font(.Body2)
                        .foregroundStyle(.greyLighter)
                        .lineSpacing(3)
                        .lineLimit(7)
                        .tracking(-0.6)
                }
                .padding(20)
                .frame(width: 360 * Constants.ControlWidth,
                       height: 453 * Constants.ControlHeight)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(.greyDark)
                )
                .padding(.bottom, 44 * Constants.ControlHeight)
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
