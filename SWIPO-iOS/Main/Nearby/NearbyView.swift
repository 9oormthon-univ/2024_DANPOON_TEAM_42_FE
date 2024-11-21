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
    private var horizontalScrollButtonView = HorizontalScrollButtonView()

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

                horizontalScrollButtonView

                Spacer()

                Button(action: {
                }) {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 360 * Constants.ControlWidth, height: 54 * Constants.ControlHeight)
                        .disabled(payButtonEnable)
                        .foregroundColor(payButtonEnable ? .mainNormal : .mainLightActive)
                        .overlay {
                            Text("결제하기")
                                .foregroundColor(Color.white)
                                .font(.Subhead3)
                        }
                }
                .padding(.bottom, 30)
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

struct HorizontalScrollButtonView: View {
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
