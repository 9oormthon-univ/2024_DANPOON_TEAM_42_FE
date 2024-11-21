//
//  AgencyView.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/21/24.
//

import SwiftUI

struct AgencyView: View {
    @Binding var agencyModal: Bool
    @Binding var agency: String
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 28)
                .frame(width: 374 * Constants.ControlWidth, height: 452 * Constants.ControlHeight)
                .scaledToFit()
                .overlay {
                    VStack(spacing: 0){
                        Rectangle()
                            .frame(width: 50 * Constants.ControlWidth, height: 5 * Constants.ControlHeight)
                            .scaledToFit()
                            .foregroundColor(Color(hex: "E5E8EB"))
                            .padding()
                        
                        HStack(spacing: 0) {
                            Text("통신사를 선택해 주세요")
                                .font(.Headline)
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Button(action: {
                                agencyModal.toggle()
                            }, label: {
                                Image("agency_close")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24 * Constants.ControlWidth, height: 24 * Constants.ControlHeight)
                            })
                        }
                        .padding(.top)
                        .padding(.trailing, 24 * Constants.ControlWidth)
                        .padding(.leading, 24 * Constants.ControlWidth)
                        .padding(.bottom)
                        
                        HStack(spacing: 0) {
                            Button(action: {
                                agencyModal.toggle()
                                agency = "SKT"
                            }, label: {
                                Text("SKT")
                                    .font(.Body2)
                                    .foregroundColor(.black)
                            })
                            
                            Spacer()
                        }
                        .padding(.top)
                        .padding(.trailing, 24 * Constants.ControlWidth)
                        .padding(.leading, 24 * Constants.ControlWidth)
                        .padding(.bottom)
                        
                        HStack(spacing: 0) {
                            Button(action: {
                                agencyModal.toggle()
                                agency = "KT"
                            }, label: {
                                Text("KT")
                                    .font(.Body2)
                                    .foregroundColor(.black)
                            })
                            
                            Spacer()
                        }
                        .padding(.top)
                        .padding(.trailing, 24 * Constants.ControlWidth)
                        .padding(.leading, 24 * Constants.ControlWidth)
                        .padding(.bottom)
                        
                        HStack(spacing: 0) {
                            Button(action: {
                                agencyModal.toggle()
                                agency = "LG U+"
                            }, label: {
                                Text("LG U+")
                                    .font(.Body2)
                                    .foregroundColor(.black)
                            })
                            
                            Spacer()
                        }
                        .padding(.top)
                        .padding(.trailing, 24 * Constants.ControlWidth)
                        .padding(.leading, 24 * Constants.ControlWidth)
                        .padding(.bottom)
                        
                        HStack(spacing: 0) {
                            Button(action: {
                                agencyModal.toggle()
                                agency = "SKT 알뜰폰"
                            }, label: {
                                Text("SKT 알뜰폰")
                                    .font(.Body2)
                                    .foregroundColor(.black)
                            })
                            
                            Spacer()
                        }
                        .padding(.top)
                        .padding(.trailing, 24 * Constants.ControlWidth)
                        .padding(.leading, 24 * Constants.ControlWidth)
                        .padding(.bottom)
                        
                        HStack(spacing: 0) {
                            Button(action: {
                                agencyModal.toggle()
                                agency = "KT 알뜰폰"
                            }, label: {
                                Text("KT 알뜰폰")
                                    .font(.Body2)
                                    .foregroundColor(.black)
                            })
                            
                            Spacer()
                        }
                        .padding(.top)
                        .padding(.trailing, 24 * Constants.ControlWidth)
                        .padding(.leading, 24 * Constants.ControlWidth)
                        .padding(.bottom)
                        
                        HStack(spacing: 0) {
                            Button(action: {
                                agencyModal.toggle()
                                agency = "LG U+ 알뜰폰"
                            }, label: {
                                Text("LG U+ 알뜰폰")
                                    .font(.Body2)
                                    .foregroundColor(.black)
                            })
                            
                            Spacer()
                        }
                        .padding(.top)
                        .padding(.trailing, 24 * Constants.ControlWidth)
                        .padding(.leading, 24 * Constants.ControlWidth)
                        .padding(.bottom)
                        
                        
                        Spacer()
                    }
                }
                
        }
        .frame(width: 374 * Constants.ControlWidth, height: 452 * Constants.ControlHeight)
        .background(Color.clear)
    }
}

#Preview {
    AgencyView(agencyModal: .constant(true), agency: .constant(""))
}
