//
//  StoreOptionView.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/18/24.
//

import SwiftUI

struct StoreOptionView: View {
    @Binding var isModalVisible: Bool
    @Binding var selectedOption: String

    @State private var tempOption: String = ""
    let options: [String]
    let height: CGFloat

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 28)
                .frame(width: 374 * Constants.ControlWidth, height: height * Constants.ControlHeight)
                .overlay {
                    VStack(spacing: 0) {
                        Rectangle()
                            .frame(width: 50 * Constants.ControlWidth, height: 5 * Constants.ControlHeight)
                            .foregroundColor(.POPUP)
                            .padding(.top, 11)
                            .padding(.bottom, 35)

                        ForEach(options, id: \.self) { item in
                            Button(action: {
                                tempOption = item
                            }) {
                                Text(item)
                                    .font(.Body2)
                                    .foregroundColor(tempOption == item ? .mainNormal : .black)
                            }
                            .padding(.bottom, 36)
                        }

                        Button(action: {
                            selectedOption = tempOption
                            isModalVisible.toggle()
                        }) {
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 326 * Constants.ControlWidth, height: 54 * Constants.ControlHeight)
                                .foregroundColor(.mainNormal)
                                .overlay {
                                    Text("확인")
                                        .foregroundColor(.white)
                                        .font(.Subhead3)
                                }
                        }
                        .padding(.bottom, 30)
                        .padding(.horizontal, 30)
                    }
                }
        }
        .frame(width: 374 * Constants.ControlWidth, height: height * Constants.ControlHeight)
        .background(.clear)
        .onAppear {
            tempOption = selectedOption
        }
    }
}

#Preview {
    StoreOptionView(
        isModalVisible: .constant(true),
        selectedOption: .constant(""),
        options: ["전체", "카페", "디저트", "음식점", "마트", "소품샵", "숙박"],
        height: 532
    )
}
