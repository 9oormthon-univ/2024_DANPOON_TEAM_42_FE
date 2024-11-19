//
//  CustomRegister.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/20/24.
//

import SwiftUI

struct CustomRegisterView: View {
    @Binding var generatedImage: UIImage?
    
    var body: some View {
        ZStack{
            Image(uiImage: generatedImage!)
                .resizable()
                .scaledToFit()
                .frame(height: 300) // 미리보기
                .background(.greyDarkHover)
        }
        .toolbar(.hidden)
    }
}

#Preview {
    CustomRegisterView(generatedImage: .constant(nil))
}
