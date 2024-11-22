//
//  PasswordView.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/21/24.
//

import SwiftUI

struct PasswordView: View {
    
    var usage: String = "결제"
    @Binding var paymentModal: Bool
    
    @State var resetModal: Bool = false
    @State var resetFinishModal: Bool = false
    @State var navigation: String = ""
    
    @StateObject var viewModel = JoinViewModel()
    
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                
                if usage == "설정"{
                    NavigationBar(title: "간편 비밀번호 설정", showBackButton: true)
                        .padding(.bottom, 60 * Constants.ControlHeight)
                } else if usage == "결제"{
                    NavigationBar(title: "결제하기", showBackButton: true)
                        .padding(.bottom, 60 * Constants.ControlHeight)
                } else if usage == "재설정" {
                    NavigationBar(title: "간편 비밀번호 재설정", showBackButton: true)
                        .padding(.bottom, 60 * Constants.ControlHeight)
                } else if usage == "가입" {
                    NavigationBar(title: "간편 비밀번호 재설정", showBackButton: true)
                        .padding(.bottom, 60 * Constants.ControlHeight)
                }
                
                PasswordMainView(usage: usage, paymentModal: $paymentModal, resetModal: $resetModal, resetFinishModal: $resetFinishModal)
                
                Spacer()
            }
        }
        .toolbar(.hidden)
        .navigationDestination(for: passwordType.self) { view in
            switch view{
            case .finish:
                JoinFinishView()
            case .resetPassword:
                PasswordView(usage: "재설정", paymentModal: .constant(false))
            }
        }
        .navigationDestination(for: String.self) { view in
            if view == "재설정" {
                PasswordResetView(resetFinishModal: $resetFinishModal)
            }
        }
        .sheet(isPresented: $resetFinishModal) {
            PasswordResetFinishModal(resetFinishModal: $resetFinishModal)
                .background(ClearBackgroundView())// 팝업 뷰 height 조절
                .presentationDetents([.height(272 * Constants.ControlHeight)])
        }
        .sheet(isPresented: $resetModal) {
            PasswordResetModal(resetModal: $resetModal, navigation: $navigation)
                .background(ClearBackgroundView())// 팝업 뷰 height 조절
                .presentationDetents([.height(272 * Constants.ControlHeight)])
                .onDisappear {
                    if navigation == "재설정" {
                        AppState.shared.navigationPath.append("재설정")
                    }
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
}


struct PasswordMainView: View {
    
    var usage: String = ""
    let layout: [GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    let number = [1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 0, 12]
    
    @State var password: [Int] = []
    @State var passwordChk: [Int] = []
    @State var saveChk: Bool = false
    
    @State var isfail: Bool = false
    @State var failCout: Int = 0
    
    @State var result = false
    
    @Binding var paymentModal: Bool
    @Binding var resetModal: Bool
    @Binding var resetFinishModal: Bool
    
    @StateObject var viewModel = JoinViewModel()
    
    var body: some View {
        ZStack{
            if usage == "설정"{
                VStack(spacing: 0){
                    
                    Text(password.count == 4 ? "비밀번호를 한 번 더 입력해 주세요" : "새 비밀번호를 입력해 주세요")
                        .font(.Display1)
                        .foregroundColor(.white)
                    if isfail {
                        Text("비밀번호가 일치하지 않아요")
                            .font(.Caption)
                            .foregroundColor(Color(hex: "FF6636"))
                    } else {
                        Text(" ")
                            .font(.Caption)
                    }
                    
                    
                    if saveChk {
                        HStack(spacing: 0){
                            Image(passwordChk.count >= 1 ? "password_1" : "password_blank1")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48 * Constants.ControlWidth, height: 48 * Constants.ControlHeight)
                            
                            Image(passwordChk.count >= 2 ? "password_2" : "password_blank2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48 * Constants.ControlWidth, height: 48 * Constants.ControlHeight)
                            
                            Image(passwordChk.count >= 3 ? "password_3" : "password_blank3")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48 * Constants.ControlWidth, height: 48 * Constants.ControlHeight)
                            
                            Image(passwordChk.count >= 4 ? "password_4" : "password_blank4")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48 * Constants.ControlWidth, height: 48 * Constants.ControlHeight)
                        }
                        .padding(.top, 36 * Constants.ControlHeight)
                    } else {
                        HStack(spacing: 0){
                            Image(password.count >= 1 ? "password_1" : "password_blank1")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48 * Constants.ControlWidth, height: 48 * Constants.ControlHeight)
                            
                            Image(password.count >= 2 ? "password_2" : "password_blank2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48 * Constants.ControlWidth, height: 48 * Constants.ControlHeight)
                            
                            Image(password.count >= 3 ? "password_3" : "password_blank3")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48 * Constants.ControlWidth, height: 48 * Constants.ControlHeight)
                            
                            Image(password.count >= 4 ? "password_4" : "password_blank4")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48 * Constants.ControlWidth, height: 48 * Constants.ControlHeight)
                        }
                        .padding(.top, 36 * Constants.ControlHeight)
                    }
                    
                    Spacer()
                    
                    LazyVGrid(columns: layout) {
                        ForEach(number, id: \.self) { index in
                            Button(action: {
                                if password.count < 4 && index != 12{
                                    password.append(index)
                                    print(password)
                                } else if passwordChk.count < 4 && index != 12{
                                    passwordChk.append(index)
                                    print(passwordChk)
                                }
                                
                                // 비밀번호 입력 완료 시
                                if password.count == 4 && passwordChk.isEmpty {
                                    // 비밀번호 저장 로직 실행 전에 잠시 대기
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        savePassword()
                                    }
                                }
                                if passwordChk.count == 4{
                                    if chkPassword() {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                            AppState.shared.navigationPath.append(passwordType.finish)
                                        }
                                    } else {
                                        isfail = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                            passwordChk.removeAll()
                                        }
                                    }
                                    
                                }
                                
                                if password.count == 4 && index == 12 {
                                    passwordChk.removeLast()
                                    print(passwordChk)
                                } else if passwordChk.count == 0 && index == 12 && password.count != 4{
                                    password.removeLast()
                                    print(password)
                                }
                            }, label: {
                                Numberpad(number: index)
                                    .foregroundColor(.white)
                            })
                        }
                        .padding(.bottom, 35 * Constants.ControlHeight)
                    }
                    
                }
            } else if usage == "결제"{
                VStack(spacing: 0){
                    Text(isfail == false ? "간편 비밀번호를 입력해 주세요" : "비밀번호가 일치하지 않아요 (\(failCout)/5)")
                        .font(.Display1)
                        .foregroundColor(.white)
                    if isfail{
                        Button {
                            AppState.shared.navigationPath.append(passwordType.resetPassword)
                        } label: {
                            Text("혹시 비밀번호를 잊으셨나요?")
                                .font(.Caption)
                                .foregroundColor(Color(hex: "FF6636"))
                                .underline()
                        }
                        
                        
                    } else {
                        Text(" ")
                            .font(.Caption)
                    }
                    HStack(spacing: 0){
                        Image(password.count >= 1 ? "password_1" : "password_blank1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48 * Constants.ControlWidth, height: 48 * Constants.ControlHeight)
                        
                        Image(password.count >= 2 ? "password_2" : "password_blank2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48 * Constants.ControlWidth, height: 48 * Constants.ControlHeight)
                        
                        Image(password.count >= 3 ? "password_3" : "password_blank3")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48 * Constants.ControlWidth, height: 48 * Constants.ControlHeight)
                        
                        Image(password.count >= 4 ? "password_4" : "password_blank4")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48 * Constants.ControlWidth, height: 48 * Constants.ControlHeight)
                    }
                    .padding(.top, 36 * Constants.ControlHeight)
                    
                    Spacer()
                    
                    LazyVGrid(columns: layout) {
                        ForEach(number, id: \.self) { index in
                            Button(action: {
                                if password.count < 4 && index != 12{
                                    password.append(index)
                                    print(password)
                                }
                                
                                if password.count == 4 {
                                    if retrievePassword() == password {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                            AppState.shared.navigationPath.removeLast()
                                            paymentModal.toggle()
                                        }
                                    } else if failCout == 4{
                                        isfail = true
                                        failCout += 1
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                            resetModal.toggle()
                                        }
                                        
                                    } else {
                                        isfail = true
                                        failCout += 1
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                            password.removeAll()
                                        }
                                    }
                                }
                                
                                if index == 12 && password.count != 4{
                                    password.removeLast()
                                    print(password)
                                }
                                
                            }, label: {
                                Numberpad(number: index)
                                    .foregroundColor(.white)
                            })
                        }
                        .padding(.bottom, 35 * Constants.ControlHeight)
                    }
                    
                }
            } else if usage == "재설정"{
                VStack(spacing: 0){
                    Text(password.count == 4 ? "비밀번호를 한 번 더 입력해 주세요" : "새 비밀번호를 입력해 주세요")
                        .font(.Display1)
                        .foregroundColor(.white)
                    if isfail {
                        Text("비밀번호가 일치하지 않아요")
                            .font(.Caption)
                            .foregroundColor(Color(hex: "FF6636"))
                    } else {
                        Text(" ")
                            .font(.Caption)
                    }
                    
                    if saveChk {
                        HStack(spacing: 0){
                            Image(passwordChk.count >= 1 ? "password_1" : "password_blank1")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48 * Constants.ControlWidth, height: 48 * Constants.ControlHeight)
                            
                            Image(passwordChk.count >= 2 ? "password_2" : "password_blank2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48 * Constants.ControlWidth, height: 48 * Constants.ControlHeight)
                            
                            Image(passwordChk.count >= 3 ? "password_3" : "password_blank3")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48 * Constants.ControlWidth, height: 48 * Constants.ControlHeight)
                            
                            Image(passwordChk.count >= 4 ? "password_4" : "password_blank4")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48 * Constants.ControlWidth, height: 48 * Constants.ControlHeight)
                        }
                        .padding(.top, 36 * Constants.ControlHeight)
                    } else {
                        HStack(spacing: 0){
                            Image(password.count >= 1 ? "password_1" : "password_blank1")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48 * Constants.ControlWidth, height: 48 * Constants.ControlHeight)
                            
                            Image(password.count >= 2 ? "password_2" : "password_blank2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48 * Constants.ControlWidth, height: 48 * Constants.ControlHeight)
                            
                            Image(password.count >= 3 ? "password_3" : "password_blank3")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48 * Constants.ControlWidth, height: 48 * Constants.ControlHeight)
                            
                            Image(password.count >= 4 ? "password_4" : "password_blank4")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48 * Constants.ControlWidth, height: 48 * Constants.ControlHeight)
                        }
                        .padding(.top, 36 * Constants.ControlHeight)
                    }
                    
                    Spacer()
                    
                    LazyVGrid(columns: layout) {
                        ForEach(number, id: \.self) { index in
                            Button(action: {
                                if password.count < 4 && index != 12{
                                    password.append(index)
                                    print(password)
                                } else if passwordChk.count < 4 && index != 12{
                                    passwordChk.append(index)
                                    print(passwordChk)
                                }
                                
                                if password.count == 4 {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        savePassword()
                                    }
                                }
                                if passwordChk.count == 4{
                                    if chkPassword() {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                            resetFinishModal.toggle()
                                            //메인화면이동
                                        }
                                    } else {
                                        isfail = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                            passwordChk.removeAll()
                                        }
                                    }
                                    
                                }
                                
                                if password.count == 4 && index == 12 {
                                    passwordChk.removeLast()
                                    print(passwordChk)
                                } else if passwordChk.count == 0 && index == 12 && password.count != 4{
                                    password.removeLast()
                                    print(password)
                                }
                            }, label: {
                                Numberpad(number: index)
                                    .foregroundColor(.white)
                            })
                        }
                        .padding(.bottom, 35 * Constants.ControlHeight)
                    }
                    
                }
            } else if usage == "가입"{
                VStack(spacing: 0){
                    
                    Text(password.count == 4 ? "비밀번호를 한 번 더 입력해 주세요" : "새 비밀번호를 입력해 주세요")
                        .font(.Display1)
                        .foregroundColor(.white)
                    if isfail {
                        Text("비밀번호가 일치하지 않아요")
                            .font(.Caption)
                            .foregroundColor(Color(hex: "FF6636"))
                    } else {
                        Text(" ")
                            .font(.Caption)
                    }
                    
                    
                    if saveChk {
                        HStack(spacing: 0){
                            Image(passwordChk.count >= 1 ? "password_1" : "password_blank1")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48 * Constants.ControlWidth, height: 48 * Constants.ControlHeight)
                            
                            Image(passwordChk.count >= 2 ? "password_2" : "password_blank2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48 * Constants.ControlWidth, height: 48 * Constants.ControlHeight)
                            
                            Image(passwordChk.count >= 3 ? "password_3" : "password_blank3")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48 * Constants.ControlWidth, height: 48 * Constants.ControlHeight)
                            
                            Image(passwordChk.count >= 4 ? "password_4" : "password_blank4")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48 * Constants.ControlWidth, height: 48 * Constants.ControlHeight)
                        }
                        .padding(.top, 36 * Constants.ControlHeight)
                    } else {
                        HStack(spacing: 0){
                            Image(password.count >= 1 ? "password_1" : "password_blank1")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48 * Constants.ControlWidth, height: 48 * Constants.ControlHeight)
                            
                            Image(password.count >= 2 ? "password_2" : "password_blank2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48 * Constants.ControlWidth, height: 48 * Constants.ControlHeight)
                            
                            Image(password.count >= 3 ? "password_3" : "password_blank3")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48 * Constants.ControlWidth, height: 48 * Constants.ControlHeight)
                            
                            Image(password.count >= 4 ? "password_4" : "password_blank4")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48 * Constants.ControlWidth, height: 48 * Constants.ControlHeight)
                        }
                        .padding(.top, 36 * Constants.ControlHeight)
                    }
                    
                    Spacer()
                    
                    LazyVGrid(columns: layout) {
                        ForEach(number, id: \.self) { index in
                            Button(action: {
                                if password.count < 4 && index != 12{
                                    password.append(index)
                                    print(password)
                                } else if passwordChk.count < 4 && index != 12{
                                    passwordChk.append(index)
                                    print(passwordChk)
                                }
                                
                                // 비밀번호 입력 완료 시
                                if password.count == 4 && passwordChk.isEmpty {
                                    // 비밀번호 저장 로직 실행 전에 잠시 대기
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        savePassword()
                                    }
                                }
                                if passwordChk.count == 4{
                                    if chkPassword() {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                            Task{
                                                await join()
                                            }
                                        }
                                    } else {
                                        isfail = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                            passwordChk.removeAll()
                                        }
                                    }
                                    
                                }
                                
                                if password.count == 4 && index == 12 {
                                    passwordChk.removeLast()
                                    print(passwordChk)
                                } else if passwordChk.count == 0 && index == 12 && password.count != 4{
                                    password.removeLast()
                                    print(password)
                                }
                            }, label: {
                                Numberpad(number: index)
                                    .foregroundColor(.white)
                            })
                        }
                        .padding(.bottom, 35 * Constants.ControlHeight)
                    }
                    
                }
            }
        }
    }
    
    func join() async {
        let savedProvider = KeyChainManager.readItem(key: "provider") ?? ""
        let savedProviderId = KeyChainManager.readItem(key: "providerId") ?? ""
        
        let savedName = UserDefaults.standard.string(forKey: "name") ?? ""
        let savedAddress = UserDefaults.standard.string(forKey: "address") ?? ""
        let savedbirth = UserDefaults.standard.string(forKey: "birth") ?? ""
        let savedTelecom = UserDefaults.standard.string(forKey: "telecom") ?? ""
        let savedPhone = UserDefaults.standard.string(forKey: "phone") ?? ""
        
        let passwordString = password.map { String($0) }.joined()
        
        await viewModel.action(.getJoin(provider: savedProvider, providerId: savedProviderId, name: savedName, address: savedAddress, birth: savedbirth, telecom: savedTelecom, phone: savedPhone, isMarket: true, pwd: passwordString))
        
        // getJoinResponse가 성공적으로 업데이트되었는지 확인
        if viewModel.state.getJoinResponse.userId != 0 {
            // 성공하면 navigationPath에 finish 추가
            DispatchQueue.main.async {
                AppState.shared.navigationPath.append(passwordType.finish)
            }
        } else {
            // 실패 시 추가 작업 (필요하다면)
            print("회원 가입 실패")
        }
    }
    
    func savePassword() {
        let passwordString = password.map { String($0) }.joined()
        KeyChainManager.addItem(key: "userPassword", value: passwordString)
        print("Password saved successfully")
        saveChk = true
    }
    
    func retrievePassword() -> [Int]? {
        if let passwordString = KeyChainManager.readItem(key: "userPassword") {
            let passwordArray = passwordString.compactMap { Int(String($0)) }
            return passwordArray
        } else {
            print("Password not found in Keychain")
            return nil
        }
    }
    
    func chkPassword() -> Bool{
        let savedPassword = retrievePassword()
        
        if savedPassword == passwordChk{
            return true
        } else {
            return false
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
}

struct Numberpad: View {
    var number: Int = 0
    var body: some View {
        ZStack{
            if number != 11 && number != 12 {
                Text("\(number)")
                    .font(.Display2)
            } else if number == 11{
                Text(" ")
                    .allowsHitTesting(false)
            } else if number == 12{
                Image("password_back")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 34 * Constants.ControlWidth, height: 34 * Constants.ControlHeight)
                    .padding(.trailing)
            }
        }
    }
}

enum passwordType {
    case finish
    case resetPassword
}

#Preview {
    PasswordView(paymentModal: .constant(false))
}
