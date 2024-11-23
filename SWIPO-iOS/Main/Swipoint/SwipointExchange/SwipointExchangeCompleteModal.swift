//
//  SwipointExchangeCompleteModal.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/22/24.
//

import SwiftUI

struct SwipointExchangeCompleteModal: View {

    @Binding var completeModal: Bool
    var onComplete: () -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 28)
                .frame(width: 374 * Constants.ControlWidth, height: 388 * Constants.ControlHeight)
                .overlay {
                    VStack(spacing: 0) {
                        Rectangle()
                            .frame(width: 50 * Constants.ControlWidth, height: 5 * Constants.ControlHeight)
                            .foregroundColor(Color(hex: "E5E8EB"))
                            .padding(.top, 11 * Constants.ControlHeight)
                            .padding(.bottom, 24 * Constants.ControlHeight)
                        
                        Image("exchange_complete")
                            .resizable()
                            .frame(width: 76 * Constants.ControlWidth,
                                   height: 76 * Constants.ControlHeight)
                            .padding(.bottom, 14 * Constants.ControlHeight)

                        Text("스위포인트 환전 완료")
                            .font(.Headline)
                            .tracking(-0.6)
                            .frame(height: 32 * Constants.ControlHeight)
                            .foregroundColor(.greyDarkHover)
                            .padding(.bottom, 36 * Constants.ControlHeight)

                        VStack(spacing: 8) {
                            HStack {
                                Text("부산 잔액")
                                    .font(.Headline)
                                    .tracking(-0.6)
                                    .frame(height: 32 * Constants.ControlHeight)
                                    .foregroundColor(.greyDarkHover)

                                Spacer()

                                Text("124원")
                                    .font(.Headline)
                                    .tracking(-0.6)
                                    .frame(height: 32 * Constants.ControlHeight)
                                    .foregroundColor(.mainNormal)
                            }
                            .padding(.horizontal, 24 * Constants.ControlHeight)

                            HStack {
                                Text("서울 잔액")
                                    .font(.Headline)
                                    .tracking(-0.6)
                                    .frame(height: 32 * Constants.ControlHeight)
                                    .foregroundColor(.greyDarkHover)

                                Spacer()

                                Text("15,024원")
                                    .font(.Headline)
                                    .tracking(-0.6)
                                    .frame(height: 32 * Constants.ControlHeight)
                                    .foregroundColor(.mainNormal)
                            }
                            .padding(.horizontal, 24 * Constants.ControlHeight)
                        }

                        Spacer()

                        Button(action: {
                            completeModal = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                onComplete()
                            }
                        }, label: {
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 326 * Constants.ControlWidth,
                                       height: 54 * Constants.ControlHeight)
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
        .background(.clear)
    }
}

#Preview {
    SwipointExchangeCompleteModal(
        completeModal: .constant(true),
        onComplete: { }
    )
}
