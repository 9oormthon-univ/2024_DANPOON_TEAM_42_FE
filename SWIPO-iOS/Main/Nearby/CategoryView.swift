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
    CardListView()
}

struct CardListView: View {
    @StateObject var viewModel = StoreViewModel()

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(viewModel.state.sampleStores, id: \.name) { card in
                    CardView(store: card, isTaste: false)
                }
                .padding(.horizontal, 14)
            }
        }
    }
}

struct CardView: View {
    var store: StoreModel
    var isTaste: Bool

    var body: some View {
        ZStack {
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
                                .frame(height: 60 * Constants.ControlHeight)
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

            if !isTaste {
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
            } else {
                VStack {
                    HStack {
                        RoundedRectangle(cornerRadius: 6)
                            .frame(width: 122 * Constants.ControlWidth, height: 24 * Constants.ControlHeight)
                            .foregroundColor(.mainNormal)
                            .overlay {
                                Text("좋아하실것 같아요!")
                                    .foregroundColor(.white)
                                    .font(.Subhead2)
                            }

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
                    .padding(.top, 15)
                    .padding(.horizontal, 10)

                    
                    Spacer()
                }
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
    }
}

struct CardRankingListView: View {
    @StateObject var viewModel = StoreViewModel()

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 14) {
                ForEach(Array(viewModel.state.sampleStoresRanking.enumerated()), id: \.element.name) { index, card in
                    CardRankingView(store: card, rankingImageIndex: index, isTaste: false)
                }
            }
        }
    }
}

struct CardRankingView: View {
    var store: StoreModel
    var rankingImageIndex: Int
    var isTaste: Bool
    let rankingImageArr = ["first", "second", "third"]

    var body: some View {
        ZStack {
            VStack {
                Image(store.imageName[0])
                    .resizable()
                    .scaledToFill()
                    .frame(width: 146 * Constants.ControlWidth, height: 144 * Constants.ControlHeight)
                    .cornerRadius(12)
                    .clipped()
                    .overlay {
                        if !isTaste {
                            VStack {
                                HStack {
                                    Image(rankingImageArr[rankingImageIndex])
                                        .resizable()
                                        .frame(width: 45 * Constants.ControlWidth, height: 45 * Constants.ControlHeight)
                                    
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
                                        .padding(.trailing, 8)
                                        .padding(.top, -8)
                                }
                                
                                Spacer()
                            }
                        } else {
                            VStack {
                                HStack {
                                    RoundedRectangle(cornerRadius: 6)
                                        .frame(width: 102 * Constants.ControlWidth,
                                               height: 24 * Constants.ControlHeight)
                                        .foregroundColor(.mainNormal)
                                        .overlay {
                                            Text("윤다희님 PICK!")
                                                .foregroundColor(.white)
                                                .font(.Subhead2)
                                        }
                                        .padding(.leading, 8)
                                        .padding(.top, 8)

                                    Spacer()
                                }

                                Spacer()
                            }
                        }
                    }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(store.name)
                        .font(.Body1)
                        .foregroundColor(.white)
                        .lineLimit(1)
                    
                    HStack(alignment: .center, spacing: 2) {
                        Image("location2")
                            .resizable()
                            .frame(width: 18 * Constants.ControlWidth, height: 18 * Constants.ControlHeight)
                        
                        Text(store.address)
                            .font(.Caption)
                            .foregroundColor(.white)
                            .lineLimit(1)
                    }
                }
            }
        }
        .frame(width: 146 * Constants.ControlWidth, height: 190 * Constants.ControlHeight)
    }
}

#Preview {
    CardRankingListView()
}

struct CardTasteListView: View {
    @StateObject var viewModel = StoreViewModel()

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 27) {
                CardRankingView(store: viewModel.state.sampleStores[0], rankingImageIndex: 0, isTaste: true)
                CardView(store: viewModel.state.sampleStores[1], isTaste: true)
                    .padding(.trailing, 30)
            }
        }
    }
}

#Preview {
    CardTasteListView()
}


