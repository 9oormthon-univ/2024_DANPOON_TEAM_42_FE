//
//  SwipointMainView.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/19/24.
//

import SwiftUI
import Kingfisher

struct SwipointView: View {
    
    @StateObject var exchangeViewModel = SwipointExchangeViewModel()
    @ObservedObject var swipayViewModel: SwipayViewModel
    @StateObject var viewModel = SwipointViewModel()
    @StateObject private var geoServiceManager = GeoServiceManager()
    @State var address: String = ""
    @State var isSelectedRegion: Int64? = nil
    
    @State var closeModal: Bool = false
    @State var pointExchangeModal: Bool = false
    @State var makeCardModal: Bool = false
    @State var newCardModal: Bool = false
    @State var existenceCardModal: Bool = false
    
    @State var selectedCardID: String = "" // 현재 선택된 카드 ID 저장
    @State var selectedCardIndex: Int = 0
    
    var body: some View {
        
        ZStack{
            VStack(spacing: 0){
                ImageBtnNavigationBar(title: "스위포인트",
                                      imageType: "question_circle_mark",
                                      showBackButton: true, blur: false)
                
                SwipointMainView(swipayViewModel: swipayViewModel, viewModel: viewModel, exchangeViewModel: exchangeViewModel, selectedCardIndex: $selectedCardIndex, isSelectedRegion: $isSelectedRegion, makeCardModal: $makeCardModal, pointExchangeModal: $pointExchangeModal, selectedCardID: $selectedCardID)
                    .padding(.top, 30 * Constants.ControlHeight)
            }
        }
        .toolbar(.hidden)
        .navigationDestination(for: swipointType.self) { view in
            switch view {
            case .exchange(let to, let from):
                SwipointExchangeView(viewModel: SwipayViewModel(), fromPoint: to, toPoint: from)
            case .guide:
                SwipstoneGuideView()
            case .custom:
                CustomView(region: $address)
            }
        }
        .onAppear {
            geoServiceManager.onAddressUpdate = { addressResult in
                address = addressResult // 주소 업데이트
                print("주소: \(addressResult)")
            }
        }
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
        .sheet(isPresented: $pointExchangeModal, content: {

            SwipstoneSelectModal(
                exchangeViewModel: exchangeViewModel,
                viewModel: viewModel,
                pointExchangeModal: $pointExchangeModal,
                closeModal: $pointExchangeModal,
                region: $address,
                newCardModal: $newCardModal,
                existenceCardModal: $existenceCardModal,
                selectedCardID: $selectedCardID// 필터링된 데이터 전달
            )
        })
        .sheet(isPresented: $makeCardModal, content: {
            LocationCertificationModal(viewModel: swipayViewModel, makeCardModal: $makeCardModal, region: $address, newCardModal: $newCardModal, existenceCardModal: $existenceCardModal)
                .background(ClearBackgroundView())// 팝업 뷰 height 조절
                .presentationDetents([.height(346 * Constants.ControlHeight)])
        })
        .sheet(isPresented: $newCardModal, content: {
            LocationNewModal(region: $address, viewModel: swipayViewModel, newCardModal: $newCardModal)
                .background(ClearBackgroundView())// 팝업 뷰 height 조절
                .presentationDetents([.height(376 * Constants.ControlHeight)])
        })
        .sheet(isPresented: $existenceCardModal, content: {
            LocationExistView(region: $address, viewModel: swipayViewModel, existenceCardModal: $existenceCardModal)
                .background(ClearBackgroundView())// 팝업 뷰 height 조절
                .presentationDetents([.height(344 * Constants.ControlHeight)])
        })
        .onAppear(){
            Task {
                await swipayViewModel.action(.getSwipay)
                await exchangeViewModel.action(.getSwipointCard)
            }
        }
    }
}

struct SwipointMainView: View {
    @ObservedObject var swipayViewModel: SwipayViewModel
    @ObservedObject var viewModel: SwipointViewModel
    @ObservedObject var exchangeViewModel: SwipointExchangeViewModel
    
    @Binding var selectedCardIndex: Int // 현재 선택된 카드 인덱스
    @Binding var isSelectedRegion: Int64?
    @Binding var makeCardModal: Bool
    @Binding var pointExchangeModal: Bool
    @Binding var selectedCardID: String // 현재 선택된 카드 ID 저장
    
    var body: some View {
        ZStack{
            VStack{
                RoundedRectangle(cornerRadius: 6)
                    .frame(width: Constants.screenWidth, height: 582 * Constants.ControlHeight)
                    .foregroundColor(.greyDarkHover)
                    .edgesIgnoringSafeArea(.leading)
                    .edgesIgnoringSafeArea(.trailing)
                    .overlay(content: {
                        VStack(spacing: 0){
                            // Scrollable Card View
                            ScrollView(.horizontal, showsIndicators: false) {
                                ScrollViewReader { proxy in
                                    HStack(spacing: 10) {
                                        
                                        Spacer()
                                            .padding(.trailing, 56 * Constants.ControlWidth)
                                        
                                        ForEach(swipayViewModel.state.getSwipointCardResponse, id: \.cardId) { data in
                                            
                                            
                                            SwipointCardView(region: data.region, point: String(data.point), customImage: data.customImage)
                                                .onTapGesture {
                                                    withAnimation(.easeInOut) {
                                                        selectedCardIndex = Int(data.cardId) ?? 0
                                                        selectedCardID = data.cardId // 현재 보고 있는 카드의 ID 저장
                                                        proxy.scrollTo(Int(data.cardId), anchor: .center)
                                                    }
                                                }
                                                .id(Int(data.cardId))
                                        }
                                        
                                        Spacer()
                                            .padding(.leading, 56 * Constants.ControlWidth)
                                    }
                                    .onAppear {
                                        if let isSelectedRegion = isSelectedRegion {
                                            proxy.scrollTo(Int(isSelectedRegion), anchor: .center) // 선택된 리뷰 ID로 스크롤
                                        }
                                    }
                                }
                            }
                            .scrollDisabled(true)
                            .padding(.bottom, 14 * Constants.ControlHeight)
                            .padding(.top, 22 * Constants.ControlHeight)
                            
                            if swipayViewModel.state.getSwipointCardResponse.count >= 1 {
                                HStack(spacing: 6){
                                    Button(action: {
                                        pointExchangeModal = true
                                    }, label: {
                                        RoundedRectangle(cornerRadius: 6)
                                            .frame(width: 114.5 * Constants.ControlWidth, height: 40 * Constants.ControlHeight)
                                            .foregroundColor(.greyNormalHover)
                                            .overlay {
                                                Text("포인트 환전")
                                                    .font(.Body1)
                                                    .foregroundColor(.white)
                                            }
                                    })
                                    
                                    RoundedRectangle(cornerRadius: 6)
                                        .frame(width: 114.5 * Constants.ControlWidth, height: 40 * Constants.ControlHeight)
                                        .foregroundColor(.greyNormalHover)
                                        .overlay {
                                            Text("사용 내역")
                                                .font(.Body1)
                                                .foregroundColor(.white)
                                        }
                                }
                                .padding(.bottom, 30 * Constants.ControlHeight)
                            }
                        }
                    })
                
                Spacer()
                
                Button(action: {
                    makeCardModal = true
                }, label: {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 360 * Constants.ControlWidth, height: 54 * Constants.ControlHeight)
                        .foregroundColor(.mainNormal)
                        .overlay {
                            Text("새로운 카드 등록")
                                .font(.Subhead3)
                                .foregroundColor(.white)
                        }
                })
            }
        }
        .onAppear {
            if !swipayViewModel.state.getSwipointCardResponse.isEmpty {
                selectedCardIndex = 0 // 첫 번째 카드의 인덱스를 기본값으로 설정
                selectedCardID = swipayViewModel.state.getSwipointCardResponse[0].cardId // 첫 번째 카드의 ID 저장
                print("초기 선택된 카드 ID: \(selectedCardID)")
            }
        }
    }
}

struct SwipointCardView: View {
    
    var region: String = ""
    var point: String = ""
    var customImage: String = ""
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                Text("\(region) 스위포인트")
                    .frame(height: 32 * Constants.ControlHeight)
                    .tracking(-0.6)
                    .font(.Headline)
                    .foregroundColor(.white)
                
                Text("\(point)원 사용 가능")
                    .font(.Subhead3)
                    .frame(height: 22 * Constants.ControlHeight)
                    .tracking(-0.6)
                    .foregroundColor(.mainLightHover)
                    .padding(.bottom, 22 * Constants.ControlHeight)
                
                KFImage(URL(string: customImage))
                    .placeholder { //플레이스 홀더 설정
                        Image("swipay_card_ex1")
                    }.retry(maxCount: 3, interval: .seconds(5)) //재시도
                    .onSuccess {r in //성공
                        print("succes: \(r)")
                    }
                    .onFailure { e in //실패
                        print("failure: \(e)")
                    }
                    .resizable()
                    .scaledToFit()
                    .frame(width: 242 * Constants.ControlWidth, height: 384 * Constants.ControlHeight)
            }
        }
    }
}

enum swipointType: Hashable {
    case exchange(from: Cards, to: Cards)
    case guide
    case custom

    // Hashable 프로토콜 준수를 위한 구현
    func hash(into hasher: inout Hasher) {
        switch self {
        case .exchange(let to, let from):
            hasher.combine(to.cardId) // Cards의 고유 값(cardId)을 사용
            hasher.combine(from.cardId)
        case .guide:
            hasher.combine("guide")
        case .custom:
            hasher.combine("custom")
        }
    }

    // Equatable 프로토콜 준수를 위한 구현
    static func == (lhs: swipointType, rhs: swipointType) -> Bool {
        switch (lhs, rhs) {
        case (.exchange(let to1, let from1), .exchange(let to2, let from2)):
            return to1.cardId == to2.cardId && from1.cardId == from2.cardId
        case (.guide, .guide):
            return true
        case (.custom, .custom):
            return true
        default:
            return false
        }
    }
}

struct ImageBtnNavigationBar: View {
    let title: String
    let imageType: String
    let showBackButton: Bool
    var blur: Bool
    
    var body: some View {
        ZStack {
            HStack {
                // 뒤로가기 버튼
                if showBackButton {
                    Button(action: {
                        AppState.shared.navigationPath.removeLast()
                    }, label: {
                        Image(blur == false ? "back_btn" : "back_btn_8b8b8b")
                    })
                }
                
                Spacer()
                
                // 네비게이션 타이틀
                Text(title)
                    .font(.Headline)
                    .foregroundColor(blur == false ? .greyLighter : Color(hex: "8B8B8B"))
                
                Spacer()
                
                // 오른쪽 버튼
                Button(action: {
                    AppState.shared.navigationPath.append(swipointType.guide)
                }, label: {
                    Image(imageType)
                        .frame(width: 38 * Constants.ControlWidth)
                })
            }
            .frame(height: 58 * Constants.ControlHeight)
        }
    }
}

struct ClearBackgroundView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = UIColor.black.withAlphaComponent(0)
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


#Preview {
    SwipointView(swipayViewModel: SwipayViewModel())
}



