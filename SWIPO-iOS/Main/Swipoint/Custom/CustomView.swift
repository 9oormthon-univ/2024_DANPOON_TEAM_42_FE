//
//  CustomView.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/19/24.
//

import SwiftUI

struct CustomView: View {
    
    @ObservedObject var appState = AppState.shared
    @State var makeStopModal: Bool = false
    @State var makeFinishModal: Bool = false
    @State var generatedImage: UIImage?
    @Binding var region: String
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                
                if appState.swipointTutorial {
                    CustomNavigationBar(title: "스위포인트",
                                        imageType: "question_circle_mark_8b8b8b",
                                        stopModal: $makeStopModal, blur: true)
                    
                    CustomTutorialView()
                    
                } else {
                    CustomNavigationBar(title: "스위포인트",
                                        imageType: "question_circle_mark",
                                        stopModal: $makeStopModal, blur: false)
                    
                    CustomMainView(generatedImage: $generatedImage, makeFinishModal: $makeFinishModal)
                        .padding(.top, 27 * Constants.ControlHeight)
                    
                    Spacer()
                }
            }
            
        }
        .toolbar(.hidden)
        .sheet(isPresented: $makeStopModal, content: {
            CustomStopModal(makeStopModal: $makeStopModal)
                .background(ClearBackgroundView())// 팝업 뷰 height 조절
                .presentationDetents([.height(240 * Constants.ControlHeight)])
        })
        .sheet(isPresented: $makeFinishModal, content: {
            CustomFinishModal(makeFinishModal: $makeFinishModal)
                .background(ClearBackgroundView())// 팝업 뷰 height 조절
                .presentationDetents([.height(240 * Constants.ControlHeight)])
        })
        .navigationDestination(for: customType.self) { view in
            switch view {
            case .register:
                CustomRegisterView(generatedImage: $generatedImage, region: $region)
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
}

struct CustomTutorialView: View {
    
    let tutorial: [String] = ["swipoint_tutorial1", "swipoint_tutorial2", "swipoint_tutorial3"]
    @State private var currentIndex: Int = 0
    @ObservedObject var appState = AppState.shared
    
    var body: some View {
        ZStack{
            if currentIndex < tutorial.count {
                Image(tutorial[currentIndex])
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
    
    var expression: [String] = ["expression1", "expression2", "expression3", "expression4"]
    var expressionLayout: [GridItem] = [GridItem(.flexible())]
    
    var region: [String] = ["seoul", "gyeongnam", "gyeonggi", "incheon", "gangwon", "chungcheongnam", "daejeon", "chungcheongbuk", "sejong", "busan", "ulsan", "daegu", "gyeongsangbuk", "jeollanam", "gwanju", "jeollabuk", "jeju"]
    var regionLayout: [GridItem] = [GridItem(.flexible())]
    @Binding var generatedImage: UIImage? // 생성된 이미지를 저장
    
    @Binding var makeFinishModal: Bool
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                VStack(spacing: 0){
                    
                    ZStack {
                        // 카드 배경
                        cardContent
                    }
                    .frame(width: 242.21 * Constants.ControlWidth, height: 384.1 * Constants.ControlHeight)
                    .clipped()
                    .padding(.bottom, 39.9 * Constants.ControlHeight)
                    
                    
                    
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
                                                .frame(width: 61.34 * Constants.ControlWidth, height: 61.34 * Constants.ControlHeight)
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
                        .padding(.bottom, 23 * Constants.ControlHeight)
                    
                    
                    
                    Button(action: {
                        makeFinishModal = true
                        saveCardAsImage()
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
    
    var cardContent: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 8.4)
                .foregroundColor(.greyDarkHover) // 배경색 설정
                .frame(width: 242.21 * Constants.ControlWidth, height: 384.1 * Constants.ControlHeight)
            
            ForEach(stickers.indices, id: \.self) { index in
                DraggableStickerView(
                    sticker: stickers[index],
                    isSelected: stickers[index].id == selectedStickerID,
                    cardFrame: CGSize(
                        width: 242.21 * Constants.ControlWidth,
                        height: 384.1 * Constants.ControlHeight
                    ),
                    onUpdatePosition: { newPosition in
                        stickers[index].position = newPosition
                    },
                    onTap: {
                        if stickers[index].isSelectable {
                            selectedStickerID = stickers[index].id
                            stickers[index].isSelectable = false // 선택 불가 상태로 변경
                        }
                    }
                )
            }
            
            Image("swipoint_card_basic")
                .resizable()
                .scaledToFit()
                .frame(width: 242.21 * Constants.ControlWidth, height: 384.1 * Constants.ControlHeight)
                .clipped()
                .zIndex(1)
                .allowsHitTesting(false)
        }
    }
    
    var cardContentWithoutLight: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8.4)
                .foregroundColor(.greyDarkHover) // 배경색 설정
                .frame(width: 242.21 * Constants.ControlWidth, height: 384.1 * Constants.ControlHeight)
            
            ForEach(stickers.indices, id: \.self) { index in
                let stickerImage = stickers[index].image.replacingOccurrences(of: "_light", with: "")
                Image(stickerImage)
                    .resizable()
                    .frame(width: calculateStickerSize(for: stickers[index]).width,
                           height: calculateStickerSize(for: stickers[index]).height)
                    .position(stickers[index].position)
            }
            
            Image("swipoint_card_basic")
                .resizable()
                .scaledToFit()
                .frame(width: 242.21 * Constants.ControlWidth, height: 384.1 * Constants.ControlHeight)
                .clipped()
                .zIndex(1)
                .allowsHitTesting(false)
        }
    }
    @MainActor func saveCardAsImage() {
        let renderer = ImageRenderer(content: cardContentWithoutLight) // `_light`가 제거된 콘텐츠 사용
        renderer.scale = UIScreen.main.scale // 고화질 저장을 위한 스케일 설정
        
        if let image = renderer.uiImage {
            // UIImage를 JPEG 데이터로 변환 (1.0은 최대 품질)
            if let jpegData = image.jpegData(compressionQuality: 1.0) {
                // JPEG 데이터를 UIImage로 다시 변환
                if let highQualityImage = UIImage(data: jpegData) {
                    generatedImage = highQualityImage // 이미지 저장
                    
                    // 여기서 파일로 저장하거나 서버로 전송 가능
                    saveToDocuments(imageData: jpegData) // 예시
                }
            }
        }
    }
    
    // 파일 저장 예제 (옵션)
    func saveToDocuments(imageData: Data) {
        let fileManager = FileManager.default
        if let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentsURL.appendingPathComponent("\(region).jpeg")
            do {
                try imageData.write(to: fileURL)
                print("Image saved to: \(fileURL.path)")
            } catch {
                print("Error saving image: \(error)")
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
        
        Image(sticker.isSelectable && isSelected ? "\(sticker.image)_light" : sticker.image)
            .resizable()
            .frame(width: stickerSize.width, height: stickerSize.height)
            .position(CGPoint(
                x: max(0, min(cardFrame.width, sticker.position.x + dragOffset.width)),
                y: max(0, min(cardFrame.height, sticker.position.y + dragOffset.height))
            ))
            .zIndex(isSelected ? 1 : 0)
            .gesture(
                isSelected && sticker.isSelectable ? DragGesture() // 선택된 경우에만 드래그 가능
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
                : nil // 선택되지 않은 경우 드래그 동작 없음
            )
            .onTapGesture {
                if sticker.isSelectable { // 선택 가능 여부 확인
                    onTap()
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 8.4))
    }
}

/// 스티커 유형에 따라 크기를 계산하는 함수
private func calculateStickerSize(for sticker: StickerItemModel) -> CGSize {
    if sticker.type == .expression {
        return CGSize(width: 95.58 * Constants.ControlWidth, height: 69.63 * Constants.ControlHeight)
    } else if sticker.type == .region {
        return CGSize(width: 231.16 * Constants.ControlWidth, height: 231.16 * Constants.ControlHeight)
    } else {
        return CGSize(width: 95.58 * Constants.ControlWidth, height: 69.63 * Constants.ControlHeight) // 기본값
    }
}

enum StickerType {
    case expression
    case region
}

enum customType{
    case register
}

struct CustomNavigationBar: View {
    let title: String
    let imageType: String
    @Binding var stopModal: Bool
    var blur: Bool
    
    var body: some View {
        if blur {
            ZStack {
                HStack {
                    Image(blur == false ? "back_btn" : "back_btn_8b8b8b")
                    
                    Spacer()
                    
                    // 네비게이션 타이틀
                    Text(title)
                        .font(.Headline)
                        .foregroundColor(blur == false ? .greyLighter : Color(hex: "8B8B8B"))
                    
                    Spacer()
                    
                    Image(imageType)
                        .frame(width: 38 * Constants.ControlWidth)
                }
                .frame(height: 58 * Constants.ControlHeight)
            }
            .background(Color(hex: "0B0B0B"))
            .padding(.top, 10 * Constants.ControlHeight)
        } else {
            ZStack {
                HStack {
                    // 뒤로가기 버튼
                    Button(action: {
                        stopModal = true
                    }, label: {
                        Image(blur == false ? "back_btn" : "back_btn_8b8b8b")
                    })
                    
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
}

#Preview {
    CustomView(region: .constant(""))
}
