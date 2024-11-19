//
//  SwipointMainView.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/19/24.
//

import SwiftUI

struct SwipointView: View {
    
    @StateObject var viewModel = SwipointViewModel()
    @StateObject private var geoServiceManager = GeoServiceManager()
    @State var address: String = ""
    @State var isSelectedRegion: Int64? = nil
    @State var makeCardModal: Bool = false
    @State var newCardModal: Bool = false
    @State var existenceCardModal: Bool = false
    
    var body: some View {
        
        ZStack{
            VStack(spacing: 0){
                ImageBtnNavigationBar(title: "스위포인트",
                                      imageType: "question_circle_mark",
                                      showBackButton: true, blur: false)
                
                SwipointMainView(viewModel: viewModel, isSelectedRegion: $isSelectedRegion, makeCardModal: $makeCardModal)
                
                Spacer()
            }
        }
        .toolbar(.hidden)
        .navigationDestination(for: swipointType.self) { view in
            switch view{
            case .guide:
                SwipstoneGuideView()
            case .custom:
                CustomView()
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
        .sheet(isPresented: $makeCardModal, content: {
            LocationCertificationModal(viewModel: viewModel, makeCardModal: $makeCardModal, region: $address, newCardModal: $newCardModal, existenceCardModal: $existenceCardModal)
                .background(ClearBackgroundView())// 팝업 뷰 height 조절
                .presentationDetents([.height(346 * Constants.ControlHeight)])
        })
        .sheet(isPresented: $newCardModal, content: {
            LocationNewModal(region: $address, viewModel: viewModel, newCardModal: $newCardModal)
                .background(ClearBackgroundView())// 팝업 뷰 height 조절
                .presentationDetents([.height(376 * Constants.ControlHeight)])
        })
        .sheet(isPresented: $existenceCardModal, content: {
            LocationExistView(region: $address, viewModel: viewModel, existenceCardModal: $existenceCardModal)
                .background(ClearBackgroundView())// 팝업 뷰 height 조절
                .presentationDetents([.height(344 * Constants.ControlHeight)])
        })
    }
}

struct SwipointMainView: View {
    @ObservedObject var viewModel: SwipointViewModel
    @State private var selectedCardIndex: Int = 0 // 현재 선택된 카드 인덱스
    @Binding var isSelectedRegion: Int64?
    @Binding var makeCardModal: Bool
    
    var body: some View {
        ZStack{
            VStack{
                RoundedRectangle(cornerRadius: 6)
                    .frame(width: Constants.screenWidth, height: 542 * Constants.ControlHeight)
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
                                        
                                        ForEach(viewModel.state.getSwipointCardResponse, id: \.id) { data in
                                            SwipointCardView(region: data.region, point: data.point, cardImage: data.cardImage)
                                                .onTapGesture {
                                                    withAnimation(.easeInOut) {
                                                        selectedCardIndex = Int(data.id)
                                                        proxy.scrollTo(Int(data.id), anchor: .center)
                                                    }
                                                }
                                                .id(Int(data.id))
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
                            .padding(.bottom, 10 * Constants.ControlHeight)
                            .padding(.top, 20 * Constants.ControlHeight)
                            
                            HStack(spacing: 6){
                                RoundedRectangle(cornerRadius: 6)
                                    .frame(width: 114.5 * Constants.ControlWidth, height: 40 * Constants.ControlHeight)
                                    .foregroundColor(.greyNormalHover)
                                    .overlay {
                                        Text("포인트 이동")
                                            .font(.Body1)
                                            .foregroundColor(.white)
                                    }
                                
                                RoundedRectangle(cornerRadius: 6)
                                    .frame(width: 114.5 * Constants.ControlWidth, height: 40 * Constants.ControlHeight)
                                    .foregroundColor(.greyNormalHover)
                                    .overlay {
                                        Text("사용 내역")
                                            .font(.Body1)
                                            .foregroundColor(.white)
                                    }
                            }
                            
                            Spacer()
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
            .padding(.top, 30 * Constants.ControlHeight)
        }
    }
}

struct SwipointCardView: View {
    
    var region: String
    var point: String
    var cardImage: String
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                Text("\(region) 스위포인트")
                    .font(.Headline)
                    .foregroundColor(.white)
                
                Text("\(point)원 사용 가능")
                    .font(.Subhead3)
                    .foregroundColor(.mainLightHover)
                    .padding(.bottom)
                
                Image("swipay_card_ex1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 242 * Constants.ControlWidth, height: 386 * Constants.ControlHeight)
            }
        }
    }
}

enum swipointType{
    case guide
    case custom
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
    SwipointView()
}

