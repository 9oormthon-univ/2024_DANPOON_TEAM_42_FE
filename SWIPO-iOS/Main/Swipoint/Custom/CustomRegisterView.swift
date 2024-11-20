//
//  CustomRegister.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/20/24.
//

import SwiftUI

struct CustomRegisterView: View {
    @Binding var generatedImage: UIImage?
    @Binding var region: String
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                NavigationBar(title: "", showBackButton: true)
                
                RegisterMainView(generatedImage: $generatedImage, region: $region)
                
                Spacer()
            }
            
            
        }
        .toolbar(.hidden)
    }
}

struct RegisterMainView: View {
    @Binding var generatedImage: UIImage?
    @Binding var region: String
    
    var swipointViewModel = SwipointViewModel()
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                Text("윤다희님 너무 멋진데요?")
                    .font(.Headline)
                    .tracking(-0.6)
                    .frame(height: 32 * Constants.ControlHeight)
                    .foregroundColor(.greyLighter)
                
                Text("\(swipointViewModel.convertFullRegionToShort(inputRegion: region) ?? "") 카드가 등록되었어요 🎉")
                    .font(.Display2)
                    .tracking(-0.6)
                    .foregroundColor(.white)
                    .frame(height: 38 * Constants.ControlHeight)
                
                Text("\(swipointViewModel.convertFullRegionToShort(inputRegion: region) ?? "") 스위포인트 모으기 시작해 볼까요?")
                    .font(.Body2)
                    .tracking(-0.6)
                    .frame(height: 24 * Constants.ControlHeight)
                    .foregroundColor(.white)
                    .padding(.bottom, 63.1 * Constants.ControlHeight)
                
                Image(uiImage: generatedImage ?? UIImage())
                    .resizable()
                    .scaledToFit()
                    .frame(width: 242.21 * Constants.ControlWidth, height: 384.1 * Constants.ControlHeight) // 미리보기
                    .background(.greyDarkHover)
                    .clipShape(RoundedRectangle(cornerRadius: 8.4))
                    .padding(.bottom, 106.95 * Constants.ControlHeight)
                
                Button {
                    AppState.shared.navigationPath.removeLast()
                    AppState.shared.navigationPath.removeLast()
                } label: {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 360 * Constants.ControlWidth, height: 54 * Constants.ControlHeight)
                        .foregroundColor(.mainNormal)
                        .overlay {
                            Text("좋아요")
                                .font(.Subhead3)
                                .tracking(-0.6)
                                .foregroundColor(.white)
                        }
                }

            }
        }
    }
}

#Preview {
    CustomRegisterView(generatedImage: .constant(nil), region: .constant(""))
}
