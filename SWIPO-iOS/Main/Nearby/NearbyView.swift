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

    private var mapView = MapView()
    private var categoryButtonView = CategoryButtonView()
    private var categoryModalView = CategoryModalView()

    var body: some View {
        ZStack {
            mapView

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

                categoryButtonView

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

            categoryModalView
                .onTapGesture {
                    // 모달 외부를 터치하면 닫힘
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
}

#Preview {
    MainView()
}

struct CategoryButtonView: View {
    let buttonTitles: [String] = ["전체", "💛 관심 등록", "👍 스위포 PICK!", "🔥 사용자 트렌드", "🥰 내 취향 가득", "👩‍🔬 스윕 Lab"]
    @State private var selectedButton: String = "전체"

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 4) {
                ForEach(buttonTitles, id: \.self) { title in
                    Button(action: {
                        selectedButton = title
                    }) {
                        Text(title)
                            .font(.Subhead3)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(selectedButton == title ? .mainNormal : .white)
                            )
                            .foregroundColor(selectedButton == title ? .white : .mainNormal)
                    }
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

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                // 모달 뷰
                VStack {
                    Capsule()
                        .frame(width: 50, height: 5)
                        .foregroundColor(.white)
                        .padding(.top, 11)

                    ScrollView {
                        VStack(spacing: 20) {
                            Text("내용")
                                .font(.Headline)
                        }
                        .padding()
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
