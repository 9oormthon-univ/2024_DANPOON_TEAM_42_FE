//
//  CategoryCurationView.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/21/24.
//

import SwiftUI

struct CategoryCurationView: View {
    @StateObject var viewModel = CategoryViewModel()
    @State private var currentIndex: Int = 0

    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .frame(width: 360 * Constants.ControlWidth,
                   height: 394 * Constants.ControlHeight)
            .scaledToFit()
            .foregroundColor(.greyDarkHover)
            .overlay {
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text("SWEEP만의 컨셉 큐레이션! 📝")
                            .font(.Body2)
                            .foregroundColor(.greyLighter)

                        Spacer()

                        Image("swipay_chevron_right_greyLighterHover")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24)
                            .overlay {
                                VStack(spacing: 0) {
                                    HStack(spacing: 0) {
                                        Spacer()

                                        Circle()
                                            .frame(width: 6)
                                            .scaledToFit()
                                            .foregroundColor(.danger)
                                    }

                                    Spacer()
                                }
                            }
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 20)

                    TabView(selection: $currentIndex) {
                        ForEach(viewModel.state.sampleCuration, id: \.title) { curation in
                            CurationItem(title: curation.title,
                                         imageName: curation.imageName,
                                         content: curation.content)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

                    HStack(spacing: 6) {
                        ForEach(viewModel.state.sampleCuration.indices, id: \.self) { index in
                            Circle()
                                .fill(index == currentIndex ? Color.white : Color.gray)
                                .frame(width: 6 * Constants.ControlWidth, height: 6 * Constants.ControlHeight)
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
    }
}

#Preview {
    CategoryCurationView()
}

struct CurationItem: View {
    
    var title: String
    var imageName: String
    var content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(title)
                .font(.Headline)
                .foregroundColor(.white)
                .lineSpacing(4)

            Image(imageName)
                .resizable()
                .frame(width: 324 * Constants.ControlWidth,
                       height: 140 * Constants.ControlHeight)
            
            Text(content)
                .font(.Subhead2)
                .foregroundColor(.white)
                .lineLimit(3)
                .overlay {
                    VStack {
                        Spacer()

                        Image("shadow")
                            .resizable()
                            .frame(width: 324 * Constants.ControlWidth,
                                   height: 76 * Constants.ControlHeight)
                    }
                }
        }
        .frame(width: 324 * Constants.ControlWidth,
               height: 308 * Constants.ControlHeight)
        .background(
            RoundedRectangle(cornerRadius: 0)
                .fill(.greyDarkHover)
        )
    }
}

#Preview {
    CurationItem(title: "반복되는 데이트가 질린다면?\n신원시장의 MZ저격 데이트 코스 💛",
                 imageName: "sample5",
                 content: "메리네 정원에서 시작하는 분식 데이트 🍙\n신원시장의 인기 분식집인 '메리네 정원'에서 김밥과 튀김으로 가볍게 시작해보세요. 특히 계란 김밥과 바삭한 튀김이 유명하니 꼭 맛보시길 추천합니다.")
}
