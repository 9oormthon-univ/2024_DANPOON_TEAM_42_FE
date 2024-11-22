//
//  CustomRegister.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/20/24.
//

import SwiftUI
import UIKit

struct CustomRegisterView: View {
    @Binding var generatedImage: UIImage?
    @Binding var region: String
    @StateObject var viewModel = CustomViewModel()
    @StateObject var swipayViewModel = SwipayViewModel()
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                NavigationBar(title: "", showBackButton: true)
                
                RegisterMainView(generatedImage: $generatedImage, region: $region)
                
                Spacer()
            }
            
            
        }
        .toolbar(.hidden)
        .onAppear(){
            Task{
                await registerCard(region: swipayViewModel.convertFullRegionToShort(inputRegion: region) ?? "", custom_image: "\(swipayViewModel.convertFullRegionToShort(inputRegion: region) ?? "").jpeg", multipartFile: generatedImageToData(image: generatedImage))
            }
        }
    }
    
    /// `UIImage`를 `Foundation.Data?`로 변환하여 배열로 감쌉니다.
    func generatedImageToData(image: UIImage?) -> [Foundation.Data?] {
        guard let image = image else { return [nil] } // 이미지가 없으면 nil
        return [image.jpegData(compressionQuality: 0.8)] // JPEG 데이터로 변환 후 배열 반환
    }
    
    /// 카드 등록 호출
    func registerCard(region: String, custom_image: String, multipartFile: [Foundation.Data?]) async {
        await viewModel.action(.registerCard(region: region, custom_image: custom_image, multipartFile: multipartFile))
    }
    
    
//    func convertImageToFileURL(image: UIImage) -> URL? {
//        let fileManager = FileManager.default
//        guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
//            print("문서 디렉토리 경로를 찾을 수 없습니다.")
//            return nil
//        }
//
//        let fileURL = documentsURL.appendingPathComponent("NewCard.jpeg")
//
//        // UIImage를 JPEG 데이터로 변환
//        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
//            print("이미지를 JPEG 데이터로 변환할 수 없습니다.")
//            return nil
//        }
//
//        do {
//            // 이미지 데이터 저장
//            try imageData.write(to: fileURL)
//            print("이미지가 저장되었습니다: \(fileURL.path)")
//            return fileURL
//        } catch {
//            print("이미지를 저장하는 동안 오류가 발생했습니다: \(error)")
//            return nil
//        }
//    }
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

