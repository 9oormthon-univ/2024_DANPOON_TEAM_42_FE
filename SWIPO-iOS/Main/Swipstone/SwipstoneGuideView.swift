//
//  SwipstoneGuideView.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/19/24.
//

import SwiftUI

struct SwipstoneGuideView: View {
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                NavigationBar(title: "스윕스톤 도감", showBackButton: true)
                
                SwipstoneGuideGridView()
                
                Spacer()
                
            }
        }
        .toolbar(.hidden)
    }
}

struct RegionInfo: Codable{
    var id: Int64
    var region: String
    var slogan: String
    var imageName: String
    var unselectedImageName: String
}

struct SwipstoneGuideGridView: View {
    
    var layout: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    @StateObject var viewModel = SwipstoneViewModel()
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                ScrollView{
                    LazyVGrid(columns: layout, content: {
                        ForEach(viewModel.state.regionInfo, id: \.id) { index in
                            SwipstoneItemView(region: index.region,
                                              slogan: index.slogan,
                                              imageName: index.imageName)
                        }
                        .padding(.bottom, 10 * Constants.ControlHeight)
                    })
                    .padding(.leading, 10 * Constants.ControlWidth)
                    .padding(.trailing, 10 * Constants.ControlWidth)
                }
                .scrollIndicators(.hidden)
            }
            .padding(.top, 24 * Constants.ControlHeight)
        }
    }
}

struct SwipstoneItemView: View {
    
    var region: String
    var slogan: String
    var imageName: String
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 173 * Constants.ControlWidth, height: 187.02 * Constants.ControlHeight)
                .foregroundColor(.greyDarkHover)
                .overlay {
                    VStack(spacing: 0){
                        Text(region)
                            .font(.Body2)
                            .foregroundColor(.white)
                        
                        Text(slogan)
                            .font(.Body1)
                            .foregroundColor(.greyLightHover)
                        
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 99.02 * Constants.ControlWidth, height: 99.02 * Constants.ControlHeight)
                    }
                }
        }
    }
}

#Preview {
    SwipstoneGuideView()
}
