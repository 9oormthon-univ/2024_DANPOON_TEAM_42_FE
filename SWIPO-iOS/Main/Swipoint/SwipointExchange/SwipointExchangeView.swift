//
//  SwipointExchangeView.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/22/24.
//

import SwiftUI

struct SwipointExchangeView: View {

    @ObservedObject var viewModel: SwipayViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var exchangeInputText: String = ""
    @State private var exchangeInputInt: Int = 0

    @State var makeStopModal: Bool = false
    @State var makeFinishModal: Bool = false
    @State var exchangeModal: Bool = false
    @State var completeModal: Bool = false
    @State var isTipHidden: Bool = true

    var body: some View {
        let fromPoint = viewModel.state.sampleSwipointExchange[0]
        let toPoint = viewModel.state.sampleSwipointExchange[1]

        ZStack {
            VStack(alignment: .leading) {
                CustomNavigationBar(title: "스위포인트 환전",
                                    imageType: "question_circle_mark",
                                    stopModal: $makeStopModal, blur: false)

                ZStack(alignment: .leading) {
                    if exchangeInputText.isEmpty {
                        Text("얼마를 환전 할까요?")
                            .lineLimit(1)
                            .font(.Display3)
                            .foregroundColor(.white)
                    }
                    TextField("", text: $exchangeInputText)
                        .keyboardType(.numberPad)
                        .font(.Display3)
                        .tint(.white)
                        .onChange(of: exchangeInputText) { newValue in
                            isTipHidden = false
                            let cleanedValue = newValue.replacingOccurrences(of: ",", with: "")
                            exchangeInputInt = Int(cleanedValue) ?? 0
                            exchangeInputText = formatPrice(cleanedValue)
                        }
                }
                .frame(height: 42)
                .padding(.horizontal, 16)

                Text("환전 금액을 꼭 확인해 주세요")
                    .lineLimit(1)
                    .font(.Caption)
                    .foregroundColor(.mainLightActive)
                    .padding(.bottom, 40)
                    .padding(.horizontal, 16)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        VStack {
                            Text("\(fromPoint.region) 스위포인트")
                                .font(.Headline)
                                .foregroundColor(.white)

                            Image("swipay_card_ex1")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 202 * Constants.ControlWidth, height: 320.33 * Constants.ControlHeight)
                                .padding(.bottom, 6 * Constants.ControlHeight)

                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 202 * Constants.ControlWidth, height: 60 * Constants.ControlHeight)
                                .foregroundColor(exchangeInputText.isEmpty ? .greyNormal : .greyDark)
                                .overlay {
                                    Text(exchangeInputText.isEmpty ?
                                         "\(fromPoint.point) 원" : "\(fromPoint.point - exchangeInputInt) 원")
                                        .font(.Headline)
                                        .foregroundColor(.mainLightHover)
                                        .strikethrough(exchangeInputText.isEmpty ? false : true, color: .mainLightHover)
                                }
                        }

                        Image("connect_line")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 73 * Constants.ControlWidth, height: 173 * Constants.ControlHeight)
                            .padding(.horizontal, -4)
                            .padding(.bottom, 90)

                        VStack {
                            Text("\(toPoint.region) 스위포인트")
                                .font(.Headline)
                                .foregroundColor(.white)

                            Image("swipay_card_ex1")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 202 * Constants.ControlWidth, height: 320.33 * Constants.ControlHeight)
                                .padding(.bottom, 6 * Constants.ControlHeight)

                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 202 * Constants.ControlWidth, height: 60 * Constants.ControlHeight)
                                .foregroundColor(exchangeInputText.isEmpty ? .greyDark : .mainNormalHover)
                                .overlay {
                                    Text(exchangeInputText.isEmpty
                                         ? "\(toPoint.point) 원" : "\(toPoint.point + exchangeInputInt) 원")
                                        .font(.Headline)
                                        .foregroundColor(.mainLightHover)
                                }
                        }
                    }
                    .padding(.horizontal, 16)
                }

                Spacer()

                HStack {
                    Spacer()

                    VStack {
                        if !exchangeInputText.isEmpty {
                            Text("환전 후 포인트 잔액 \(fromPoint.point - exchangeInputInt)원")
                                .lineLimit(1)
                                .font(.Subhead1)
                                .foregroundColor(.white.opacity(0.56))
                                .padding(.bottom, 8)
                        }

                        Button(action: {
                            if !exchangeInputText.isEmpty && fromPoint.point >= exchangeInputInt {
                                exchangeModal = true
                            }
                        }, label: {
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 360 * Constants.ControlWidth,
                                       height: 54 * Constants.ControlHeight)
                                .foregroundColor(exchangeInputText.isEmpty || fromPoint.point < exchangeInputInt
                                                 ? .mainLightActive : .mainNormal)
                                .overlay {
                                    if !exchangeInputText.isEmpty {
                                        Text("\(exchangeInputText)원 환전하기")
                                            .foregroundColor(.white)
                                            .font(.Subhead3)
                                    } else {
                                        Text("환전하기")
                                            .foregroundColor(.white)
                                            .font(.Subhead3)
                                    }
                                }
                        })
                    }

                    Spacer()
                }
            }

            VStack(spacing: 0) {
                Spacer()

                Button(action: {
                    isTipHidden = false
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
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $exchangeModal, content: {
            SwipointExchangeModal(exchangeModal: $exchangeModal, completeModal: $completeModal)
                .background(ClearBackgroundView()) // 팝업 뷰 height 조절
                .presentationDetents([.height(232 * Constants.ControlHeight)])
        })
        .sheet(isPresented: $completeModal, content: {
            SwipointExchangeCompleteModal(
                completeModal: $completeModal,
                onComplete: { dismiss() }
            )
                .background(ClearBackgroundView()) // 팝업 뷰 height 조절
                .presentationDetents([.height(388 * Constants.ControlHeight)])
        })
    }

    private func formatPrice(_ value: String) -> String {
        guard let number = Int(value) else { return "" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
}

#Preview {
    SwipointExchangeView(viewModel: SwipayViewModel())
}
