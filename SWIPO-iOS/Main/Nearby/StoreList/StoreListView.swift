//
//  StoreListView.swift
//  SWIPO-iOS
//
//  Created by 박지윤 on 11/18/24.
//

import SwiftUI

struct StoreListView: View {

    @StateObject var viewModel = StoreViewModel()

    @State var searchText: String = ""

    @State var categoryModal: Bool = false
    @State var category: String = "전체"

    @State var sortModal: Bool = false
    @State var sort: String = "스위포 PICK!"

    @State var payButtonEnable: Bool = false

    var filteredStores: [StoreModel] {
        viewModel.state.sampleStores.filter { store in
            let matchesSearch = searchText.isEmpty || store.name.contains(searchText)
            let matchesCategory = category == "전체" || store.category == category
            return matchesSearch && matchesCategory
        }
    }

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
                                StoreOptionModal(
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
                            .frame(width: 141 * Constants.ControlWidth, height: 34 * Constants.ControlHeight)
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
                                StoreOptionModal(
                                    isModalVisible: $sortModal,
                                    selectedOption: $sort,
                                    options: ["스위포 PICK!", "사용자 트렌드", "내 취향 가득", "관심 등록순", "전체 인기순", "별점순", "가까운순"],
                                    height: 532
                                )
                                .background(ClearBackgroundView())
                                .foregroundColor(.white)
                                .presentationDetents([.height(532 * Constants.ControlHeight)])
                            }
                    }

                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 8)

                ScrollView {
                    if filteredStores.isEmpty {
                        VStack {
                            Text("검색 결과가 없습니다.")
                                .font(.Body2)
                                .foregroundColor(.greyLightHover)
                                .padding(.top, 20)
                        }
                    } else {
                        ForEach(filteredStores, id: \.name) { store in
                            StoreRowView(store: store)
                                .padding(.bottom, 13)
                        }
                    }
                }
                .padding(.bottom, 58)
            }
            .background(.black)

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
                        .disabled(payButtonEnable)
                        .foregroundColor(payButtonEnable ? .mainNormal : .mainLightActive)
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
    var store: StoreModel

    @State private var imageCurrentIndex: Int = 0
    @State private var reviewCurrentIndex: Int = 0

    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 0)
                    .frame(width: .infinity, height: 160 * Constants.ControlHeight)
                    .foregroundColor(.clear)
                    .overlay {
                        VStack(spacing: 0) {
                            TabView(selection: $imageCurrentIndex) {
                                ForEach(store.imageName.indices, id: \.self) { index in
                                    VStack {
                                        Image(store.imageName[index])
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(height: 160)
                                            .clipped()
                                    }
                                    .tag(index)
                                }
                            }
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        }
                    }
                    .overlay {
                        VStack {
                            Spacer()

                            HStack(spacing: 6) {
                                ForEach(store.imageName.indices, id: \.self) { index in
                                    Circle()
                                        .fill(index == reviewCurrentIndex ? .white : .white.opacity(0.64))
                                        .frame(width: 6 * Constants.ControlWidth, height: 6 * Constants.ControlHeight)
                                }
                            }
                            .padding(.bottom, 12 * Constants.ControlHeight)
                        }
                    }
                    .overlay {
                        VStack {
                            Spacer()

                            HStack {
                                Spacer()

                                RoundedRectangle(cornerRadius: 4)
                                    .frame(width: 49 * Constants.ControlWidth, height: 24 * Constants.ControlHeight)
                                    .foregroundColor(.black.opacity(0.6))
                                    .overlay {
                                        Text("\(imageCurrentIndex + 1)/\(store.imageName.count)")
                                            .foregroundColor(Color.white)
                                            .font(.Caption)
                                    }
                            }
                                                }
                        .padding(.trailing, 15)
                        .padding(.bottom, 6)
                    }
                    .overlay {
                        VStack {
                            HStack {
                                Spacer()

                                Button(action: {
//                                    store.isFavorite.toggle()
                                }) {
                                    Image(store.isFavorite ? .heartFilled : .heart)
                                        .resizable()
                                        .frame(width: 27 * Constants.ControlWidth, height: 27 * Constants.ControlHeight)
                                        .foregroundColor(.white)
                                }
                            }

                            Spacer()
                        }
                        .padding(.top, 12)
                        .padding(.trailing, 15)
                    }
                    .padding(.top, 20)
            }

            VStack(alignment: .leading, spacing: 5) {
                Text(store.name)
                    .font(.Headline)
                    .foregroundColor(.white)
                Text(store.address)
                    .font(.Body2)
                    .foregroundColor(.white)

                HStack(spacing: 4) {
                    RoundedRectangle(cornerRadius: 6)
                        .frame(width: 80 * Constants.ControlWidth, height: 24 * Constants.ControlHeight)
                        .foregroundColor(.white)
                        .overlay (
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.mainLightActive, lineWidth: 1))
                        .overlay {
                            Text("Point \(store.point)%")
                                .foregroundColor(.mainNormal)
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

                // 리뷰
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 360 * Constants.ControlWidth, height: 74 * Constants.ControlHeight)
                    .foregroundColor(.greyDarkHover)
                    .overlay {
                        VStack(spacing: 0) {
                            TabView(selection: $reviewCurrentIndex) {
                                ForEach(store.review.indices, id: \.self) { index in
                                    VStack {
                                        Text(store.review[index])
                                            .font(.Body1)
                                            .foregroundStyle(.greyLightHover)
                                            .multilineTextAlignment(.leading)
                                    }
                                    .padding(.top, 8 * Constants.ControlHeight)
                                    .tag(index)
                                }
                            }
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

                            HStack(spacing: 6) {
                                ForEach(store.review.indices, id: \.self) { index in
                                    Circle()
                                        .fill(index == reviewCurrentIndex ? .greyNormal : .greyDark)
                                        .frame(width: 6 * Constants.ControlWidth, height: 6 * Constants.ControlHeight)
                                }
                            }
                            .padding(.bottom, 12 * Constants.ControlHeight)
                        }
                    }
                    .padding(.top, 18)
            }
            .padding(.top, 12)
            .padding(.horizontal, 10)
        }
    }
}

#Preview {
    StoreListView()
}

struct ReviewItem: View {
    var review: String
    
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                Text(review)
                    .font(.Subhead3)
                    .foregroundColor(.white)
            }
        }
    }
}
