//
//  SwipstoneSelectModal.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/22/24.
//

import SwiftUI

struct SwipstoneSelectModal: View {
    
    var layout: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 8), count: 3)
    @StateObject var viewModel = SwipstoneViewModel()
    @State private var selectedItem: RegionInfo? = nil

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ScrollView {
                    LazyVGrid(columns: layout, spacing: 8) {
                        ForEach(viewModel.state.regionInfo, id: \.id) { item in
                            SwipstoneSelectItemView(region: item.region,
                                                    imageName: selectedItem?.id == item.id ? item.imageName : item.unselectedImageName,
                                                    isSelected: selectedItem?.id == item.id,
                                                    onSelect: {
                                selectedItem = item
                            })
                            .onTapGesture {
                                selectedItem = item
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
    SwipstoneSelectModal()
}

#Preview {
    SwipstoneSelectItemView(region: "서울", imageName: "unselected_seoul", isSelected: false, onSelect: { })
}
