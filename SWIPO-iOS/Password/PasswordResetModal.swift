//
//  PasswordResetModal.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/21/24.
//
import SwiftUI

struct PasswordResetModal: View {
    
    @Binding var resetModal: Bool
    @Binding var navigation: String
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 28)
                .frame(width: 374 * Constants.ControlWidth, height: 272 * Constants.ControlHeight)
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
                            
                            Text("비밀번호를 5회 이상 틀렸어요")
                                .font(.Headline)
                                .foregroundColor(.greyDarkHover)
                            
                            Spacer()
                        }
                        .padding(.top)
                        .padding(.bottom)
                        .padding(.leading, 24 * Constants.ControlWidth)
                        
                        HStack(spacing: 0){
                            Text("마이페이지에서 비밀번호를\n재설정 해야해요")
                                .font(.Headline)
                                .foregroundColor(.greyNormal)
                            
                            Spacer()
                        }
                        .padding(.leading, 24 * Constants.ControlWidth)
                        .padding(.trailing)
                        .padding(.top, 8 * Constants.ControlHeight)
                        
                        
                        HStack(spacing: 0){
                            Button(action: {
                                resetModal.toggle()
                                navigation = "메인화면"
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
                                resetModal.toggle()
                                navigation = "재설정"
                            }, label: {
                                RoundedRectangle(cornerRadius: 16)
                                    .frame(width: 159 * Constants.ControlWidth, height: 54 * Constants.ControlHeight)
                                    .foregroundColor(.mainNormal)
                                    .overlay {
                                        Text("재설정 하기")
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
        .frame(width: 374 * Constants.ControlWidth, height: 452 * Constants.ControlHeight)
        .toolbar(.hidden)
        .background(Color.clear)
    }
}

#Preview {
    PasswordResetModal(resetModal: .constant(false), navigation: .constant(""))
}
