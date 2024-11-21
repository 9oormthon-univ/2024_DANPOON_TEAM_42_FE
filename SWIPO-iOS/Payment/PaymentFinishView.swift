//
//  PaymentFinishView.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/21/24.
//
import SwiftUI

struct PaymentFinishView: View {

    @Binding var paymentModal: Bool
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 28)
                .frame(width: 367 * Constants.ControlWidth, height: 468 * Constants.ControlHeight)
                .overlay {
                    VStack(spacing: 0){
                        Rectangle()
                            .frame(width: 50 * Constants.ControlWidth, height: 5 * Constants.ControlHeight)
                            .foregroundColor(Color(hex: "E5E8EB"))
                            .padding(.top)
                            .padding(.bottom, 10 * Constants.ControlHeight)
                        
                        Image("payment_piece")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 76 * Constants.ControlWidth, height: 76 * Constants.ControlHeight)
                        
                        Text("결제 완료")
                            .font(.Headline)
                            .foregroundColor(.greyDarkHover)
                            .padding(.top)
                            .padding(.bottom, 8 * Constants.ControlHeight)
                        
                        Text("부산 스윕스톤을 획득 했어요!\n스윕스톤을 모아 추가 포인트를 획득하세요!")
                            .font(.Subhead2)
                            .foregroundColor(.greyLightActive)
                            .multilineTextAlignment(.center)
                        
                        HStack(spacing: 0){
                            Text("총 결제 금액")
                                .font(.Headline)
                                .foregroundColor(.greyDarkHover)
                            
                            Spacer()
                            
                            Text("62,776원")
                                .font(.Headline)
                                .foregroundColor(.mainNormal)
                        }
                        .padding(.top, 36 * Constants.ControlHeight)
                        .padding(.leading)
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.trailing)
                        
                        HStack(spacing: 0){
                            Text("얻은 포인트")
                                .font(.Headline)
                                .foregroundColor(.greyDarkHover)
                            
                            Spacer()
                            
                            Text("1,298원")
                                .font(.Headline)
                                .foregroundColor(.mainNormal)
                        }
                        .padding(.top)
                        .padding(.leading)
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.trailing)
                        
                        HStack(spacing: 0){
                            Text("스위페이 잔액")
                                .font(.Headline)
                                .foregroundColor(.greyDarkHover)
                            
                            Spacer()
                            
                            Text("19,821원")
                                .font(.Headline)
                                .foregroundColor(.mainNormal)
                        }
                        .padding()
                        .padding(.leading)
                        .padding(.trailing)
                        
                        Button(action: {
                            paymentModal.toggle()
                        }, label: {
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 319 * Constants.ControlWidth, height: 54 * Constants.ControlHeight)
                                .foregroundColor(.mainNormal)
                                .overlay {
                                    Text("확인")
                                        .font(.Subhead3)
                                        .foregroundColor(.white)
                                }
                                .padding(.top, 46 * Constants.ControlHeight)
                        })
                        
                        Spacer()
                    }
                }
                
        }
        .frame(width: 374 * Constants.ControlWidth, height: 452 * Constants.ControlHeight)
        .background(Color.clear)
        .toolbar(.hidden)
    }
}

#Preview {
    PaymentFinishView(paymentModal: .constant(false))
}
