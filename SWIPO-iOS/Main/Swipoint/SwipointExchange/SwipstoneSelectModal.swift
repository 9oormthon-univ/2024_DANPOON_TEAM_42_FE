//
//  SwipstoneSelectModal.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/22/24.
//

import SwiftUI

struct SwipstoneSelectModal: View {

    @ObservedObject var exchangeViewModel: SwipointExchangeViewModel
    @ObservedObject var viewModel: SwipointViewModel

    @Binding var pointExchangeModal: Bool
    @Binding var closeModal: Bool
    @Binding var region: String
    @Binding var newCardModal: Bool
    @Binding var existenceCardModal: Bool
    @Binding var selectedCardID: String
    @State var currentSelectdCardId: String = ""
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 28)
                .frame(width: 374 * Constants.ControlWidth, height: 740 * Constants.ControlHeight)
                .overlay {
                    VStack(spacing: 0) {
                        Rectangle()
                            .frame(width: 50 * Constants.ControlWidth, height: 5 * Constants.ControlHeight)
                            .foregroundColor(Color(hex: "E5E8EB"))
                            .padding(.top, 11 * Constants.ControlHeight)
                            .padding(.bottom, 24 * Constants.ControlHeight)
                        
                        VStack(alignment: .leading) {
                            HStack(spacing: 0){
                                Text("다른 지역으로 떠나셨군요!")
                                    .frame(height: 28 * Constants.ControlHeight)
                                    .font(.Headline)
                                    .foregroundColor(.greyDarkHover)
                                    .padding(.bottom, 4)
                                
                                Image("island")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20 * Constants.ControlWidth)
                                    .padding(.bottom, 4)
                                
                                Spacer()
                            }
                            .padding(.top)
                            .padding(.leading)
                            
                            Text("등록하지 않은 지역은 표시되지 않아요!")
                                .font(.Headline)
                                .lineSpacing(4)
                                .foregroundColor(.greyNormal)
                                .padding(.leading)
                        }
                        .padding(.bottom, 24)


                        SwipstoneSelectListView(exchangeViewModel: exchangeViewModel, selectedCardID: $selectedCardID, currentSelectdCardId: $currentSelectdCardId)
                            .padding(.horizontal, 24)

                        HStack {
                            Button(action: {
                                closeModal = false
                            }, label: {
                                RoundedRectangle(cornerRadius: 16)
                                    .frame(width: 159 * Constants.ControlWidth,
                                           height: 54 * Constants.ControlHeight)
                                    .foregroundColor(.greyLighter)
                                    .overlay {
                                        Text("취소하기")
                                            .font(.Subhead3)
                                            .foregroundColor(Color(hex: "A7A7A7"))
                                    }
                            })

                            Spacer()

                            Button(action: {
                                if let toCard = exchangeViewModel.state.getSwipointCardResponse.cards.first(where: { $0.cardId == currentSelectdCardId }),
                                       let fromCard = exchangeViewModel.state.getSwipointCardResponse.cards.first(where: { $0.cardId == selectedCardID }) {
                                    AppState.shared.navigationPath.append(swipointType.exchange(from: fromCard, to: toCard))
                                        pointExchangeModal = false
                                    } else {
                                        print("Error: Could not find fromCard or toCard")
                                    }
                            }, label: {
                                RoundedRectangle(cornerRadius: 16)
                                    .frame(width: 159 * Constants.ControlWidth, height: 54 * Constants.ControlHeight)
                                    .foregroundColor(.mainNormal)
                                    .overlay {
                                        Text("환전하기")
                                            .font(.Subhead3)
                                            .foregroundColor(.white)
                                    }
                            })
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 24)
                        .padding(.bottom, 28 * Constants.ControlHeight)
                    }
                }
                
        }
        .toolbar(.hidden)
        .background(Color.clear)
    }
}

#Preview {
    SwipstoneSelectModal(exchangeViewModel: SwipointExchangeViewModel(), viewModel: SwipointViewModel(),
                          pointExchangeModal: .constant(false),
                          closeModal: .constant(false),
                          region: .constant(""),
                          newCardModal: .constant(false),
                         existenceCardModal: .constant(false), selectedCardID: .constant(""))
}

