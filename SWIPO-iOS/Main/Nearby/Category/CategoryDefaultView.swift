//
//  CategoryDefaultView.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/21/24.
//

import SwiftUI
import Kingfisher

struct CategoryDefaultListView: View {
    @StateObject var viewModel = StoreViewModel()
    @ObservedObject var mapViewModel: MapViewModel
    @Binding var tabIndex: Int

    var body: some View {

        if tabIndex == 0 || tabIndex == 1 {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(mapViewModel.state.getStoreTabResponse.picks, id: \.name) { store in
                        CategoryDefaultView(mapViewModel: mapViewModel, store: store, isTaste: false)
                    }
                    .padding(.horizontal, 14)
                }
            }
        } else if tabIndex == 2 {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(mapViewModel.state.getStoreTabResponse.trends, id: \.name) { card in
                        CategoryDefaultView(mapViewModel: mapViewModel, store: card, isTaste: false)
                    }
                    .padding(.horizontal, 14)
                }
            }
        }
    }
}

struct CategoryDefaultView: View {
    @ObservedObject var mapViewModel: MapViewModel
    var store: StoreTab
    var isTaste: Bool

    var body: some View {
        ZStack {
            VStack {
                KFImage(URL(string: store.imageUrl ?? ""))
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
                                        
                                        Text(store.reviewComment ?? "")
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
                                Text("Point \(store.percent)%")
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
                                Text("Point \(store.percent)%")
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
        }
        .frame(width: 250, height: 200)
    }
}

