//
//  CategoryRankingView.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/21/24.
//

import SwiftUI

struct CategoryRankingView: View {
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
                    .frame(width: 146 * Constants.ControlWidth,
                           height: 144 * Constants.ControlHeight)
                    .cornerRadius(12)
                    .clipped()
                    .overlay {
                        if !isTaste {
                            VStack {
                                HStack {
                                    Image(rankingImageArr[rankingImageIndex])
                                        .resizable()
                                        .frame(width: 45 * Constants.ControlWidth,
                                               height: 45 * Constants.ControlHeight)
                                    
                                    Spacer()
                                    
                                    RoundedRectangle(cornerRadius: 6)
                                        .frame(width: 72 * Constants.ControlWidth,
                                               height: 24 * Constants.ControlHeight)
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
                                            Text("엄재웅님 PICK!")
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
                            .frame(width: 18 * Constants.ControlWidth,
                                   height: 18 * Constants.ControlHeight)
                        
                        Text(store.address)
                            .font(.Caption)
                            .foregroundColor(.white)
                            .lineLimit(1)
                    }
                }
            }
        }
        .frame(width: 146 * Constants.ControlWidth,
               height: 190 * Constants.ControlHeight)
    }
}

struct CategoryRankingListView: View {
    @StateObject var viewModel = StoreViewModel()
    @ObservedObject var mapViewModel: MapViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 14) {
                ForEach(Array(viewModel.state.sampleStoresRanking.enumerated()), id: \.element.name) { index, card in
                    CategoryRankingView(store: card, rankingImageIndex: index, isTaste: false)
                }
            }
        }
    }
}

