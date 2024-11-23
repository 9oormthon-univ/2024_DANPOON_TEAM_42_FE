//
//  LocationNewModal.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/19/24.
//

import SwiftUI

struct LocationNewModal: View {
    @Binding var region: String
    @ObservedObject var viewModel: SwipayViewModel
    @Binding var newCardModal: Bool
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 28)
                .frame(width: 374 * Constants.ControlWidth, height: 376 * Constants.ControlHeight)
                .overlay {
                    VStack(spacing: 0){
                        Rectangle()
                            .frame(width: 50 * Constants.ControlWidth, height: 5 * Constants.ControlHeight)
                            .foregroundColor(Color(hex: "E5E8EB"))
                            .padding(.top, 11 * Constants.ControlHeight)
                            .padding(.bottom, 14 * Constants.ControlHeight)
                        
                        Image(viewModel.convertRegionToEnglish(koreanRegion: viewModel.convertFullRegionToShort(inputRegion: region) ?? "") ?? "")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 84 * Constants.ControlWidth, height: 84 * Constants.ControlHeight)
                            .padding(.bottom, 14 * Constants.ControlHeight)
                            
                        
                        let regionVisit = Text(viewModel.convertFullRegionToShort(inputRegion: region) ?? "")
                            .font(.Headline)
                            .tracking(-0.6)
                            .foregroundColor(.mainNormal)
                            +
                        Text(" 방문이 처음이시군요!")
                            .font(.Headline)
                            .tracking(-0.6)
                            .foregroundColor(.greyNormal)
                        
                        HStack(spacing: 0){
                            VStack(alignment: .leading, spacing: 0){
                                Text("\(viewModel.state.getSwipayResponse.userName)님 환영해요!")
                                    .frame(height: 28 * Constants.ControlHeight)
                                    .font(.Headline)
                                    .tracking(-0.6)
                                    .foregroundColor(.greyDarkHover)
                                
                                regionVisit
                                    .frame(height: 28 * Constants.ControlHeight)
                                
                            }
                            
                            Spacer()
                        }
                        .padding(.leading, 22 * Constants.ControlWidth)
                        .padding(.bottom, 8 * Constants.ControlHeight)
                        
                        HStack(spacing: 0){
                            VStack(alignment: .leading, spacing: 0){
                                Text("\(viewModel.convertFullRegionToShort(inputRegion: region) ?? "") 스위포인트를 사용하시려면\n강원도 카드 등록이 필요해요! 😄")
                                    .font(.Body2)
                                    .tracking(-0.6)
                                    .lineSpacing(4)
                                    .foregroundColor(.greyNormal)
                            }
                            
                            Spacer()
                        }
                        .padding(.leading, 22 * Constants.ControlWidth)
                        .padding(.bottom, 46 * Constants.ControlHeight)
                        
                        
                        
                        Button(action: {
                            AppState.shared.navigationPath.append(swipointType.custom)
                            newCardModal = false
                        }, label: {
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 326 * Constants.ControlWidth, height: 54 * Constants.ControlHeight)
                                .foregroundColor(.mainNormal)
                                .overlay {
                                    Text("카드 만들기")
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
    LocationNewModal(region: .constant("울산광역시"), viewModel: SwipayViewModel(), newCardModal: .constant(false))
}
