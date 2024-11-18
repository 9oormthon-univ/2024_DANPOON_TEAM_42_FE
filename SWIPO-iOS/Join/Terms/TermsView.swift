//
//  TermsView.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/18/24.
//

import SwiftUI

struct TermsView: View {
    
    var howLogin: String = ""
    
    @State private var isChkAll: Bool = false
    @State private var isChkAllModal: Bool = false
    
    @State private var isChkTerm1: Bool = false
    @State private var isChkTerm1Modal: Bool = false
    
    @State private var isChkTerm2: Bool = false
    @State private var isChkTerm2Modal: Bool = false
    
    @State private var isChkTerm3: Bool = false
    @State private var isChkTerm3Modal: Bool = false
    
    @State private var isChkTerm4: Bool = false
    @State private var isChkTerm4Modal: Bool = false
    
    @State private var isChkTerm5: Bool = false
    @State private var isChkTerm5Modal: Bool = false
    
    @State private var isChkTerm6: Bool = false
    @State private var isChkTerm6Modal: Bool = false
    
    
    var body: some View {
        
        ZStack{
            VStack(spacing: 0){
                
                HStack(spacing: 0){
                    Text("서비스 이용을 위해 \n 이용약관에 동의해 주세요")
                        .multilineTextAlignment(.leading)
                        .font(.Display1)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding()
                
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: 360 * Constants.ControlWidth, height: 60 * Constants.ControlHeight)
                    .scaledToFit()
                    .foregroundColor(Color(hex: "171717"))
                    .overlay {
                        HStack(spacing: 0){
                            Button(action: {
                                isChkAll.toggle()
                                
                                if isChkAll {
                                    isChkTerm1 = true
                                    isChkTerm2 = true
                                    isChkTerm3 = true
                                    isChkTerm4 = true
                                    isChkTerm5 = true
                                    isChkTerm6 = true
                                } else {
                                    isChkTerm1 = false
                                    isChkTerm2 = false
                                    isChkTerm3 = false
                                    isChkTerm4 = false
                                    isChkTerm5 = false
                                    isChkTerm6 = false
                                }
                            }, label: {
                                Image(isChkAll == false ? "term_all_btn" : "term_all_btn_color")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 26 * Constants.ControlWidth, height: 26 * Constants.ControlHeight)
                            })
                            
                            Text("전체 동의")
                                .font(.Headline)
                                .foregroundColor(Color(hex: "C1C1C1"))
                                .padding(.leading, 8 * Constants.ControlWidth)
                            
                            Spacer()
                            
                            Button(action: {
                                isChkAllModal.toggle()
                            }, label: {
                                Image("term_see_btn")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24 * Constants.ControlWidth, height: 24 * Constants.ControlHeight)
                            })
                        }
                        .padding(.top)
                        .padding(.trailing, 22 * Constants.ControlWidth)
                        .padding(.leading, 22 * Constants.ControlWidth)
                        .padding(.bottom)
                    }
                    .padding(.bottom, 24 * Constants.ControlHeight)
                    .sheet(isPresented: $isChkAllModal) {
                        
                    }
                

                HStack(spacing: 0){
                    Button(action: {
                        isChkTerm1.toggle()
                    }, label: {
                        HStack(spacing: 0){
                            Image(isChkTerm1 == false ? "term_chk_btn" : "term_chk_btn_color")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24 * Constants.ControlWidth, height: 24 * Constants.ControlHeight)
                            
                            Text("[필수] sweep 서비스 이용약관")
                                .font(.Body2)
                                .foregroundColor(isChkTerm1 == false ? Color(hex: "C1C1C1") : Color.white)
                            
                            Spacer()
                        }
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        isChkTerm1Modal.toggle()
                    }, label: {
                        Image("term_see_btn")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24 * Constants.ControlWidth, height: 24 * Constants.ControlHeight)
                    })
                }
                .padding()
                .sheet(isPresented: $isChkTerm1Modal) {
                    
                }
                
                HStack(spacing: 0){
                    Button(action: {
                        isChkTerm2.toggle()
                    }, label: {
                        HStack(spacing: 0){
                            Image(isChkTerm2 == false ? "term_chk_btn" : "term_chk_btn_color")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24 * Constants.ControlWidth, height: 24 * Constants.ControlHeight)
                            
                            Text("[필수] 전자금융거래 이용약관")
                                .font(.Body2)
                                .foregroundColor(isChkTerm2 == false ? Color(hex: "C1C1C1") : Color.white)
                            
                            Spacer()
                        }
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        isChkTerm2Modal.toggle()
                    }, label: {
                        Image("term_see_btn")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24 * Constants.ControlWidth, height: 24 * Constants.ControlHeight)
                    })
                }
                .padding()
                .sheet(isPresented: $isChkTerm2Modal) {
                    
                }
                
                HStack(spacing: 0){
                    Button(action: {
                        isChkTerm3.toggle()
                    }, label: {
                        HStack(spacing: 0){
                            Image(isChkTerm3 == false ? "term_chk_btn" : "term_chk_btn_color")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24 * Constants.ControlWidth, height: 24 * Constants.ControlHeight)
                            
                            Text("[필수]  개인정보 수집 및 동의")
                                .font(.Body2)
                                .foregroundColor(isChkTerm3 == false ? Color(hex: "C1C1C1") : Color.white)
                            
                            Spacer()
                        }
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        isChkTerm3Modal.toggle()
                    }, label: {
                        Image("term_see_btn")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24 * Constants.ControlWidth, height: 24 * Constants.ControlHeight)
                    })
                }
                .padding()
                .sheet(isPresented: $isChkTerm3Modal) {
                    
                }
                
                HStack(spacing: 0){
                    Button(action: {
                        isChkTerm4.toggle()
                    }, label: {
                        HStack(spacing: 0){
                            Image(isChkTerm4 == false ? "term_chk_btn" : "term_chk_btn_color")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24 * Constants.ControlWidth, height: 24 * Constants.ControlHeight)
                            
                            Text("[필수]  개인정보처리 위탁 동의")
                                .font(.Body2)
                                .foregroundColor(isChkTerm4 == false ? Color(hex: "C1C1C1") : Color.white)
                            
                            Spacer()
                        }
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        isChkTerm4Modal.toggle()
                    }, label: {
                        Image("term_see_btn")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24 * Constants.ControlWidth, height: 24 * Constants.ControlHeight)
                    })
                }
                .padding()
                .sheet(isPresented: $isChkTerm4Modal) {
                    
                }
                
                HStack(spacing: 0){
                    Button(action: {
                        isChkTerm5.toggle()
                    }, label: {
                        HStack(spacing: 0){
                            Image(isChkTerm5 == false ? "term_chk_btn" : "term_chk_btn_color")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24 * Constants.ControlWidth, height: 24 * Constants.ControlHeight)
                            
                            Text("[필수]  개인정보 제3자 제공 동의")
                                .font(.Body2)
                                .foregroundColor(isChkTerm5 == false ? Color(hex: "C1C1C1") : Color.white)
                            
                            Spacer()
                        }
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        isChkTerm5Modal.toggle()
                    }, label: {
                        Image("term_see_btn")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24 * Constants.ControlWidth, height: 24 * Constants.ControlHeight)
                    })
                }
                .padding()
                .sheet(isPresented: $isChkTerm5Modal) {
                    
                }
                
                HStack(spacing: 0){
                    Button(action: {
                        isChkTerm6.toggle()
                    }, label: {
                        HStack(spacing: 0){
                            Image(isChkTerm6 == false ? "term_chk_btn" : "term_chk_btn_color")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24 * Constants.ControlWidth, height: 24 * Constants.ControlHeight)
                            
                            Text("[선택]  마케팅(이벤트/혜택) 정보 수신 동의")
                                .font(.Body2)
                                .foregroundColor(isChkTerm6 == false ? Color(hex: "C1C1C1") : Color.white)
                            
                            Spacer()
                        }
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        isChkTerm6Modal.toggle()
                    }, label: {
                        Image("term_see_btn")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24 * Constants.ControlWidth, height: 24 * Constants.ControlHeight)
                    })
                }
                .padding()
                .sheet(isPresented: $isChkTerm6Modal) {
                    
                }
                
                
                Spacer()
                
                Button(action: {
                    if chkTerm() {
                        
                    }
                }, label: {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 360 * Constants.ControlWidth, height: 54 * Constants.ControlHeight)
                        .scaledToFit()
                        .foregroundColor(chkTerm() == false ? Color(hex: "C8C8FE") : Color(hex: "4F4FFD"))
                        .overlay {
                            Text("동의하기")
                                .foregroundColor(Color.white)
                                .font(.Subhead3)
                        }
                })
                
            }
        }
        .toolbar(.hidden)
    }
    
    func chkTerm() -> Bool {
        if isChkTerm1 && isChkTerm2 && isChkTerm3 && isChkTerm4 && isChkTerm5 {
            return true
        } else {
            return false
        }
    }
    
}

#Preview {
    TermsView()
}
