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
    private var mapView = MapView()

    var body: some View {
        ZStack {
            mapView

            VStack {
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
                .frame(height: 40 * Constants.ControlHeight)
                .background(Color.white)
                .cornerRadius(14)
                .padding(.horizontal)
                .shadow(radius: 2)
                .padding(.top, 18)

                HStack {
                    Button(action: {
                    }) {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: 173 * Constants.ControlWidth, height: 40 * Constants.ControlHeight)
                            .foregroundColor(.white)
                            .cornerRadius(14)
                            .shadow(radius: 2)
                            .overlay {
                                HStack {
                                    Image("location")
                                        .resizable()
                                        .frame(width: 24 * Constants.ControlWidth, height: 24 * Constants.ControlHeight)
                                        .foregroundColor(Color.greyLightActive)
                                    Text("내 위치 새로고침")
                                        .foregroundColor(Color.greyLightActive)
                                        .font(.Body2)
                                }
                            }
                    }

                    Spacer()

                    Button(action: {
                        AppState.shared.navigationPath.append(mainType.storeList)
                    }, label: {
                            RoundedRectangle(cornerRadius: 16)
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
                .padding(.horizontal)

                Spacer()

                Button(action: {
                }) {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 360 * Constants.ControlWidth, height: 54 * Constants.ControlHeight)
                        .foregroundColor(.mainNormal)
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
                Text("내 주변 가맹점")
                    .font(.title)
                    .foregroundColor(.white)
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
