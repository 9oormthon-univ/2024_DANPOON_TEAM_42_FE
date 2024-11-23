//
//  SwipointExchangeModal.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/22/24.
//

import SwiftUI

struct SwipointExchangeModal: View {

    @Binding var exchangeModal: Bool
    @Binding var completeModal: Bool
    @ObservedObject var exchangeViewModel: SwipointExchangeViewModel
    @Binding var exchangeInputInt: Int
    var fromCardId: String = ""
    var toCardId: String = ""

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 28)
                .frame(width: 374 * Constants.ControlWidth, height: 232 * Constants.ControlHeight)
                .overlay {
                    VStack(spacing: 0) {
                        Rectangle()
                            .frame(width: 50 * Constants.ControlWidth, height: 5 * Constants.ControlHeight)
                            .foregroundColor(Color(hex: "E5E8EB"))
                            .padding(.top, 11 * Constants.ControlHeight)
                            .padding(.bottom, 24 * Constants.ControlHeight)

                        HStack {
                            VStack(alignment: .leading) {
                                Text("포인트 환전을 진행할까요?")
                                    .font(.Headline)
                                    .tracking(-0.6)
                                    .frame(height: 32 * Constants.ControlHeight)
                                    .foregroundColor(.greyDarkHover)
                                    .padding(.bottom, 8 * Constants.ControlHeight)
                                
                                Text("환전 1회당 1%의 수수료가 부과돼요!")
                                    .font(.Body2)
                                    .tracking(-0.6)
                                    .foregroundColor(.greyNormal)
                                    .frame(height: 24 * Constants.ControlHeight)
                            }

                            Spacer()
                        }
                        .padding(.horizontal, 24)

                        Spacer()

                        HStack(spacing: 8) {
                            Button(action: {
                                exchangeModal = false
                            }, label: {
                                RoundedRectangle(cornerRadius: 16)
                                    .frame(width: 159 * Constants.ControlWidth,
                                           height: 54 * Constants.ControlHeight)
                                    .foregroundColor(.greyLighter)
                                    .overlay {
                                        Text("중단 하기")
                                            .font(.Subhead3)
                                            .foregroundColor(Color(hex: "A7A7A7"))
                                    }
                            })

                            Button(action: {
                                exchangeModal = false
                                Task{
                                    await exchangeViewModel.action(.exchangePoint(fromCardId: fromCardId, toCardId: toCardId, point: exchangeInputInt))
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    completeModal = true
                                }
                            }, label: {
                                RoundedRectangle(cornerRadius: 16)
                                    .frame(width: 159 * Constants.ControlWidth,
                                           height: 54 * Constants.ControlHeight)
                                    .foregroundColor(.mainNormal)
                                    .overlay {
                                        Text("계속 하기")
                                            .font(.Subhead3)
                                            .foregroundColor(.white)
                                    }
                            })
                        }
                        .padding(.bottom, 28 * Constants.ControlHeight)
                    }
                }
                
        }
        .toolbar(.hidden)
        .background(Color.clear)
    }
}

#Preview {
    SwipointExchangeModal(exchangeModal: .constant(false), completeModal: .constant(false), exchangeViewModel: SwipointExchangeViewModel(), exchangeInputInt: .constant(0))
}

