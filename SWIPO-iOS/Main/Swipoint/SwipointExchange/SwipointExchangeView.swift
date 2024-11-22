//
//  SwipointExchangeView.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/22/24.
//

import SwiftUI

struct SwipointExchangeView: View {

    @ObservedObject var viewModel: SwipayViewModel

    @State var makeStopModal: Bool = false
    @State var makeFinishModal: Bool = false
    @State var isTipHidden: Bool = true

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                CustomNavigationBar(title: "스위포인트 환전",
                                    imageType: "question_circle_mark",
                                    stopModal: $makeStopModal, blur: false)
                
                Text("얼마를 환전 할까요?")
                    .lineLimit(1)
                    .font(.Display3)
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)

                Text("환전 금액을 꼭 확인해 주세요")
                    .lineLimit(1)
                    .font(.Caption)
                    .foregroundColor(.mainLightActive)
                    .padding(.bottom, 40)
                    .padding(.horizontal, 16)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(viewModel.state.sampleSwipointExchange.indices, id: \.self) { index in
                            let data = viewModel.state.sampleSwipointExchange[index]

                            VStack {
                                Text("\(data.region) 스위포인트")
                                    .font(.Headline)
                                    .foregroundColor(.white)
                                
                                Image("swipay_card_ex1")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 202 * Constants.ControlWidth, height: 320.33 * Constants.ControlHeight)
                                    .padding(.bottom, 6 * Constants.ControlHeight)

                                RoundedRectangle(cornerRadius: 16)
                                    .frame(width: 202 * Constants.ControlWidth, height: 60 * Constants.ControlHeight)
                                    .foregroundColor(index == 0 ? .greyNormal : .greyDark)
                                    .overlay {
                                        Text("\(data.point) 원")
                                            .font(.Headline)
                                            .foregroundColor(.mainLightHover)
                                    }
                            }

                            if index < viewModel.state.sampleSwipointExchange.count - 1 {
                                Image("connect_line")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 73 * Constants.ControlWidth, height: 173 * Constants.ControlHeight)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }

                Spacer()

                HStack {
                    Spacer()

                    Button(action: {
                    }, label: {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: 360 * Constants.ControlWidth, height: 54 * Constants.ControlHeight)
                            .foregroundColor(.mainNormal)
                            .overlay {
                                Text("환전하기")
                                    .foregroundColor(Color.white)
                                    .font(.Subhead3)
                            }
                    })

                    Spacer()
                }
            }

            VStack(spacing: 0) {
                Spacer()

                Button(action: {
                    isTipHidden.toggle()
                }) {
                    Text("100원 단위로 환전이 가능해요")
                        .font(.Subhead2)
                        .foregroundColor(.mainNormal)
                        .padding(.bottom, 10)
                        .padding(.leading, 3)
                        .background(){
                            Image("login_cloud")
                                .resizable()
                                .frame(width: 250 * Constants.ControlWidth, height: 80 * Constants.ControlHeight)
                                .scaledToFit()
                        }
                        .opacity(isTipHidden ? 1 : 0)
                        .animation(nil, value: isTipHidden)
                }
            }
            .padding(.bottom, 75)
            .zIndex(1)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    SwipointExchangeView(viewModel: SwipayViewModel())
}
