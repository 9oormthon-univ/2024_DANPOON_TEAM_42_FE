//
//  PaymentView.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/21/24.
//

import SwiftUI

struct PaymentView: View {
    
    @State var paymentModal: Bool = false
    
    @Binding var storeTitle: String
    @State var price: String = ""
    
    @StateObject private var geoServiceManager = GeoServiceManager()
    var swipointViewModel = SwipointViewModel()
    @State var address: String = ""
    @State var koreaAddress: String = "" //울산광역시 -> 울산
    @State var englishAddress: String = "" //영어주소
    
    @State var shortageModal: Bool = false
    @State var navigation: String = ""
    
    var body: some View {
        ZStack{
            
            VStack(spacing: 0){
                NavigationBar(title: "결제하기", showBackButton: true)
                
                PaymentMainView(storeTitle: $storeTitle, paymentModal: $paymentModal, price: $price, shortageModal: $shortageModal)
                
                Spacer()
            }
        }
        .toolbar(.hidden)
        .navigationDestination(for: paymentType.self) { view in
            switch view {
            case .password:
                PasswordView(usage: "결제", paymentModal: $paymentModal)
            case .charge:
                PayChargeView()
            }
        }
        .onAppear(){
            print(storeTitle)
        }
        .onAppear {
            geoServiceManager.onAddressUpdate = { addressResult in
                address = addressResult // 주소 업데이트
                print("주소: \(addressResult)")
                
                koreaAddress = swipointViewModel.convertFullRegionToShort(inputRegion: address) ?? ""
                englishAddress = swipointViewModel.convertRegionToEnglish(koreanRegion: koreaAddress) ?? ""
                
                print("\(koreaAddress)")
                print("\(englishAddress)")
                
            }
        }
        .sheet(isPresented: $paymentModal) {
            PaymentFinishView(paymentModal: $paymentModal, koreaAddress: $koreaAddress, englishAddress: $englishAddress)
                .background(ClearBackgroundView())// 팝업 뷰 height 조절
                .presentationDetents([.height(468 * Constants.ControlHeight)])
        }
        .sheet(isPresented: $shortageModal) {
            PaymentShortageModal(shortageModal: $shortageModal, navigation: $navigation)
                .background(ClearBackgroundView())// 팝업 뷰 height 조절
                .presentationDetents([.height(240 * Constants.ControlHeight)])
                .onDisappear {
                    if navigation == "충전" {
                        AppState.shared.navigationPath.append(paymentType.charge)
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

struct PaymentMainView: View {
    
    @Binding var storeTitle: String
    @Binding var paymentModal: Bool
    @Binding var price: String
    @State var rewardRatio: String = "5" //리워드 비율
    @State var pointReward: String = "0" //포인트 리워드
    @State var swipay: String = "82579" //보유 금액
    @State var swipoint: String = "2124" //보유 포인트
    @State var payprice: String = "0" //지불 금액
    @State var remainPay: String = "0" //남은 금액
    
    @State var isOn: Bool = false
    @FocusState private var isTextFieldFocused: Bool // 포커스 상태 추가
    
    @Binding var shortageModal: Bool
    
    var body: some View {
        ZStack{
            ScrollViewReader{ scroll in
                ScrollView{
                    VStack(spacing: 0){
                        HStack(spacing: 0){
                            Text("\(storeTitle)")
                                .font(.Body2)
                                .foregroundColor(Color(hex: "C1C1C1"))
                            Text("에서")
                                .font(.Body2)
                                .foregroundColor(.greyLightActive)
                            
                            Spacer()
                        }
                        .padding(.top)
                        .padding(.leading)
                        
                        HStack(spacing: 0) {
                            ZStack(alignment: .leading) {
                                // Placeholder 역할을 하는 Button
                                if price.isEmpty {
                                    Button(action: {
                                        isTextFieldFocused = true // 버튼 클릭 시 TextField 포커스
                                    }) {
                                        Text("얼마를 결제 할까요?")
                                            .font(.Display3)
                                            .foregroundColor(.white)
                                    }
                                }
                                
                                // 금액 입력 TextField
                                TextField("", text: $price)
                                    .keyboardType(.numberPad)
                                    .font(.Display3)
                                    .frame(width: CGFloat(price.count) * 17 + 5, alignment: .leading) // 동적으로 크기 조정
                                    .foregroundColor(.white)
                                    .focused($isTextFieldFocused) // 포커스 상태 연결
                                    .onChange(of: price) { newValue in
                                        // 숫자만 허용하고 포맷팅 적용
                                        price = formatWithCommas(newValue)
                                        pointReward = pointRewards(newValue, rewardRatio)
                                        payprice = newValue
                                        remainPay = remain(swipay, pointReward, payprice)
                                    }
                            }
                            .id("top")
                            
                            if !price.isEmpty {
                                Text("원")
                                    .font(.Display3)
                                    .foregroundColor(.white)
                            }
                            
                            Spacer()
                        }
                        .padding(.top, 18 * Constants.ControlHeight)
                        .padding(.leading)
                        
                        HStack(spacing: 0){
                            Text("결제 금액을 꼭 확인해 주세요")
                                .font(.Caption)
                                .foregroundColor(.mainLightActive)
                            
                            Spacer()
                        }
                        .padding(.top, 6 * Constants.ControlHeight)
                        .padding(.leading)
                        
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: 360 * Constants.ControlWidth, height: 446 * Constants.ControlHeight)
                            .foregroundColor(.greyDarkHover)
                            .overlay {
                                ZStack{
                                    VStack(spacing: 0){
                                        
                                        Image("payment_card_ex1")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 201.79 * Constants.ControlWidth, height: 320 * Constants.ControlHeight)
                                            .padding(.top, 10 * Constants.ControlHeight)
                                        
                                        HStack(spacing: 0){
                                            VStack(alignment: .leading, spacing: 0){
                                                Text("부산 스위포인트 사용")
                                                    .font(.Headline)
                                                    .tracking(-0.6)
                                                    .frame(height: 32 * Constants.ControlHeight)
                                                    .foregroundColor(.white)
                                                
                                                Text("\(formatWithCommas(swipoint))원 사용 가능")
                                                    .font(.Body2)
                                                    .tracking(-0.6)
                                                    .frame(height: 24 * Constants.ControlHeight)
                                                    .foregroundColor(.mainLightHover)
                                            }
                                            
                                            Spacer()
                                            
                                            Button(action: {
                                                isOn.toggle()
                                                if isOn {
                                                    payprice = payment(payprice, swipoint)
                                                    remainPay = remain(swipay, pointReward, payprice)
                                                } else {
                                                    payprice = price
                                                    remainPay = remain(swipay, pointReward, payprice)
                                                }
                                            }, label: {
                                                RoundedRectangle(cornerRadius: 100)
                                                    .frame(width: 51 * Constants.ControlWidth, height: 31 * Constants.ControlHeight)
                                                    .foregroundColor(isOn == false ? .greyNormalHover : .mainNormal)
                                                    .overlay {
                                                        Circle()
                                                            .foregroundColor(.white)
                                                            .frame(width: 16 * Constants.ControlWidth)
                                                            .padding(isOn == false ? .trailing : .leading)
                                                    }
                                            })
                                            .disabled(price.isEmpty)
                                        }
                                        .padding(.top)
                                    
                                    }
                                    .padding(.top)
                                    .padding(.leading, 22 * Constants.ControlWidth)
                                    .padding(.trailing, 22 * Constants.ControlWidth)
                                    .padding(.bottom)
                                    
                                    VStack(spacing: 0){
                                        Spacer()
                                        
                                        HStack(spacing: 0){
                                            Image("payment_cloud")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 235 * Constants.ControlWidth)
                                                .padding(.bottom, 63 * Constants.ControlHeight)
                                                .padding(.leading, -12 * Constants.ControlWidth)
                                            
                                            Spacer()
                                        }
                                    }
                                }
                            }
                            .padding(.top, 40 * Constants.ControlHeight)
                            .padding(.leading)
                            .padding(.trailing)
                        
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: 360 * Constants.ControlWidth, height: 60 * Constants.ControlHeight)
                            .foregroundColor(.greyDarkHover)
                            .overlay {
                                HStack(spacing: 0){
                                    Text("포인트 리워드")
                                        .font(.Headline)
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                    
                                    Text("\(pointReward)원")
                                        .font(.Headline)
                                        .foregroundColor(.mainLightHover)
                                    
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.mainLightActive, lineWidth: 2) // 테두리 색상과 두께 설정
                                            .background(
                                                RoundedRectangle(cornerRadius: 6)
                                                    .foregroundColor(.white) // 배경 색상 설정
                                            )
                                        .frame(width: 84 * Constants.ControlWidth, height: 32 * Constants.ControlHeight)
                                        .foregroundColor(.white)
                                        .overlay(content: {
                                            Text("\(50)% 리워드")
                                                .font(.Body1)
                                                .foregroundColor(.mainNormal)
                                        })
                                        .padding(.leading, 8 * Constants.ControlWidth)
                                        .fixedSize(horizontal: true, vertical: false) // 텍스트 크기에 맞게 조정
                                    
                                }
                                .padding(.top)
                                .padding(.leading, 22 * Constants.ControlWidth)
                                .padding(.trailing, 22 * Constants.ControlWidth)
                                .padding(.bottom)
                            }
                            .padding(.top, 12 * Constants.ControlHeight)
                            .padding(.leading)
                            .padding(.trailing)
                        
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: 360 * Constants.ControlWidth, height: 60 * Constants.ControlHeight)
                            .foregroundColor(.greyDarkHover)
                            .overlay {
                                HStack(spacing: 0){
                                    Text("스위페이")
                                        .font(.Headline)
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                    
                                    Text("82,579원")
                                        .font(.Headline)
                                        .foregroundColor(.mainLightHover)
                                    
                                    RoundedRectangle(cornerRadius: 6)
                                        .frame(width: 42 * Constants.ControlWidth, height: 32 * Constants.ControlHeight)
                                        .foregroundColor(.greyNormalHover)
                                        .overlay(content: {
                                            Text("충전")
                                                .font(.Body1)
                                                .foregroundColor(.white)
                                        })
                                        .padding(.leading, 8 * Constants.ControlWidth)
                                    
                                }
                                .padding(.top)
                                .padding(.leading, 22 * Constants.ControlWidth)
                                .padding(.trailing, 22 * Constants.ControlWidth)
                                .padding(.bottom)
                            }
                            .padding(.top, 12 * Constants.ControlHeight)
                            .padding(.leading)
                            .padding(.trailing)
                        
                        Spacer()
                            .padding(.bottom, price == "" ? 80 * Constants.ControlHeight : 99 * Constants.ControlHeight)
                    }
                    .onChange(of: paymentModal) { newValue in
                        if newValue {
                            // paymentModal이 true가 될 때 ScrollView 맨 위로 스크롤
                            withAnimation {
                                scroll.scrollTo("top", anchor: .top)
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
            
            VStack(spacing: 0){
                Spacer()
                
                Rectangle()
                    .frame(width: 393 * Constants.ControlWidth, height: price == "" ? 70 : 89)
                    .foregroundColor(.black)
                    .overlay {
                        VStack(spacing: 0){
                            Rectangle()
                                .frame(width: 393 * Constants.ControlWidth, height: 1)
                                .foregroundColor(Color(hex: "222222"))
                            
                            Spacer()
                            
                            if price != ""{
                                Text("결제 후 페이 잔액 \(remainPay)원")
                                    .font(.Subhead1)
                                    .tracking(-0.6)
                                    .frame(height: 19 * Constants.ControlHeight)
                                    .foregroundColor(.white)
                                    .opacity(0.56)
                            }
                            
                            Button(action: {
                                if price == "" {
                                    
                                } else {
                                    AppState.shared.navigationPath.append(paymentType.password)
                                }
                            }, label: {
                                RoundedRectangle(cornerRadius: 16)
                                    .frame(width: 360 * Constants.ControlWidth, height: 54 * Constants.ControlHeight)
                                    .foregroundColor(price == "" ? .mainLightActive : .mainNormal)
                                    .overlay {
                                        if price == "" {
                                            Text("결제하기")
                                                .font(.Subhead3)
                                                .foregroundColor(.white)
                                        } else {
                                            if isOn == true{
                                                HStack(spacing: 0){
                                                    Text("\(price)원 ")
                                                        .font(.Subhead3)
                                                        .foregroundColor(.white.opacity(0.5))
                                                        .strikethrough(true, color: Color.white.opacity(0.5))
                                                    
                                                    Text("\(payprice)원 결제하기")
                                                        .font(.Subhead3)
                                                        .foregroundColor(.white)
                                                }
                                            } else {
                                                Text("\(payprice)원 결제하기")
                                                    .font(.Subhead3)
                                                    .foregroundColor(.white)
                                            }
                                            
                                        }
                                    }
                            })
                            .padding(.top, 8 * Constants.ControlHeight)
                            .padding(.leading)
                            .padding(.trailing)
                        }
                    }
                
                
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .onChange(of: price) { newValue in
            let cleanPrice = Int(price.filter { $0.isNumber }) ?? 0
            let cleanSwipay = Int(swipay.filter { $0.isNumber }) ?? 0
            
            if cleanPrice > cleanSwipay {
                shortageModal = true
            }
        }
        .onAppear(){
            if !price.isEmpty{
                pointReward = pointRewards(price, rewardRatio)
                payprice = price
                remainPay = remain(swipay, pointReward, payprice)
            }
        }
        .onTapGesture {
               UIApplication.shared.endEditing()
            }
    }
    
    // 숫자를 3자리마다 쉼표가 포함된 형식으로 변환하는 함수
    func formatWithCommas(_ value: String) -> String {
        // 숫자만 남김
        let numericValue = value.filter { $0.isNumber }
        
        // 숫자가 없으면 빈 문자열 반환
        guard let number = Int(numericValue) else { return "" }
        
        // 3자리마다 쉼표 추가
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
    
    // 입력된 price와 rewardRatio 비율을 계산하여 pointReward 값을 반환하는 함수
    func pointRewards(_ price: String, _ ratio: String) -> String {
        let priceNumber = Double(price.filter { $0.isNumber }) ?? 0
        let ratioNumber = Double(ratio) ?? 0
        
        let rewardValue = priceNumber * (ratioNumber / 100)
        
        return formatWithCommas(String(Int(rewardValue))) // 포맷팅 적용
    }
    
    func payment(_ price: String, _ swipoint: String) -> String {
        // 쉼표 제거 후 Int로 변환
        let cleanPrice = Int(price.filter { $0.isNumber }) ?? 0
        let cleanSwipoint = Int(swipoint.filter { $0.isNumber }) ?? 0
        
        // 100 단위 내림
        let point = (cleanSwipoint / 100) * 100
        let result = cleanPrice - point
        
        if cleanPrice == 0{
            return "0"
        } else {
            return formatWithCommas(String(result))
        }
    }
    
    func remain(_ swipay: String, _ reward: String, _ payPrice: String) -> String {
        // 쉼표 제거 후 Int로 변환
        let cleanSwipay = swipay.filter { $0.isNumber }
        let cleanReward = reward.filter { $0.isNumber }
        let cleanPay = payPrice.filter { $0.isNumber }
        
        let result = (Int(cleanSwipay) ?? 0) - (Int(cleanPay) ?? 0) + (Int(cleanReward) ?? 0)
        
        return formatWithCommas(String(result))
    }
}

enum paymentType {
    case password
    case charge
}

#Preview {
    PaymentView(storeTitle: .constant(""))
}
