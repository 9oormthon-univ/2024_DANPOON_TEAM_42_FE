//
//  CustomView.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/19/24.
//

import SwiftUI

struct CustomView: View {
    
    @ObservedObject var appState = AppState.shared
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                
                //                if appState.swipointTutorial {
                //                    ImageBtnNavigationBar(title: "스위포인트",
                //                                          imageType: "question_circle_mark_8b8b8b",
                //                                          showBackButton: true, blur: true)
                //
                //                    CustomTutorialView()
                //                } else {
                //                    ImageBtnNavigationBar(title: "스위포인트",
                //                                          imageType: "question_circle_mark",
                //                                          showBackButton: true, blur: false)
                //
                //                    CustomMainView()
                //                        .padding(.top, 27 * Constants.ControlHeight)
                //                }
                ImageBtnNavigationBar(title: "스위포인트",
                                      imageType: "question_circle_mark",
                                      showBackButton: true, blur: false)
                
                CustomMainView()
                    .padding(.top, 27 * Constants.ControlHeight)
                
                Spacer()
            }
            
        }
        .toolbar(.hidden)
    }
}

struct CustomTutorialView: View {
    
    let tutorial: [String] = ["swipoint_tutorial1", "swipoint_tutorial2", "swipoint_tutorial3"]
    @State private var currentIndex: Int = 0
    @ObservedObject var appState = AppState.shared
    
    var body: some View {
        ZStack{
            if currentIndex < tutorial.count {
                Image(tutorial[currentIndex])
                    .resizable()
                    .scaledToFit()
                    .onTapGesture {
                        if currentIndex < tutorial.count - 1 {
                            // 다음 이미지로 전환
                            currentIndex += 1
                        } else {
                            // 마지막 이미지에서 투토리얼 종료
                            appState.swipointTutorial = false
                        }
                    }
            }
        }
        .animation(.easeInOut, value: currentIndex) // 전환 애니메이션
    }
}

struct CustomMainView: View {
    @State private var stickers: [StickerItemModel] = [] // 카드에 추가된 스티커들
    @State private var selectedStickerID: UUID? = nil // 현재 선택된 스티커 ID
    @State var isPressed: Bool = false
    
    var expression: [String] = ["swipoint_expression1", "swipoint_expression2", "swipoint_expression3", "swipoint_expression4"]
    var expressionLayout: [GridItem] = [GridItem(.flexible())]
    
    var region: [String] = ["seoul", "gyeongnam", "gyeonggi", "incheon", "gangwon", "chungcheongnam", "daejeon", "chungcheongbuk", "sejong", "busan", "ulsan", "daegu", "gyeongsangbuk", "jeollanam", "gwanju", "jeollabuk", "jeju"]
    var regionLayout: [GridItem] = [GridItem(.flexible())]
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                VStack(spacing: 0){
                    
                    ZStack {
                        // 카드 배경
                        RoundedRectangle(cornerRadius: 8.4)
                            .foregroundColor(.greyDarkHover)
                            .frame(width: 242.21 * Constants.ControlWidth, height: 384.1 * Constants.ControlHeight)
                            .clipShape(Rectangle()) // 클립 처리
                        
                        // 카드에 추가된 스티커
                        ForEach(stickers) { sticker in
                            DraggableStickerView(
                                sticker: sticker,
                                isSelected: sticker.id == selectedStickerID,
                                cardFrame: CGSize(
                                    width: 242.21 * Constants.ControlWidth,
                                    height: 384.1 * Constants.ControlHeight
                                ),
                                onUpdatePosition: { newPosition in
                                    if let index = stickers.firstIndex(where: { $0.id == sticker.id }) {
                                        stickers[index].position = newPosition
                                    }
                                },
                                onTap: {
                                    selectedStickerID = sticker.id
                                }
                            )
                        }
                        
                        Image("swipoint_card_basic")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 242.21 * Constants.ControlWidth, height: 384.1 * Constants.ControlHeight)
                            .zIndex(1)
                            .allowsHitTesting(false)
                    }
                    .frame(width: 242 * Constants.ControlWidth, height: 384 * Constants.ControlHeight)
                    .clipped()
                    .padding(.bottom, 40 * Constants.ControlHeight)
                    
                    
                    
                    Rectangle()
                        .frame(height: 78 * Constants.ControlHeight)
                        .foregroundColor(.greyDark)
                        .overlay {
                            LazyHGrid(rows: expressionLayout, spacing: 35 * Constants.ControlWidth) {
                                ForEach(expression, id: \.self) { expressionName in
                                    Image(expressionName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 59.35 * Constants.ControlWidth, height: 43.24 * Constants.ControlHeight)
                                        .onTapGesture {
                                            // 새 스티커 추가
                                            let newSticker = StickerItemModel(
                                                image: expressionName,
                                                position: CGPoint(x: 121 * Constants.ControlWidth, y: 192 * Constants.ControlHeight),
                                                scale: 1.0,
                                                type: .expression
                                            )
                                            stickers.append(newSticker)
                                            selectedStickerID = newSticker.id // 추가한 스티커 선택
                                        }
                                }
                            }
                        }
                        .padding(.bottom, 15 * Constants.ControlHeight)
                    
                    Rectangle()
                        .frame(height: 78 * Constants.ControlHeight)
                        .foregroundColor(.greyDark)
                        .overlay {
                            ScrollViewReader { proxy in
                                ScrollView(.horizontal) {
                                    LazyHGrid(rows: regionLayout, spacing: 20 * Constants.ControlWidth) {
                                        ForEach(region.indices, id: \.self) { index in
                                            Image(region[index])
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 59.35 * Constants.ControlWidth, height: 43.24 * Constants.ControlHeight)
                                                .id(index) // 각 아이템에 고유 ID 추가
                                                .onTapGesture {
                                                    // 새로운 스티커 추가
                                                    let newSticker = StickerItemModel(
                                                        image: region[index],
                                                        position: CGPoint(x: 121 * Constants.ControlWidth, y: 192 * Constants.ControlHeight),
                                                        scale: 1.0,
                                                        type: .region
                                                    )
                                                    stickers.append(newSticker)
                                                    selectedStickerID = newSticker.id // 추가한 스티커 선택
                                                }
                                        }
                                    }
                                }
                                .scrollIndicators(.hidden)
                                .onAppear {
                                    // "대전"이 가운데로 오도록 설정 (기본: "세종")
                                    if let targetIndex = region.firstIndex(of: "sejong") {
                                        proxy.scrollTo(targetIndex, anchor: .center)
                                    }
                                }
                            }
                        }
                        .padding(.bottom, 30 * Constants.ControlHeight)
                    
                    
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 360 * Constants.ControlWidth, height: 54 * Constants.ControlHeight)
                        .foregroundColor(.mainNormal)
                        .overlay {
                            Text("새로운 카드 등록")
                                .font(.Subhead3)
                                .foregroundColor(.white)
                        }
                }
                
                VStack(spacing: 0){
                    
                    HStack(spacing: 0){
                        
                        Spacer()
                        
                        Button(action: {
                            if stickers.isEmpty {
                                
                            } else {
                                stickers.removeLast()
                            }
                        }, label: {
                            Image(isPressed ? "swipoint_card_reset_on" : "swipoint_card_reset_off")
                                .scaledToFit()
                        })
                        .buttonStyle(PlainButtonStyle()) // 기본 버튼 스타일로 변경하여 애니메이션 방지
                        .simultaneousGesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { _ in
                                    isPressed = true // 버튼이 눌렸을 때 이미지 변경
                                }
                                .onEnded { _ in
                                    isPressed = false // 버튼에서 손을 뗐을 때 이미지 복원
                                }
                        )
                    }
                    .padding(.top, 60 * Constants.ControlHeight)
                }
            }
        }
    }
}

struct DraggableStickerView: View {
    var sticker: StickerItemModel
    var isSelected: Bool
    var cardFrame: CGSize
    var onUpdatePosition: (CGPoint) -> Void
    var onTap: () -> Void

    @State private var dragOffset = CGSize.zero

    var body: some View {
        // 선택된 스티커 크기 계산
        let stickerSize = calculateStickerSize(for: sticker)

        Image(sticker.image)
            .resizable()
            .scaledToFit()
            .frame(width: stickerSize.width, height: stickerSize.height)
            .position(CGPoint(
                x: max(0, min(cardFrame.width, sticker.position.x + dragOffset.width)),
                y: max(0, min(cardFrame.height, sticker.position.y + dragOffset.height))
            )) // 카드 영역 내에만 위치하도록 제한
            .zIndex(isSelected ? 1 : 0) // 선택된 스티커는 가장 위로
            .gesture(
                DragGesture()
                    .onChanged { value in
                        dragOffset = value.translation
                    }
                    .onEnded { _ in
                        let newPosition = CGPoint(
                            x: sticker.position.x + dragOffset.width,
                            y: sticker.position.y + dragOffset.height
                        )
                        onUpdatePosition(newPosition)
                        dragOffset = .zero
                    }
            )
            .onTapGesture {
                onTap()
            }
    }

    /// 스티커 유형에 따라 크기를 계산하는 함수
    private func calculateStickerSize(for sticker: StickerItemModel) -> CGSize {
        if sticker.type == .expression {
            return CGSize(width: 95.59 * Constants.ControlWidth, height: 69.63 * Constants.ControlHeight)
        } else if sticker.type == .region {
            return CGSize(width: 231.16 * Constants.ControlWidth, height: 231.16 * Constants.ControlHeight)
        } else {
            return CGSize(width: 95.59 * Constants.ControlWidth, height: 69.63 * Constants.ControlHeight) // 기본값
        }
    }
}

enum StickerType {
    case expression
    case region
}

#Preview {
    CustomView()
}
