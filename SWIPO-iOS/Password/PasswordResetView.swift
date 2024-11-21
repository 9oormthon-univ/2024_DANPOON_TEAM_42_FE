//
//  PasswordResetView.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/21/24.
//

import SwiftUI
import Combine

struct PasswordResetView: View {
    @Binding var resetFinishModal: Bool
    
    var body: some View {
        ZStack{
            
            VStack(spacing: 0){
                NavigationBar(title: "간편 비밀번호 재설정", showBackButton: true)
                
                PasswordResetMainView()
                
                Spacer()
            }
        }
        .toolbar(.hidden)
        .navigationDestination(for: passwordResetType.self) { view in
            switch view{
            case .reset:
                PasswordView(usage: "재설정", paymentModal: .constant(false))
            }
        }
        .ignoresSafeArea(.keyboard)
    }
    
    struct ClearBackgroundView: UIViewRepresentable {
        func makeUIView(context: Context) -> some UIView {
            let view = UIView()
            DispatchQueue.main.async {
                view.superview?.superview?.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            }
            return view
        }
        func updateUIView(_ uiView: UIViewType, context: Context) {
        }
    }

    struct ClearBackgroundViewModifier: ViewModifier {
        
        func body(content: Content) -> some View {
            content
                .background(ClearBackgroundView())
        }
    }
}

struct PasswordResetMainView: View {
    @State private var isChk: Bool = false
    @State private var isChkModal: Bool = false
    
    @State var agencyModal: Bool = false
    @State var agency: String = ""
    
    @State var phone: String = ""
    @State var number: String = ""
    
    @State private var remainingTime = 180 // 3분 (180초)
    @State private var timer: AnyCancellable? = nil
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                
                HStack(spacing: 0){
                    Text("본인인증을 진행해 주세요")
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
                                isChk.toggle()
                            }, label: {
                                Image(isChk == false ? "term_all_btn" : "term_all_btn_color")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 26 * Constants.ControlWidth, height: 26 * Constants.ControlHeight)
                            })
                            
                            Text("휴대폰 본인 확인 전체 동의")
                                .font(.Headline)
                                .foregroundColor(Color(hex: "C1C1C1"))
                                .padding(.leading, 8 * Constants.ControlWidth)
                            
                            Spacer()
                            
                            Button(action: {
                                isChkModal.toggle()
                            }, label: {
                                Image("term_see_btn")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24 * Constants.ControlWidth, height: 24 * Constants.ControlHeight)
                            })
                        }
                        .padding()
                    }
                    .padding(.bottom, 24 * Constants.ControlHeight)
                    .sheet(isPresented: $isChkModal) {
                        WebView(url: URL(string: "https://attractive-reason-70a.notion.site/1363d7dd9ab0803eab58d135b8725ede?pvs=4")!)
                    }
                
                HStack(spacing: 0) {
                    Text("통신사")
                        .font(.Body1)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding()
                
                HStack(spacing: 0){
                    
                    Text(agency == "" ? "통신사 선택" : agency)
                        .font(.Headline)
                        .foregroundColor(agency == "" ? Color(hex: "6F6F6F") : Color.white)
                        .allowsHitTesting(false)
                    
                    
                    Spacer()
                    
                    Button(action: {
                        agencyModal.toggle()
                    }, label: {
                        Image("join_choose")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24 * Constants.ControlWidth, height: 24 * Constants.ControlHeight)
                    })
                }
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom, 5 * Constants.ControlHeight)
                .sheet(isPresented: $agencyModal) {
                    AgencyView(agencyModal: $agencyModal, agency: $agency)
                        .background(ClearBackgroundView())// 팝업 뷰 height 조절
                        .presentationDetents([.height(452 * Constants.ControlHeight)])
                }
                
                Rectangle()
                    .frame(width: 360 * Constants.ControlWidth, height: 1)
                    .foregroundColor(Color(hex: "242424"))
                
                HStack(spacing: 0) {
                    Text("휴대폰 번호")
                        .font(.Body1)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding()
                
                HStack(spacing: 0){
                    
                    TextField("", text: $phone)
                        .keyboardType(.decimalPad)
                        .font(.Headline)
                        .foregroundColor(.white)
                        .overlay {
                            HStack(spacing: 0){
                                Text(phone == "" ? "숫자만 입력" : "")
                                    .font(.Headline)
                                    .foregroundColor(Color(hex: "6F6F6F"))
                                    .allowsHitTesting(false)
                                
                                Spacer()
                            }
                        }
                    
                    
                    Spacer()
                    
                    
                    Button(action: {
                        startTimer()
                    }, label: {
                        RoundedRectangle(cornerRadius: 6)
                            .frame(width: 66 * Constants.ControlWidth, height: 32 * Constants.ControlHeight)
                            .foregroundColor(Color(hex: "242424"))
                            .overlay {
                                Text("인증요청")
                                    .font(.Body1)
                                    .foregroundColor(Color(hex: "C1C1C1"))
                            }
                    })
                }
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom, 5 * Constants.ControlHeight)
                
                Rectangle()
                    .frame(width: 360 * Constants.ControlWidth, height: 1)
                    .foregroundColor(Color(hex: "242424"))
                
                HStack(spacing: 0) {
                    Text("인증번호")
                        .font(.Body1)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding()
                
                HStack(spacing: 0){
                    
                    TextField("", text: $number)
                        .keyboardType(.decimalPad)
                        .font(.Headline)
                        .foregroundColor(.white)
                        .overlay {
                            HStack(spacing: 0){
                                Text(number == "" ? "인증번호 입력" : "")
                                    .font(.Headline)
                                    .foregroundColor(Color(hex: "6F6F6F"))
                                    .allowsHitTesting(false)
                                
                                Spacer()
                            }
                        }
                    
                    
                    Spacer()
                    
                    Text(formatTime(remainingTime))
                        .font(.Caption)
                        .foregroundColor(Color(hex: "6F6F6F"))
                }
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom, 5 * Constants.ControlHeight)
                
                Rectangle()
                    .frame(width: 360 * Constants.ControlWidth, height: 1)
                    .foregroundColor(Color(hex: "242424"))
    
                
                Spacer()
                
                Button(action: {
                    if chkJoin(){
                        AppState.shared.navigationPath.append(passwordResetType.reset)
                    }
                }, label: {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 360 * Constants.ControlWidth, height: 54 * Constants.ControlHeight)
                        .foregroundColor(chkJoin() == false ? Color(hex: "C8C8FE") : Color(hex: "4F4FFD"))
                        .overlay {
                            Text("본인 인증하기")
                                .foregroundColor(Color.white)
                                .font(.Subhead3)
                        }
                })
            }
        }
        .onTapGesture {
               UIApplication.shared.endEditing()
            }
    }
    
    func chkJoin() -> Bool {
        if agency == "" || phone == "" || number == "" {
            return false
        } else {
            return true
        }
    }
    
    // 타이머 시작 함수
    private func startTimer() {
        remainingTime = 180 // 3분 설정
        timer?.cancel() // 기존 타이머 취소 (있을 경우)
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if self.remainingTime > 0 {
                    self.remainingTime -= 1
                } else {
                    self.timer?.cancel()
                }
            }
    }
    
    struct ClearBackgroundView: UIViewRepresentable {
        func makeUIView(context: Context) -> some UIView {
            let view = UIView()
            DispatchQueue.main.async {
                view.superview?.superview?.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            }
            return view
        }
        func updateUIView(_ uiView: UIViewType, context: Context) {
        }
    }
    
    struct ClearBackgroundViewModifier: ViewModifier {
        
        func body(content: Content) -> some View {
            content
                .background(ClearBackgroundView())
        }
    }
    
    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

enum passwordResetType{
    case reset
}

#Preview {
    PasswordResetView(resetFinishModal: .constant(false))
}
