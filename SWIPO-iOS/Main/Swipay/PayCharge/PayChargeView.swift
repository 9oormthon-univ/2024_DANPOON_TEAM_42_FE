//
//  PayChargeView.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/18/24.
//

import SwiftUI

struct PayChargeView: View {
    @State var isTipHidden: Bool = true
    @State private var selectedCharge: Int = 0

    var body: some View {
        ZStack {
            VStack {
                NavigationBar(title: "충전", showBackButton: true)

                HStack {
                    VStack(alignment: .leading) {
                        if selectedCharge != 0 {
                            Text("\(selectedCharge)원")
                                .font(.Display3)
                                .padding(.bottom, 6)
                        } else {
                            Text("얼마를 충전 할까요?")
                                .font(.Display3)
                                .padding(.bottom, 6)
                        }
                        Text("충전 가능 금액: ")
                            .font(.Caption)
                        + Text("500,000 P")
                            .foregroundColor(.danger)
                            .font(.Caption)
                        Text("충전 한도: 1회 50만 P")
                            .font(.Caption)
                    }
                    .padding(.leading, 17)
                    
                    Spacer()
                }

                VStack(spacing: 12) {
                    PayChargePriceView(image: "swipay_character1", price: "10,000원", chargeAmount: 10000, selectedCharge: $selectedCharge)
                    PayChargePriceView(image: "swipay_character2", price: "30,000원", chargeAmount: 30000, selectedCharge: $selectedCharge)
                    PayChargePriceView(image: "swipay_character3", price: "50,000원", chargeAmount: 50000, selectedCharge: $selectedCharge)
                    PayChargePriceView(image: "swipay_character4", price: "100,000원", chargeAmount: 100000, selectedCharge: $selectedCharge)
                }
                .padding(.top, 48)
                .padding(.bottom, 12)

                Button(action: {
                    selectedCharge = 0
                }, label: {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 122 * Constants.ControlWidth, height: 40 * Constants.ControlHeight)
                        .scaledToFit()
                        .foregroundColor(selectedCharge == 0 ? .greyDarkHover : .greyLightActive)
                        .overlay {
                            HStack(spacing: 4) {
                                Text("되돌리기")
                                    .font(.Body2)
                                    .foregroundColor(.greyLightHover)

                                Image("swipay_refresh")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20 * Constants.ControlWidth, height: 20 * Constants.ControlHeight)
                            }
                        }
                })

                Spacer()

                VStack(spacing: 63) {
                    
                    Spacer()

                    Button(action: {
                        isTipHidden.toggle()
                    }) {
                        Text("스위페이 충전도 간편하게 💸")
                            .font(.Subhead2)
                            .foregroundColor(Color(hex: "4F4FFD"))
                            .padding(.bottom, 10)
                            .padding(.leading, 3)
                            .background(){
                                Image("login_cloud")
                                    .resizable()
                                    .frame(width: 230 * Constants.ControlWidth, height: 80 * Constants.ControlHeight)
                                    .scaledToFit()
                            }
                            .opacity(isTipHidden ? 1 : 0)
                            .animation(nil, value: isTipHidden)
                    }
                }
                .zIndex(1)

                Button(action: {
                    // 카카오 페이 결제창 이동
                }) {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 360 * Constants.ControlWidth, height: 54 * Constants.ControlHeight)
                        .disabled(selectedCharge == 0)
                        .foregroundColor(selectedCharge != 0 ? .mainNormal : .mainLightActive)
                        .overlay {
                            Text("충전하기")
                                .foregroundColor(Color.white)
                                .font(.Subhead3)
                        }
                }
                .padding(.bottom, 30)
            }
            
            .toolbar(.hidden)

        }
    }
}

#Preview {
    PayChargeView()
}

struct PayChargePriceView: View {

    let image: String
    let price: String
    let chargeAmount: Int

    @Binding var selectedCharge: Int

    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .frame(width: 360 * Constants.ControlWidth,
                   height: 78 * Constants.ControlHeight)
            .scaledToFit()
            .foregroundColor(.greyDarkHover)
            .overlay {
                HStack(spacing: 4){
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 78 * Constants.ControlHeight)

                    Spacer()

                    Text(price)
                        .font(.Display1)
                        .foregroundColor(.white)
                    Button(action: {
                        if selectedCharge + chargeAmount <= 500000 {
                            selectedCharge += chargeAmount
                        }
                    }, label: {
                        RoundedRectangle(cornerRadius: 7)
                            .frame(width: 26 * Constants.ControlWidth,
                                   height: 26 * Constants.ControlHeight)
                            .foregroundColor(.greyLightActive)
                            .overlay {
                                Image(.swipayAdd)
                            }
                    })
                    .padding(.leading, 9)
                    .padding(.trailing, 20)
                }
            }
    }
}
