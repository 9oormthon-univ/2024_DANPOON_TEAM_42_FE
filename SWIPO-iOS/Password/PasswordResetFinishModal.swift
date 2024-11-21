//
//  PasswordResetFinishModal.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/21/24.
//
import SwiftUI

struct PasswordResetFinishModal: View {
    
    @Binding var resetFinishModal: Bool
    
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
                            
                            Text("간편 비밀번호가 재설정 되었어요")
                                .font(.Headline)
                                .foregroundColor(.greyDarkHover)
                            
                            Spacer()
                        }
                        .padding(.top)
                        .padding(.bottom)
                        .padding(.leading, 24 * Constants.ControlWidth)
                        
                        HStack(spacing: 0){
                            Text("로그인 및 결제시 새로운\n간편 비밀번호를 사용해 주세요")
                                .font(.Headline)
                                .foregroundColor(.greyNormal)
                            
                            Spacer()
                        }
                        .padding(.leading, 24 * Constants.ControlWidth)
                        .padding(.trailing)
                        .padding(.top, 8 * Constants.ControlHeight)
                        
                        
                        Button(action: {
                            resetFinishModal.toggle()
                        }, label: {
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 326 * Constants.ControlWidth, height: 54 * Constants.ControlHeight)
                                .foregroundColor(.mainNormal)
                                .overlay {
                                    Text("확인")
                                        .font(.Subhead3)
                                        .foregroundColor(.white)
                                }
                        })
                        .padding(.top, 46 * Constants.ControlHeight)
                        .padding(.trailing)
                        .padding(.leading)
                        
                        Spacer()
                    }
                }
                
        }
        .frame(width: 374 * Constants.ControlWidth, height: 452 * Constants.ControlHeight)
        .background(Color.clear)
        .toolbar(.hidden)
    }
}

#Preview {
    PasswordResetFinishModal(resetFinishModal: .constant(false))
}
