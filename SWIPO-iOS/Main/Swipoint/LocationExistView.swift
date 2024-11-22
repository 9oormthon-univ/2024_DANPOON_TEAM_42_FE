//
//  LocationExistView.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/19/24.
//

import SwiftUI

struct LocationExistView: View {
    @Binding var region: String
    @ObservedObject var viewModel: SwipayViewModel
    @Binding var existenceCardModal: Bool

    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 28)
                .frame(width: 374 * Constants.ControlWidth, height: 344 * Constants.ControlHeight)
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
                            
                        HStack(spacing: 0){
                            Text("이미 ")
                                .font(.Headline)
                                .tracking(-0.6)
                                .foregroundColor(.greyDarkHover)
                            Text(viewModel.convertFullRegionToShort(inputRegion: region) ?? "")
                                .font(.Headline)
                                .tracking(-0.6)
                                .foregroundColor(.mainNormal)
                            Text(" 카드를 보유하고 있어요!")
                                .font(.Headline)
                                .tracking(-0.6)
                                .foregroundColor(.greyDarkHover)
                            
                            Spacer()
                        }
                        .frame(height: 28 * Constants.ControlHeight)
                        .padding(.leading, 22 * Constants.ControlWidth)
                        .padding(.bottom, 8 * Constants.ControlHeight)
                        
                        HStack(spacing: 0){
                            Text("같은 지역 카드는 중복 등록 할 수 없어요\n타 지역으로 여행을 떠나보는거 어떨까요? ✈️")
                                .font(.Body2)
                                .lineLimit(2)
                                .tracking(-0.6)
                                .lineSpacing(4)
                                .foregroundColor(.greyNormal)
                            
                            Spacer()
                        }
                        .padding(.leading, 22 * Constants.ControlWidth)
                        .padding(.bottom, 48 * Constants.ControlHeight)
                        
                        
                        Button(action: {
                            existenceCardModal = false
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
                        .padding(.bottom, 28 * Constants.ControlHeight)
                    }
                }
                
        }
        .toolbar(.hidden)
        .background(Color.clear)
    }
}

#Preview {
    LocationExistView(region: .constant("울산광역시"), viewModel: SwipayViewModel(), existenceCardModal: .constant(false))
}
