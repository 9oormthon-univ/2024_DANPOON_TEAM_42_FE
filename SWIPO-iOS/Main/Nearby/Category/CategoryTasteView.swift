//
//  CategoryTasteView.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/21/24.
//

import SwiftUI

struct CategoryTasteView: View {
    @StateObject var viewModel = StoreViewModel()

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 27) {
                CategoryRankingView(store: viewModel.state.sampleStores[0], rankingImageIndex: 0, isTaste: true)
//                CategoryDefaultView(store: <#T##StoreTab#>, isTaste: <#T##Bool#>)
                    .padding(.trailing, 30)
            }
        }
    }
}

#Preview {
    CategoryTasteView()
}
