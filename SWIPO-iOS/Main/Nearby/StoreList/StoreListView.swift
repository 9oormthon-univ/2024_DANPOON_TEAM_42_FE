//
//  StoreListView.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/18/24.
//

import SwiftUI

struct StoreListView: View {

    let stores: [Store] = sampleStores

    @State var searchText: String = ""

    @State var categoryModal: Bool = false
    @State var category: String = "전체"

    @State var sortModal: Bool = false
    @State var sort: String = "가까운순"

    var body: some View {
        ZStack {
            VStack {
                NavigationBar(title: "내 주변 가맹점", showBackButton: true)
                    .padding(.horizontal, 17)

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
                .padding(.horizontal, 17)
                .shadow(radius: 2)
                .padding(.top, 8)
                
                HStack {
                    Button(action: {
                        categoryModal.toggle()
                    }) {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 87 * Constants.ControlWidth, height: 34 * Constants.ControlHeight)
                            .foregroundColor(.greyDark)
                            .overlay {
                                HStack {
                                    Text(category)
                                        .foregroundColor(Color.white)
                                        .font(.Body2)
                                    Image("down")
                                        .resizable()
                                        .frame(width: 24 * Constants.ControlWidth, height: 24 * Constants.ControlHeight)
                                        .foregroundColor(Color.white)
                                }
                            }
                            .sheet(isPresented: $categoryModal) {
                                StoreOptionView(
                                    isModalVisible: $categoryModal,
                                    selectedOption: $category,
                                    options: ["전체", "카페", "디저트", "음식점", "마트", "소품샵", "숙박"],
                                    height: 532
                                )
                                .background(ClearBackgroundView())
                                .foregroundColor(.white)
                                .presentationDetents([.height(532 * Constants.ControlHeight)])
                            }
                    }

                    Button(action: {
                        sortModal.toggle()
                    }) {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 116 * Constants.ControlWidth, height: 34 * Constants.ControlHeight)
                            .foregroundColor(.greyDark)
                            .overlay {
                                HStack {
                                    Text(sort)
                                        .foregroundColor(Color.white)
                                        .font(.Body2)
                                    Image("down")
                                        .resizable()
                                        .frame(width: 24 * Constants.ControlWidth, height: 24 * Constants.ControlHeight)
                                        .foregroundColor(Color.white)
                                }
                            }
                            .sheet(isPresented: $sortModal) {
                                StoreOptionView(
                                    isModalVisible: $sortModal,
                                    selectedOption: $sort,
                                    options: ["인기순", "추천순", "별점순", "가까운순", "관심등록순"],
                                    height: 416
                                )
                                    .background(ClearBackgroundView())
                                    .foregroundColor(.white)
                                    .presentationDetents([.height(416 * Constants.ControlHeight)])
                            }
                    }

                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 8)

                ScrollView {
                    ForEach(stores) { store in
                        StoreRowView(store: store)
                            .padding(.horizontal)
                            .padding(.bottom, 33)
                    }
                }
                .padding(.top, 20)
                .padding(.bottom, 40)
            }.background(Color.black)

            VStack {
                Spacer()

                HStack {
                    Spacer()

                    Button(action: {
                    }) {
                        Circle()
                            .frame(width: 42 * Constants.ControlWidth, height: 42 * Constants.ControlHeight)
                            .foregroundColor(.greyLightHover)
                            .overlay {
                                Image("up")
                                    .resizable()
                                    .frame(width: 24 * Constants.ControlWidth, height: 24 * Constants.ControlHeight)
                                    .foregroundColor(.black)
                            }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 10)

                Button(action: {
                }, label: {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 360 * Constants.ControlWidth, height: 54 * Constants.ControlHeight)
                        .foregroundColor(.mainNormal)
                        .overlay {
                            Text("결제하기")
                                .foregroundColor(Color.white)
                                .font(.Subhead3)
                        }
                })
            }
        }
        .navigationBarBackButtonHidden()
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

struct StoreRowView: View {
    let store: Store

    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                Image(store.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 160)
                    .clipped()
                Image(store.isFavorite ? .heartFilled : .heart)
                    .resizable()
                    .frame(width: 27 * Constants.ControlWidth, height: 27 * Constants.ControlHeight)
                    .padding(10)
                    .foregroundColor(.white)
            }

            VStack(alignment: .leading, spacing: 5) {
                Text(store.name)
                    .font(.Headline)
                    .foregroundColor(.white)
                Text(store.address)
                    .font(.Body2)
                    .foregroundColor(.white)

                HStack {
                    RoundedRectangle(cornerRadius: 6)
                        .frame(width: 80 * Constants.ControlWidth, height: 24 * Constants.ControlHeight)
                        .foregroundColor(.greyNormal)
                        .overlay {
                            Text(store.point)
                                .foregroundColor(Color.white)
                                .font(.Subhead2)
                        }

                    if store.isHot {
                        RoundedRectangle(cornerRadius: 6)
                            .frame(width: 61 * Constants.ControlWidth, height: 24 * Constants.ControlHeight)
                            .foregroundColor(.greyNormal)
                            .overlay {
                                Text("HOT🔥")
                                    .foregroundColor(Color.white)
                                    .font(.Subhead2)
                            }
                    }

                    Spacer()

                    HStack(spacing: 2) {
                        Image("favorite")
                            .resizable()
                            .frame(width: 16 * Constants.ControlWidth, height: 16 * Constants.ControlHeight)
                        Text("\(store.rating, specifier: "%.1f")")
                            .font(.Subhead3)
                        Text("(\(store.reviewCount))")
                            .font(.Subhead2)
                            .foregroundColor(.greyLightHover)
                    }
                }
                .padding(.top, 8)
            }
            .padding(.top, 12)
            .padding(.horizontal, 10)
        }
    }
}

#Preview {
    StoreListView()
}
