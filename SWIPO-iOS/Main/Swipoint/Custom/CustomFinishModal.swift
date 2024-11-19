//
//  CustomFinishModal.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/20/24.
//

import SwiftUI

struct CustomFinishModal: View {
    
    @Binding var makeFinishModal: Bool
    
    var body: some View {
        ZStack{
            
            RoundedRectangle(cornerRadius: 28)
                .frame(width: 374 * Constants.ControlWidth, height: 240 * Constants.ControlHeight)
                .overlay {
                    VStack(spacing: 0){
                        Rectangle()
                            .frame(width: 50 * Constants.ControlWidth, height: 5 * Constants.ControlHeight)
                            .foregroundColor(Color(hex: "E5E8EB"))
                            .padding(.top, 11 * Constants.ControlHeight)
                            .padding(.bottom, 24 * Constants.ControlHeight)
                        
                        
                        HStack(spacing: 0){
                            Image("swipoint_circle_warning")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24 * Constants.ControlWidth)
                            
                            Text("카드를 등록할까요?")
                                .font(.Headline)
                                .tracking(-0.6)
                                .foregroundColor(.greyDarkHover)
                                .padding(.leading, 4 * Constants.ControlWidth)
                            
                            Spacer()
                        }
                        .padding(.leading, 22 * Constants.ControlWidth)
                        .padding(.bottom, 8 * Constants.ControlHeight)
                        
                        HStack(spacing: 0){
                            
                            Text("한 번 등록하면 수정이나 삭제가 어려워요")
                                .font(.Headline)
                                .frame(height: 32 * Constants.ControlHeight)
                                .tracking(-0.6)
                                .foregroundColor(.greyNormal)
                            
                            Spacer()
                        }
                        .padding(.leading, 22 * Constants.ControlWidth)
                        .padding(.bottom, 46 * Constants.ControlHeight)
                        
                        Spacer()
                        
                        HStack(spacing: 8){
                            Button(action: {
                                makeFinishModal = false
                            }, label: {
                                RoundedRectangle(cornerRadius: 16)
                                    .frame(width: 159 * Constants.ControlWidth, height: 54 * Constants.ControlHeight)
                                    .foregroundColor(.greyLighter)
                                    .overlay {
                                        Text("이전 화면")
                                            .font(.Subhead3)
                                            .foregroundColor(Color(hex: "A7A7A7"))
                                    }
                            })
                            
                            Button(action: {
                                makeFinishModal = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    AppState.shared.navigationPath.append(customType.register)
                                }
                            }, label: {
                                RoundedRectangle(cornerRadius: 16)
                                    .frame(width: 159 * Constants.ControlWidth, height: 54 * Constants.ControlHeight)
                                    .foregroundColor(.mainNormal)
                                    .overlay {
                                        Text("등록 하기")
                                            .font(.Subhead3)
                                            .foregroundColor(.greyLighter)
                                    }
                            })
                        }
                        .padding(.bottom, 28 * Constants.ControlHeight)
                    }
                }
        }
        .toolbar(.hidden)
        .background(Color.clear)
    }
}

#Preview {
    CustomFinishModal(makeFinishModal: .constant(false))
}
