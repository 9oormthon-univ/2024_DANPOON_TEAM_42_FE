//
//  SwipstoneAchiveModal.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/20/24.
//

import SwiftUI

struct SwipstoneAchiveModal: View {
    
    @Binding var point: String
    @Binding var achiveModal: Bool
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 28)
                .frame(width: 374 * Constants.ControlWidth, height: 384 * Constants.ControlHeight)
                .overlay {
                    VStack(spacing: 0){
                        Rectangle()
                            .frame(width: 50 * Constants.ControlWidth, height: 5 * Constants.ControlHeight)
                            .foregroundColor(Color(hex: "E5E8EB"))
                            .padding(.top, 11 * Constants.ControlHeight)
                            .padding(.bottom, 24 * Constants.ControlHeight)
                        
                        Image("swipstone_achive")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 76 * Constants.ControlWidth, height: 76 * Constants.ControlHeight)
                            .padding(.bottom, 14 * Constants.ControlHeight)
                        
                        HStack(spacing: 0){
                            Text("축하해요!")
                                .font(.Headline)
                                .tracking(-0.6)
                                .frame(height: 32 * Constants.ControlHeight)
                                .foregroundColor(.greyDarkHover)
                            
                            Spacer()
                        }
                        .padding(.leading, 22 * Constants.ControlWidth)
                        
                        HStack(spacing: 0){
                            Text("\(point)원")
                                .font(.Display1)
                                .tracking(-0.6)
                                .frame(height: 32 * Constants.ControlHeight)
                                .foregroundColor(.mainNormal)
                            
                            Text("의 포인트를 얻었어요!")
                                .font(.Headline)
                                .tracking(-0.6)
                                .foregroundColor(.black)
                            
                            
                            Spacer()
                        }
                        .frame(height: 38 * Constants.ControlHeight)
                        .padding(.leading, 22 * Constants.ControlWidth)
                        .padding(.bottom, 8 * Constants.ControlHeight)
                        
                        HStack(spacing: 0){
                            Text("윤다희님 덕분에\n지역경제가 활발해지고 있어요!🔥 ")
                                .font(.Body2)
                                .tracking(-0.6)
                                .foregroundColor(.greyNormal)
                            
                            Spacer()
                        }
                        .frame(height: 48 * Constants.ControlHeight)
                        .padding(.leading, 22 * Constants.ControlWidth)
                        .padding(.bottom, 46 * Constants.ControlHeight)
                        
                        Button(action: {
                            achiveModal = false
                        }, label: {
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 326 * Constants.ControlWidth, height: 54 * Constants.ControlHeight)
                                .foregroundColor(.mainNormal)
                                .overlay {
                                    Text("확인")
                                        .font(.Subhead3)
                                        .foregroundColor(.white)
                                }
                                .padding(.bottom, 28 * Constants.ControlHeight)
                        })
                    }
                }
                
        }
        .toolbar(.hidden)
        .background(Color.clear)
    }
}

#Preview {
    SwipstoneAchiveModal(point: .constant("15,000"), achiveModal: .constant(false))
}
