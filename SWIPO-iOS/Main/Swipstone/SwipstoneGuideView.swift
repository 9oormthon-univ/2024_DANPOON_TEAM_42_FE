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
}

struct SwipstoneGuideGridView: View {
    
    var layout: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    var regionInfo: [RegionInfo] = [RegionInfo(id: 1, region: "서울", slogan: "I·SEOUL·U", imageName: "seoul"),
                                    RegionInfo(id: 2, region: "경남", slogan: "경남, 새로운 미래로", imageName: "gyeongnam"),
                                    RegionInfo(id: 3, region: "경기", slogan: "공정, 평화, 번영의 경기도", imageName: "gyeonggi"),
                                    RegionInfo(id: 4, region: "인천", slogan: "All Ways Incheon", imageName: "incheon"),
                                    RegionInfo(id: 5, region: "강원", slogan: "강원, 웰니스", imageName: "gangwon"),
                                    RegionInfo(id: 6, region: "충남", slogan: "힘쎈 충남", imageName: "chungcheongnam"),
                                    RegionInfo(id: 7, region: "대전", slogan: "대전은 과학입니다", imageName: "daejeon"),
                                    RegionInfo(id: 8, region: "충북", slogan: "충북, 바이오 미래로", imageName: "chungcheongbuk"),
                                    RegionInfo(id: 9, region: "세종", slogan: "세종, 스마트 행복도시", imageName: "sejong"),
                                    RegionInfo(id: 10, region: "부산", slogan: "Dynamic Busan", imageName: "busan"),
                                    RegionInfo(id: 11, region: "울산", slogan: "울산, 친환경 미래도시", imageName: "ulsan"),
                                    RegionInfo(id: 12, region: "대구", slogan: "Colorful Daegu", imageName: "daegu"),
                                    RegionInfo(id: 13, region: "경북", slogan: "새바람 행복경북", imageName: "gyeongsangbuk"),
                                    RegionInfo(id: 14, region: "전남", slogan: "청정 전남 블루 이코노미", imageName: "jeollanam"),
                                    RegionInfo(id: 15, region: "광주", slogan: "정의로운 도시, 광주", imageName: "gwanju"),
                                    RegionInfo(id: 16, region: "전북", slogan: "천년 전북, 새로운 도약", imageName: "jeollabuk"),
                                    RegionInfo(id: 76, region: "제주", slogan: "제주, 지속 가능한 미래", imageName: "jeju")]
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                ScrollView{
                    LazyVGrid(columns: layout, content: {
                        ForEach(regionInfo, id: \.id) { index in
                            SwipstoneItemView(region: index.region, slogan: index.slogan, imageName: index.imageName)
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
