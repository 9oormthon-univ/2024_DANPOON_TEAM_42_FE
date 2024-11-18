//
//  SwipointMainView.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/19/24.
//

import SwiftUI

struct SwipointView: View {
    
    @StateObject var viewModel = SwipointViewModel()
    
    var body: some View {
        
        @State var barBtn: Bool = false
        ZStack{
            VStack(spacing: 0){
                ImageBtnNavigationBar(title: "스위포인트", imageType: "question_circle_mark", showBackButton: true, barBtn: $barBtn)
                
                SwipointMainView(viewModel: viewModel)
                
                Spacer()
            }
            .sheet(isPresented: $barBtn, content: {
                
            })
        }
    }
}

struct SwipointMainView: View {
    @ObservedObject var viewModel: SwipointViewModel
    @State private var selectedCardIndex: Int = 0 // 현재 선택된 카드 인덱스
    
    var body: some View {
        ZStack{
            VStack{
                RoundedRectangle(cornerRadius: 6)
                    .frame(width: Constants.screenWidth, height: 562 * Constants.ControlHeight)
                    .foregroundColor(.greyDarkHover)
                    .edgesIgnoringSafeArea(.leading)
                    .edgesIgnoringSafeArea(.trailing)
                    .overlay(content: {
                        VStack(spacing: 0){
                            // Scrollable Card View
                            ScrollView(.horizontal, showsIndicators: false) {
                                ScrollViewReader { proxy in
                                    HStack(spacing: 10) {
                                        
                                        Spacer()
                                            .padding(.trailing, 56 * Constants.ControlWidth)
                                        
                                        ForEach(viewModel.state.getSwipointCardResponse.indices, id: \.self) { index in
                                            SwipointCardView(region: viewModel.state.getSwipointCardResponse[index].region, point: viewModel.state.getSwipointCardResponse[index].point, cardImage: viewModel.state.getSwipointCardResponse[index].cardImage)
                                                .onTapGesture {
                                                    withAnimation(.easeInOut) {
                                                        selectedCardIndex = index
                                                        proxy.scrollTo(index, anchor: .center)
                                                    }
                                                }
                                                .id(index)
                                        }
                                        
                                        Spacer()
                                            .padding(.leading, 56 * Constants.ControlWidth)
                                    }
                                }
                            }
                            .padding(.bottom, 10 * Constants.ControlHeight)
                            
                            HStack(spacing: 6){
                                RoundedRectangle(cornerRadius: 6)
                                    .frame(width: 114.5 * Constants.ControlWidth, height: 40 * Constants.ControlHeight)
                                    .foregroundColor(.greyNormalHover)
                                    .overlay {
                                        Text("포인트 이동")
                                            .font(.Body1)
                                            .foregroundColor(.white)
                                    }
                                
                                RoundedRectangle(cornerRadius: 6)
                                    .frame(width: 114.5 * Constants.ControlWidth, height: 40 * Constants.ControlHeight)
                                    .foregroundColor(.greyNormalHover)
                                    .overlay {
                                        Text("사용 내역")
                                            .font(.Body1)
                                            .foregroundColor(.white)
                                    }
                            }
                        }
                    })
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: 360 * Constants.ControlWidth, height: 54 * Constants.ControlHeight)
                    .foregroundColor(.mainNormal)
                    .overlay {
                        Text("새로운 카드 등록")
                            .font(.Subhead3)
                            .foregroundColor(.white)
                    }
            }
            .padding(.top, 30 * Constants.ControlHeight)
        }
    }
}

struct SwipointCardView: View {
    
    var region: String
    var point: String
    var cardImage: String
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                Text("\(region) 스위포인트")
                    .font(.Headline)
                    .foregroundColor(.white)
                
                Text("\(point)원 사용 가능")
                    .font(.Subhead3)
                    .foregroundColor(.mainLightHover)
                    .padding(.bottom)
                
                Image("swipay_card_ex1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 242 * Constants.ControlWidth, height: 386 * Constants.ControlHeight)
            }
        }
    }
}

#Preview {
    SwipointView()
}
