//
//  LocationCertificationModel.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/19/24.
//

import SwiftUI

struct LocationCertificationModal: View {

    @ObservedObject var viewModel: SwipayViewModel
    @Binding var makeCardModal: Bool
    @Binding var region: String
    @Binding var newCardModal: Bool
    @Binding var existenceCardModal: Bool
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 28)
                .frame(width: 374 * Constants.ControlWidth, height: 346 * Constants.ControlHeight)
                .overlay {
                    VStack(spacing: 0){
                        Rectangle()
                            .frame(width: 50 * Constants.ControlWidth, height: 5 * Constants.ControlHeight)
                            .foregroundColor(Color(hex: "E5E8EB"))
                            .padding(.top, 11 * Constants.ControlHeight)
                            .padding(.bottom, 24 * Constants.ControlHeight)
                        
                        
                        Image("swipoint_location")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 79 * Constants.ControlWidth, height: 76 * Constants.ControlHeight)
                            .padding(.bottom, 14 * Constants.ControlHeight)
                            
                        
                        HStack(spacing: 0){
                            VStack(spacing: 8 * Constants.ControlHeight){
                                Text("위치 인증이 필요해요!")
                                    .frame(height: 28 * Constants.ControlHeight)
                                    .font(.Headline)
                                    .tracking(-0.6)
                                    .foregroundColor(.greyDarkHover)
                                
                                Text("내 위치를 바탕으로\n새로운 카드를 등록 할까요?")
                                    .font(.Body2)
                                    .tracking(-0.6)
                                    .lineSpacing(4)
                                    .foregroundColor(.greyNormal)
                            }
                            
                            Spacer()
                        }
                        .padding(.leading, 24 * Constants.ControlWidth)
                        .padding(.bottom, 46 * Constants.ControlHeight)
                        
                        Button(action: {
                            makeCardModal = false
                            let isAvailable = viewModel.isRegionAvailable(inputRegion: region)
                            if isAvailable {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    newCardModal = true
                                    existenceCardModal = false
                                }
                                
                            } else {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    newCardModal = false
                                    existenceCardModal = true
                                }
                            }
                        }, label: {
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 326 * Constants.ControlWidth, height: 54 * Constants.ControlHeight)
                                .foregroundColor(.mainNormal)
                                .overlay {
                                    Text("위치 인증하기")
                                        .font(.Subhead3)
                                        .foregroundColor(.white)
                                }
                        })
                        .padding(.bottom, 28 * Constants.ControlHeight)
                    }
                }
                
        }
        .toolbar(.hidden)
        .background(Color.clear)
    }
}

#Preview {
    LocationCertificationModal(viewModel: SwipayViewModel(), makeCardModal: .constant(false), region: .constant(""), newCardModal: .constant(false), existenceCardModal: .constant(false))
}
