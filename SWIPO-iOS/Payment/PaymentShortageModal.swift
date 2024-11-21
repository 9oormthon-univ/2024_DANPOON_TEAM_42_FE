//
//  PaymentShortageModal.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/21/24.
//

import SwiftUI

struct PaymentShortageModal: View {
    @Binding var shortageModal: Bool
    @Binding var navigation: String
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 28)
                .frame(width: 374 * Constants.ControlWidth, height: 240 * Constants.ControlHeight)
                .overlay {
                    VStack(spacing: 0){
                        Rectangle()
                            .frame(width: 50 * Constants.ControlWidth, height: 5 * Constants.ControlHeight)
                            .foregroundColor(Color(hex: "E5E8EB"))
                            .padding(.top)
                            .padding(.bottom, 10 * Constants.ControlHeight)
                        
                        HStack(spacing: 0){
                            Image("password_exclamation")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24 * Constants.ControlWidth, height: 24 * Constants.ControlHeight)
                                .padding(.trailing, 4)
                            
                            Text("페이 잔액이 부족해요 🥹")
                                .font(.Headline)
                                .tracking(-0.6)
                                .frame(height: 32 * Constants.ControlHeight)
                                .foregroundColor(.greyDarkHover)
                            
                            Spacer()
                        }
                        .padding(.top)
                        .padding(.leading, 24 * Constants.ControlWidth)
                        
                        HStack(spacing: 0){
                            Text("스위페이에서 잔액을 충전해야 해요")
                                .font(.Headline)
                                .tracking(-0.6)
                                .foregroundColor(.greyNormal)
                            
                            Spacer()
                        }
                        .padding(.leading, 24 * Constants.ControlWidth)
                        .padding(.trailing)
                        .padding(.top, 8 * Constants.ControlHeight)
                        
                        
                        HStack(spacing: 0){
                            Button(action: {
                                shortageModal.toggle()
                                AppState.shared.navigationPath.removeLast()
                                AppState.shared.navigationPath.removeLast()
                            }, label: {
                                RoundedRectangle(cornerRadius: 16)
                                    .frame(width: 159 * Constants.ControlWidth, height: 54 * Constants.ControlHeight)
                                    .foregroundColor(.greyLighter)
                                    .overlay {
                                        Text("메인화면")
                                            .font(.Subhead3)
                                            .foregroundColor(Color(hex: "A7A7A7"))
                                    }
                            })
                            
                            Spacer()
                            
                            Button(action: {
                                shortageModal.toggle()
                                navigation = "충전"
                            }, label: {
                                RoundedRectangle(cornerRadius: 16)
                                    .frame(width: 159 * Constants.ControlWidth, height: 54 * Constants.ControlHeight)
                                    .foregroundColor(.mainNormal)
                                    .overlay {
                                        Text("충전 하기")
                                            .font(.Subhead3)
                                            .foregroundColor(.white)
                                    }
                            })
                        }
                        .padding(.leading, 24 * Constants.ControlWidth)
                        .padding(.trailing, 24 * Constants.ControlWidth)
                        .padding(.top, 46 * Constants.ControlHeight)
                        
                        Spacer()
                    }
                }
                
        }
        .toolbar(.hidden)
        .background(Color.clear)
    }
}

#Preview {
    PaymentShortageModal(shortageModal: .constant(false), navigation: .constant(""))
}
