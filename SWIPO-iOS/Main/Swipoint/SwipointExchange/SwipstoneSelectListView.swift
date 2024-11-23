//
//  SwipstoneSelectListView.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/22/24.
//

import SwiftUI

struct SwipstoneSelectListView: View {
    
    @ObservedObject var exchangeViewModel: SwipointExchangeViewModel
    var layout: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 8), count: 3)
    @StateObject var viewModel = SwipstoneViewModel()
    @State private var selectedItem: Cards? = nil
    @Binding var selectedCardID: String
    @Binding var currentSelectdCardId: String
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ScrollView {
                    LazyVGrid(columns: layout, spacing: 8) {
                        ForEach(exchangeViewModel.state.getSwipointCardResponse.cards, id: \.cardId) { item in
                            if selectedCardID != item.cardId{
                                SwipstoneSelectItemView(
                                    region: item.region,
                                    imageName: selectedItem?.cardId == item.cardId
                                        ? exchangeViewModel.convertRegionToEnglish(koreanRegion: item.region) ?? "default_image"
                                        : "unselected_\(exchangeViewModel.convertRegionToEnglish(koreanRegion: item.region) ?? "default_image")", // 선택 상태에 따른 이미지 변경
                                    isSelected: selectedItem?.cardId == item.cardId, // 선택 상태 전달
                                    onSelect: {
                                        selectedItem = item // 선택된 항목 업데이트
                                        currentSelectdCardId = item.cardId
                                    }
                                )
                                .onTapGesture {
                                    selectedItem = item // 선택된 항목 업데이트
                                    currentSelectdCardId = item.cardId
                                }
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

struct SwipstoneSelectItemView: View {
    
    var region: String
    var imageName: String
    var isSelected: Bool
    var onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            ZStack {
                RoundedRectangle(cornerRadius: 9)
                    .frame(width: 103 * Constants.ControlWidth, height: 87 * Constants.ControlHeight)
                    .foregroundColor(.greyLighter)
                    .overlay {
                        VStack(spacing: 0) {
                            Image(imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40 * Constants.ControlWidth,
                                       height: 40 * Constants.ControlHeight)
                            
                            Text(region)
                                .font(.Body2)
                                .foregroundColor(isSelected ? .mainNormal : .greyNormalHover)
                        }
                    }
            }
        }
    }
}

#Preview {
    SwipstoneSelectListView(exchangeViewModel: SwipointExchangeViewModel(), selectedCardID: .constant(""), currentSelectdCardId: .constant(""))
}

