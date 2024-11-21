//
//  JoinView.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/21/24.
//

import SwiftUI
import CoreLocation
import Combine

struct JoinView: View {
    @StateObject private var geoServiceManager = GeoServiceManager()
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                NavigationBar(title: "회원가입", showBackButton: true)
                
                JoinMainView(geoServiceManager: geoServiceManager)
                Spacer()
            }
        }
        .toolbar(.hidden)
        .alert(isPresented: $geoServiceManager.showAlert) {
            Alert(
                title: Text("위치 접근 권한이 필요합니다"),
                message: Text("앱 설정으로 가서 위치 접근 권한을 허용해 주세요."),
                primaryButton: .cancel(Text("취소")),
                secondaryButton: .default(Text("설정하기"), action: {
                    // 설정 화면으로 이동
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                })
            )
        }
    }
}

struct JoinMainView: View {
    
    @ObservedObject var geoServiceManager: GeoServiceManager
    
    @State private var isChk: Bool = false
    @State private var isChkModal: Bool = false
    @State var name: String = ""
    @State var address: String = ""
    @State var birth1: String = ""
    @State var birth2: String = ""
    
    @State var agencyModal: Bool = false
    @State var agency: String = ""
    
    @State var phone: String = ""
    @State var number: String = ""
    
    @State private var remainingTime = 180 // 3분 (180초)
    @State private var timer: AnyCancellable? = nil
    
    var body: some View {
        ScrollView{
            VStack(spacing: 0) {
                
                HStack(spacing: 0) {
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
                
                HStack(spacing: 0){
                    Text("이름")
                        .font(.Body1)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding()
                
                HStack(spacing: 0){
                    
                    TextField("", text: $name)
                        .font(.Headline)
                        .foregroundColor(.white)
                        .overlay {
                            HStack(spacing: 0){
                                Text(name == "" ? "최대 40자 입력" : "")
                                    .font(.Headline)
                                    .foregroundColor(Color(hex: "6F6F6F"))
                                    .allowsHitTesting(false)
                                
                                Spacer()
                            }
                        }
                    
                    
                    Spacer()
                }
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom, 5 * Constants.ControlHeight)
                
                Rectangle()
                    .frame(width: 360 * Constants.ControlWidth, height: 1)
                    .scaledToFit()
                    .foregroundColor(Color(hex: "242424"))
                
                HStack(spacing: 0){
                    if name.count != 0 && name.count < 2 || name.count > 10 {
                        Text("2글자 이상 10글자 미만으로 작성해 주세요")
                            .font(.Caption)
                            .foregroundColor(Color(hex: "FF6636"))
                    } else if koreaLangChk(name) == false{
                        Text("특수문자, 영문자, 숫자는 사용이 불가능해요")
                            .font(.Caption)
                            .foregroundColor(Color(hex: "FF6636"))
                    }
                    
                    Spacer()
                }
                .padding(.leading)
                .padding(.top, 9 * Constants.ControlHeight)
                
                HStack(spacing: 0) {
                    Text("거주지")
                        .font(.Body1)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding()
                
                HStack(spacing: 0) {
                    Button(action: {
                        geoServiceManager.convertToAddress { addressResult in
                            address = addressResult
                            print("주소: \(addressResult)")
                        }
                    }, label: {
                        Text(address.isEmpty ? "" : address)
                            .font(.Headline)
                            .foregroundColor(address.isEmpty ? Color(hex: "6F6F6F") : .white)
                    })
                    
                    Spacer()
                }
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom, 5 * Constants.ControlHeight)
                
                Rectangle()
                    .frame(width: 360 * Constants.ControlWidth, height: 1)
                    .scaledToFit()
                    .foregroundColor(Color(hex: "242424"))
                
                HStack(spacing: 0){
                    Text("마이페이지에서 수정할 수 있어요")
                        .font(.Caption)
                        .foregroundColor(Color(hex: "C8C8FE"))
                    
                    Spacer()
                }
                .padding(.leading)
                .padding(.top, 9 * Constants.ControlHeight)
                
                HStack(spacing: 0) {
                    Text("생년월일")
                        .font(.Body1)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding()
                
                HStack(spacing: 0){
                    
                    TextField("", text: $birth1)
                        .keyboardType(.decimalPad)
                        .font(.Headline)
                        .frame(width: 160 * Constants.ControlWidth)
                        .foregroundColor(.white)
                        .overlay {
                            HStack(spacing: 0){
                                Text(birth1 == "" ? "생년월일 6자리" : "")
                                    .font(.Headline)
                                    .foregroundColor(Color(hex: "6F6F6F"))
                                    .allowsHitTesting(false)
                                
                                Spacer()
                            }
                        }
                    
                    Text(" - ")
                        .font(.Headline)
                        .foregroundColor(Color(hex: "6F6F6F"))
                        .padding(.leading)
                    
                    
                    TextField("", text: $birth2)
                        .keyboardType(.decimalPad)
                        .font(.Headline)
                        .foregroundColor(.clear)
                        .overlay {
                            HStack(spacing: 0){
                                Image(birth2 == "" ? "join_birth_blank" : "join_birth")
                                    .scaledToFit()
                                    .allowsHitTesting(false)
                                Spacer()
                            }
                        }
                        .padding(.leading)
                }
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom, 5 * Constants.ControlHeight)
                
                HStack(spacing: 0){
                    Rectangle()
                        .frame(width: 160 * Constants.ControlWidth, height: 1)
                        .scaledToFit()
                        .foregroundColor(Color(hex: "242424"))
                    
                    Spacer()
                }
                .padding(.leading)
                
                if birth1.count == 6 && ageChk(Int(birth1) ?? 0) == false {
                    HStack(spacing: 0){
                        Text("만 14세 이상인 분들만 가입할 수 있어요")
                            .font(.Caption)
                            .foregroundColor(Color(hex: "FF6636"))
                        
                        Spacer()
                    }
                    .padding(.leading)
                    .padding(.top, 9 * Constants.ControlHeight)
                } else {
                    HStack(spacing: 0){
                        Text("만 14세 이상인 분들만 가입할 수 있어요")
                            .font(.Caption)
                            .foregroundColor(Color(hex: "C8C8FE"))
                        
                        Spacer()
                    }
                    .padding(.leading)
                    .padding(.top, 9 * Constants.ControlHeight)
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
                        ageChk(Int(birth1) ?? 0)
                        startTimer()
                    }, label: {
                        RoundedRectangle(cornerRadius: 6)
                            .frame(width: 66 * Constants.ControlWidth, height: 32 * Constants.ControlHeight)
                            .scaledToFit()
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
                    .padding(.bottom, 76 * Constants.ControlHeight)
                
                Button(action: {
                    if chkJoin(){
                        AppState.shared.navigationPath.append(joinType.password)
                    }
                }, label: {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 360 * Constants.ControlWidth, height: 54 * Constants.ControlHeight)
                        .scaledToFit()
                        .foregroundColor(chkJoin() == false ? Color(hex: "C8C8FE") : Color(hex: "4F4FFD"))
                        .overlay {
                            Text("본인 인증하기")
                                .foregroundColor(Color.white)
                                .font(.Subhead3)
                        }
                })
                
            }
            .onAppear {
                geoServiceManager.onAddressUpdate = { addressResult in
                    address = addressResult // 주소 업데이트
                    print("주소: \(addressResult)")
                }
            }
            .navigationDestination(for: joinType.self) { view in
                switch view{
                case .password:
                    PasswordView(usage: "설정", paymentModal: .constant(false))
                }
            }
        }
        .scrollIndicators(.hidden)
    }
    
    private func fetchCurrentLocation() {
        do {
            try geoServiceManager.requestLocation()
        } catch GeoError.accessRestricted {
            address = "위치 접근이 제한되었습니다."
        } catch GeoError.accessDenied {
            // 위치 접근 권한이 거부되었을 때 showAlert를 true로 설정하여 알림을 띄움
        } catch {
            address = "알 수 없는 오류가 발생했습니다."
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
    
    func chkJoin() -> Bool {
        if name == "" || address == "" || birth1 == "" || birth2 == "" || agency == "" || phone == "" || number == "" {
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
    
    //한글 입력인지 확인
    func koreaLangChk(_ input: String) -> Bool {
        let pattern = "^[ㄱ-ㅎ가-힣\\s]*$"
        if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
            let range = NSRange(location: 0, length: input.utf16.count)
            if regex.firstMatch(in: input, options: [], range: range) != nil {
                return true
            }
        }
        return false
    }
    
    func ageChk(_ input: Int) -> Bool{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let current_date_string = formatter.string(from: Date())
        let year1 = (Int(current_date_string) ?? 0 % 1000000) / 10000 //2024
        let year2 = year1 % 100 //24
        
        var inputYear = input / 10000
        var inputDate = input % 10000
        var compareBirth = year1 * 10000 + inputDate
        
        if inputYear > year2 {
            inputYear = 1900 + inputYear
        } else {
            inputYear = 2000 + inputYear
        }
        
        var age = year1 - inputYear
        
        if Int(current_date_string) ?? 0 <= compareBirth {
            age -= 1
        }

        if age >= 14 {
            return true
        } else {
            return false
        }
    }
    
    // 시간을 "MM:SS" 형식으로 변환하는 함수
    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    enum joinType{
        case password
    }
}

#Preview {
    JoinView()
}

