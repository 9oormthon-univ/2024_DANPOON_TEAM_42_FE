//
//  CategoryView.swift
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
                 content: "윤다희님의 관심 가맹점들 가보고 싶어지네요!")
}

#Preview {
    HorizontalCardListView()
}

struct HorizontalCardListView: View {
    @StateObject var viewModel = StoreViewModel()

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(viewModel.state.sampleStores, id: \.name) { card in
                    CardView(store: card)
                }
                .padding(.horizontal, 14)
            }
            .padding(.horizontal, 16)
        }
    }
}

struct CardView: View {
    var store: StoreModel

    var body: some View {
        ZStack {
            ForEach(store.imageName.indices, id: \.self) { index in
                VStack {
                    Image(store.imageName[0])
                        .resizable()
                        .scaledToFill()
                        .frame(width: 278, height: 190)
                        .cornerRadius(12)
                        .clipped()
                        .overlay {
                            VStack {
                                RoundedRectangle(cornerRadius: 6)
                                    .foregroundColor(.black.opacity(0.4))
                            }
                            
                            VStack {
                                Spacer()
                                
                                RoundedRectangle(cornerRadius: 6)
                                    .frame(width: .infinity, height: 60 * Constants.ControlHeight)
                                    .foregroundColor(.black.opacity(0.4))
                                    .overlay {
                                        HStack {
                                            Image("edit")
                                                .resizable()
                                                .frame(width: 24 * Constants.ControlWidth, height: 24 * Constants.ControlHeight)
                                            
                                            Text(store.review[0])
                                                .font(.Body1)
                                                .foregroundColor(.white)
                                                .lineLimit(2)

                                            Spacer()
                                        }
                                        .padding(10)
                                    }
                            }
                            
                        }
                }
                .tag(index)
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 6)
                        .frame(width: 72 * Constants.ControlWidth, height: 24 * Constants.ControlHeight)
                        .foregroundColor(.white)
                        .overlay (
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.mainLightActive, lineWidth: 1))
                        .overlay {
                            Text("Point \(store.point)%")
                                .foregroundColor(.mainNormal)
                                .font(.Subhead2)
                        }
                }
                .padding(.top, 18)
                .padding(.trailing, 10)
                
                Spacer()
            }
            
            VStack(spacing: 6) {
                Text(store.name)
                    .font(.Subhead3)
                    .foregroundColor(.white)
                    .lineLimit(1)

                HStack(spacing: 2){
                    Image("location2")
                        .resizable()
                        .frame(width: 18 * Constants.ControlWidth, height: 18 * Constants.ControlHeight)

                    Text(store.address)
                        .font(.Body1)
                        .foregroundColor(.white)
                        .lineLimit(1)
                }
            }
            .padding(.bottom, 7)
            .cornerRadius(12)
        }
        .frame(width: 250, height: 200)
        .foregroundColor(.white)
        .shadow(radius: 4)
    }
}
