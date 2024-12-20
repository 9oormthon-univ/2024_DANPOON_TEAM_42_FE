//
//  NearbyView.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/18/24.
//

import SwiftUI
import KakaoMapsSDK
import CoreLocation

struct NearbyView: View {
    @State var searchText: String = ""
    @State var payButtonEnable: Bool = false
    @State var storeMapResponse: StoreMapResponse? = nil
    @State var storeTabResponse: StoreTabResponse = StoreTabResponse(wishlists: [], picks: [], trends: [], tastes: [], labs: [])

    @State var mapViewModel = MapViewModel()
    @State var viewModel = CategoryViewModel()
    @State private var selectedCategoryIndex: Int = 0

    var body: some View {
        ZStack {
            MapView(storeMapResponse: $storeMapResponse)

            VStack {
                HStack {
                    HStack {
                        Image("search")
                            .resizable()
                            .frame(width: 24 * Constants.ControlWidth, height: 24 * Constants.ControlHeight)
                            .foregroundColor(Color.greyLightActive)
                        CustomTextField(
                            placeholder: "지역 및 가맹점을 검색해 보세요",
                            text: $searchText,
                            placeholderColor: UIColor.gray,
                            textColor: UIColor.black, iconColor: .greyLightActive
                        )
                    }
                    .padding(.vertical, 3)
                    .padding(.horizontal, 12)
                    .frame(width: 305 * Constants.ControlWidth, height: 40 * Constants.ControlHeight)
                    .background(Color.white)
                    .cornerRadius(14)
                    .shadow(radius: 2)

                    Button(action: {
                        AppState.shared.navigationPath.append(mainType.storeList)
                    }, label: {
                            RoundedRectangle(cornerRadius: 14)
                                .frame(width: 50 * Constants.ControlWidth, height: 40 * Constants.ControlHeight)
                                .foregroundColor(.white)
                                .cornerRadius(14)
                                .shadow(radius: 2)
                                .overlay {
                                    HStack {
                                        Image("filter")
                                            .resizable()
                                            .frame(width: 24 * Constants.ControlWidth, height: 24 * Constants.ControlHeight)
                                            .foregroundColor(Color.greyLightActive)
                                    }
                                }
                        })
                }
                .padding(.top, 18)

                CategoryButtonView(selectedCategoryIndex: $selectedCategoryIndex)
                    .zIndex(1)

                Spacer()

                HStack {
                    Spacer()

                    Button(action: {
                    }) {
                       Circle()
                            .frame(width: 50 * Constants.ControlWidth, height: 50 * Constants.ControlHeight)
                            .foregroundColor(.white.opacity(0.8))
                            .overlay {
                                Image("location")
                                    .resizable()
                                    .frame(width: 33 * Constants.ControlWidth,
                                           height: 33 * Constants.ControlHeight)
                            }
                    }
                }
                .padding(.bottom, 130)
                .padding(.horizontal)
            }

            CategoryModalView(mapViewModel: mapViewModel,
                              categoryViewModel: viewModel,
                              selectedCategoryIndex: $selectedCategoryIndex,
                              storeTabResponse: $storeTabResponse)
            .onTapGesture {
                // 모달 외부를 터치하면 닫힘
            }
        }
        .onAppear() {
            Task {
                let storeMapResponse = await getStoreMap(request: StoreMapRequest())
                DispatchQueue.main.async {
                    self.storeMapResponse = storeMapResponse
                }
                let storeTabResponse = await getStoreTab()
                DispatchQueue.main.async {
                    self.mapViewModel.state.getStoreTabResponse = storeTabResponse ?? StoreTabResponse(wishlists: [], picks: [], trends: [], tastes: [], labs: [])
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(for: mainType.self) { viewType in
            switch viewType {
            case .storeList:
                StoreListView()
            }
        }
    }

    enum mainType {
        case storeList
    }

    private func getStoreMap(request: StoreMapRequest) async -> StoreMapResponse? {
        guard let response = await StoreService.getStoreMap(request: request) else {
            print("Failed to fetch store map data")
            return nil
        }

        if response.code == 200 {
            return response.data
        } else {
            print("Error: \(response.message)")
            return nil
        }
    }

    private func getStoreTab() async -> StoreTabResponse? {
        guard let response = await StoreService.getStoreTab() else {
            print("Failed to fetch store map data")
            return nil
        }

        if response.code == 200 {
            return response.data
        } else {
            print("Error: \(response.message)")
            return nil
        }
    }
}

#Preview {
    MainView()
}

struct CategoryButtonView: View {
    let buttonTitles: [String] = ["전체", "💛 관심 등록", "👍 스위포 PICK!", "🔥 사용자 트렌드", "🥰 내 취향 가득", "👩‍🔬 스윕 Lab"]
    @Binding var selectedCategoryIndex: Int

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
                   HStack(spacing: 4) {
                       ForEach(buttonTitles.indices, id: \.self) { index in
                           Button(action: {
                               selectedCategoryIndex = index
                           }) {
                               VStack(){
                                   Text(buttonTitles[index])
                                       .font(.Subhead3)
                                       .padding(.vertical, 10)
                                       .padding(.horizontal, 15)
                                       .background(
                                           RoundedRectangle(cornerRadius: 14)
                                               .fill(selectedCategoryIndex == index ? .mainNormal : .white)
                                               .allowsHitTesting(true)
                                       )
                                       .foregroundColor(selectedCategoryIndex == index ? .white : .mainNormal)
                               }
                           }
                           .padding(.vertical, 10)
                       }
                   }
                   .padding(.horizontal, 16)
               }
               .padding(.top, 4)
    }
}

struct CategoryModalView: View {
    enum ModalPosition {
        case collapsed
        case halfExpanded
        case fullyExpanded
    }

    @State private var modalPosition: ModalPosition = .collapsed
    @State private var dragOffset: CGFloat = 0
    @ObservedObject var mapViewModel: MapViewModel
//    @Binding var mapViewModel: MapViewModel
    @StateObject var categoryViewModel = CategoryViewModel()
    @Binding var selectedCategoryIndex: Int
    @Binding var storeTabResponse: StoreTabResponse

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                // 모달 뷰
                VStack {
                    Capsule()
                        .frame(width: 50, height: 5)
                        .foregroundColor(.white)
                        .padding(.top, 11)
                    
                    ScrollView(showsIndicators: false) {
                        if selectedCategoryIndex == 0 {
                            VStack(spacing: 12) {
                                CategoryCurationView()

                                let category0 = categoryViewModel.state.categoryType[0]
                                CategoryTitleView(title: category0.title, content: category0.content)

                                CategoryDefaultListView(viewModel: StoreViewModel(), mapViewModel: mapViewModel, tabIndex: $selectedCategoryIndex)
                                    .padding(.bottom, 22)

                                let category1 = categoryViewModel.state.categoryType[1]
                                CategoryTitleView(title: category1.title, content: category1.content)

                                CategoryDefaultListView(viewModel: StoreViewModel(), mapViewModel: mapViewModel, tabIndex: $selectedCategoryIndex)
                                    .padding(.bottom, 22)

                                let category3 = categoryViewModel.state.categoryType[2]
                                CategoryTitleView(title: category3.title, content: category3.content)
                                CategoryRankingListView(mapViewModel: mapViewModel)
                                    .padding(.bottom, 22)

                                let category4 = categoryViewModel.state.categoryType[3]
                                CategoryTitleView(title: category4.title, content: category4.content)
                                CategoryTasteView()
                                    .padding(.bottom, 22)

                                RoundedRectangle(cornerRadius: 16)
                                    .frame(width: 361 * Constants.ControlWidth, height: 88 * Constants.ControlHeight)
                                    .scaledToFit()
                                    .foregroundColor(.white)
                                    .overlay {
                                        HStack(spacing: 0){
                                            VStack(alignment: .leading, spacing: 0){
                                                Text("11월 BBQ X SWIPO의 특별 혜택")
                                                    .lineLimit(1)
                                                    .font(.Subhead3)
                                                    .foregroundColor(.greyDarkHover)
                                                
                                                Text("포장 주문 및 결제시 10% 페이백!")
                                                    .lineLimit(1)
                                                    .font(.Subhead2)
                                                    .foregroundColor(.greyNormalHover)
                                            }
                                            .padding(.leading, 22 * Constants.ControlWidth)
                                            
                                            Image("swipay_chicken")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 102 * Constants.ControlWidth, height: 88 * Constants.ControlHeight)
                                                .cornerRadius(16, corners: .topRight)
                                                .cornerRadius(16, corners: .bottomRight)
                                                .overlay {
                                                    VStack(spacing: 0){
                                                        HStack(spacing: 0){
                                                            Spacer()
                                                            
                                                            Image("swipay_ad_exclamation_mark")
                                                                .resizable()
                                                                .scaledToFit()
                                                                .frame(width: 20 * Constants.ControlWidth)
                                                        }
                                                        Spacer()
                                                    }
                                                    .padding(.top, 5)
                                                }
                                            
                                        }
                                    }
                                    .padding(.bottom, 44 * Constants.ControlHeight)
                            }
                            .padding()
                        } else if selectedCategoryIndex == 1 {
                            VStack(spacing: 12) {
                                
                                let category = categoryViewModel.state.categoryType[0]
                                CategoryTitleView(title: category.title, content: category.content)
                                
                                CategoryDefaultListView(viewModel: StoreViewModel(), mapViewModel: mapViewModel, tabIndex: $selectedCategoryIndex)
                                    .padding(.bottom, 22)
                            }
                            .padding()
                        } else if selectedCategoryIndex == 2 {
                            VStack(spacing: 12) {
                                
                                let category = categoryViewModel.state.categoryType[1]
                                CategoryTitleView(title: category.title, content: category.content)
                                
                                CategoryDefaultListView(viewModel: StoreViewModel(), mapViewModel: mapViewModel, tabIndex: $selectedCategoryIndex)
                                    .padding(.bottom, 22)
                            }
                            .padding()
                        } else {
                            if selectedCategoryIndex == 3 {
                                VStack(spacing: 12) {
                                    let selectedCategory = categoryViewModel.state.categoryType[selectedCategoryIndex - 1]
                                    CategoryTitleView(title: selectedCategory.title, content: selectedCategory.content)

                                    CategoryRankingListView(mapViewModel: mapViewModel)
                                        .padding(.bottom, 22)
                                }
                                .padding()
                            } else if selectedCategoryIndex == 4 {
                                VStack(spacing: 12) {
                                    let selectedCategory = categoryViewModel.state.categoryType[selectedCategoryIndex - 1]
                                    CategoryTitleView(title: selectedCategory.title, content: selectedCategory.content)

                                    CategoryTasteView()
                                        .padding(.bottom, 22)
                                }
                                .padding()
                            } else if selectedCategoryIndex == 5 {
                                VStack(spacing: 12) {
                                    CategoryLabView()
                                        .padding(.bottom, 22)
                                }
                                .padding()
                            } else {
                                VStack(spacing: 12) {
                                    let selectedCategory = categoryViewModel.state.categoryType[selectedCategoryIndex - 1]
                                    CategoryTitleView(title: selectedCategory.title, content: selectedCategory.content)

//                                    CategoryDefaultListView(tabIndex: $selectedCategoryIndex, mapViewModel: MapViewModel)
                                        .padding(.bottom, 22)
                                }
                                .padding()
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.black))
                .shadow(radius: 12)
                .offset(y: min(max(modalOffset(for: modalPosition, in: geometry) + dragOffset, 0),
                               modalOffset(for: .collapsed, in: geometry)))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if modalPosition == .fullyExpanded && value.translation.height < 0 {
                                dragOffset = 0
                            } else if modalPosition == .collapsed && value.translation.height > 0 {
                                dragOffset = 0
                            } else {
                                dragOffset = value.translation.height
                            }
                        }
                        .onEnded { value in
                            let height = value.translation.height
                            dragOffset = 0
                            determineModalPosition(from: height)
                        }
                )
                .foregroundColor(.white)
                .animation(.easeInOut(duration: 0.3), value: modalPosition)
            }
        }
    }

    private func modalOffset(for position: ModalPosition, in geometry: GeometryProxy) -> CGFloat {
        let screenHeight = geometry.size.height
        switch position {
        case .collapsed:
            return screenHeight - 111
        case .halfExpanded:
            return screenHeight - 345
        case .fullyExpanded:
            return 14
        }
    }

    private func determineModalPosition(from dragHeight: CGFloat) {
        let dragThreshold: CGFloat = 50
        switch modalPosition {
        case .collapsed:
            if dragHeight < -dragThreshold {
                modalPosition = .halfExpanded
            }
        case .halfExpanded:
            if dragHeight < -dragThreshold {
                modalPosition = .fullyExpanded
            } else if dragHeight > dragThreshold {
                modalPosition = .collapsed
            }
        case .fullyExpanded:
            if dragHeight > dragThreshold {
                modalPosition = .halfExpanded
            }
        }
    }

    private func moveUp() {
        switch modalPosition {
        case .collapsed:
            modalPosition = .halfExpanded
        case .halfExpanded:
            modalPosition = .fullyExpanded
        case .fullyExpanded:
            break
        }
    }

    private func moveDown() {
        switch modalPosition {
        case .fullyExpanded:
            modalPosition = .halfExpanded
        case .halfExpanded:
            modalPosition = .collapsed
        case .collapsed:
            break
        }
    }
}

