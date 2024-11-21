//
//  SwipstoneView.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/20/24.
//

import SwiftUI

struct SwipstoneView: View {
    @State private var selectedCardIndex: Int = 0 // 현재 선택된 카드 인덱스
    @StateObject var viewModel = SwipstoneViewModel()
    @State var achiveModal = false
    @State var point: String = ""
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                if viewModel.state.getSwipstoneResponse[selectedCardIndex].collect {
                    Image("swipstone_cloud")
                        .overlay {
                            Text("스톤 카드를 완성했어요!\n터치하여 포인트를 획득해 주세요!")
                                .font(.Subhead2)
                                .foregroundColor(.mainNormal)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, 350 * Constants.ControlHeight)
                }
            }.zIndex(1)
            
            
            VStack(spacing: 0){
                ScrollView(.horizontal, showsIndicators: false) {
                    ScrollViewReader { proxy in
                        HStack(spacing: 25) {
                            
                            Spacer()
                                .padding(.trailing, 31 * Constants.ControlWidth)
                            
                            ForEach(viewModel.state.getSwipstoneResponse, id: \.id) { data in
                                SwipstoneCardView(point: data.point, collect: data.collect, achive: data.achieve, viewModel: viewModel)
                                    .onTapGesture {
                                        withAnimation(.easeInOut) {
                                            selectedCardIndex = Int(data.id)
                                            proxy.scrollTo(Int(data.id), anchor: .center)
                                        }
                                    }
                                    .id(Int(data.id))
                            }
                            
                            Spacer()
                                .padding(.leading, 31 * Constants.ControlWidth)
                        }
                    }
                }
                .scrollDisabled(true)
                .padding(.bottom)
                .padding(.top, -30 * Constants.ControlHeight)
                
                
                Rectangle()
                    .frame(height: 78 * Constants.ControlHeight)
                    .foregroundColor(.greyDark)
                    .overlay {
                        ScrollView(.horizontal){
                            HStack(spacing: 20 * Constants.ControlWidth){
                                ForEach(viewModel.state.getSwipstonePieceResponse, id: \.id){ data in
                                    Image(data.region)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 61.34 * Constants.ControlWidth, height: 61.34 * Constants.ControlHeight)
                                        .overlay {
                                            if data.count > 1{
                                                VStack(spacing: 0){
                                                    Spacer()
                                                    
                                                    HStack(spacing: 0){
                                                        Spacer()
                                                        
                                                        Image("swipstone_piece_count")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 22 * Constants.ControlWidth, height: 22 * Constants.ControlHeight)
                                                            .overlay {
                                                                Text("\(data.count)")
                                                                    .font(.Caption)
                                                                    .foregroundColor(.white)
                                                            }
                                                    }
                                                }
                                            }
                                        }
                                }
                            }
                        }
                    }
                    .padding(.bottom)
                
                Button(action: {
                    if viewModel.state.getSwipstoneResponse[selectedCardIndex].achieve == false {
                        // 모든 조각을 가지고 있는지 확인
                        if viewModel.state.getSwipstoneResponse[selectedCardIndex].collect == true {
                            // 조각을 차감하고 상태를 업데이트
                            point = viewModel.state.getSwipstoneResponse[selectedCardIndex].point
                            achiveModal = true
                            viewModel.pieceSubtract(selectedCardIndex: selectedCardIndex)
                        } else {
                            print("조각이 부족합니다.")
                        }
                    }
                    print("현재 상태: \(viewModel.state.getSwipstoneResponse[selectedCardIndex])")
                }, label: {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 360 * Constants.ControlWidth, height: 54 * Constants.ControlHeight)
                        .foregroundColor(.mainNormal)
                        .overlay {
                            Text("추가 포인트 얻기")
                                .font(.Subhead3)
                                .tracking(-0.6)
                                .foregroundColor(.white)
                        }
                })
            }
        }
        .onAppear(){
            for index in 0..<viewModel.state.getSwipstoneResponse.count{
                viewModel.containAllPieces(selectedCardIndex: index)
            }
        }
        .sheet(isPresented: $achiveModal, content: {
            SwipstoneAchiveModal(point: $point, achiveModal: $achiveModal)
                .background(ClearBackgroundView())// 팝업 뷰 height 조절
                .presentationDetents([.height(384 * Constants.ControlHeight)])
        })
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

struct SwipstoneCardView: View {
    
    var point: String
    var collect: Bool
    var achive: Bool
    
    @ObservedObject var viewModel: SwipstoneViewModel
    
    var body: some View {
        ZStack{
            if achive{
                if point == "5,000"{
                    Image("swipstone_card_collect_5000")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 242 * Constants.ControlWidth, height: 456 * Constants.ControlHeight)
                        .overlay {
                            ZStack{
                                VStack(spacing: 0){
                                    ZStack{
                                        
                                        Image(viewModel.getUpdatedPieceImage(pieceName: "sejong"))
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 231.16 * Constants.ControlWidth, height: 231.16 * Constants.ControlHeight)
                                            .offset(y: 10 * Constants.ControlHeight)
                                            .overlay {
                                                Image("expression4")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 95.58 * Constants.ControlWidth, height: 69.63 * Constants.ControlHeight)
                                                    .offset(y: 10 * Constants.ControlHeight)
                                            }
                                        
                                        Image(viewModel.getUpdatedPieceImage(pieceName: "gyeongnam"))
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 231.16 * Constants.ControlWidth, height: 231.16 * Constants.ControlHeight)
                                            .offset(y: 180 * Constants.ControlHeight)
                                    }
                                    .padding(.top, 60 * Constants.ControlHeight)
                                    
                                    Spacer()
                                }
                            }
                            Image("swipoint_card_basic")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 239 * Constants.ControlWidth, height: 384.1 * Constants.ControlHeight)
                                .offset(y: 35 * Constants.ControlHeight)
                                .zIndex(1)
                        }
                }
                
                else if point == "10,000"{
                    Image("swipstone_card_collect_10000")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 242 * Constants.ControlWidth, height: 456 * Constants.ControlHeight)
                        .overlay {
                            ZStack{
                                VStack(spacing: 0){
                                    
                                    ZStack{
                                        Image(viewModel.getUpdatedPieceImage(pieceName: "ulsan"))
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 231.16 * Constants.ControlWidth, height: 231.16 * Constants.ControlHeight)
                                            .offset(y: 10 * Constants.ControlHeight)
                                            .overlay {
                                                Image("expression1")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 95.58 * Constants.ControlWidth, height: 69.63 * Constants.ControlHeight)
                                                    .offset(y: 10 * Constants.ControlHeight)
                                            }
                                        
                                        Image(viewModel.getUpdatedPieceImage(pieceName: "chungcheongnam")
                                        )
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 231.16 * Constants.ControlWidth, height: 231.16 * Constants.ControlHeight)
                                        .offset(y: 180 * Constants.ControlHeight)
                                    }
                                    .padding(.top, 50 * Constants.ControlHeight)
                                    
                                    Spacer()
                                }
                                Image("swipoint_card_basic")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 239 * Constants.ControlWidth, height: 384.1 * Constants.ControlHeight)
                                    .offset(y: 35 * Constants.ControlHeight)
                                    .zIndex(1)
                            }
                        }
                }
                
                else if point == "15,000"{
                    Image("swipstone_card_collect_15000")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 242 * Constants.ControlWidth, height: 456 * Constants.ControlHeight)
                        .overlay {
                            ZStack{
                                VStack(spacing: 0){
                                    ZStack{
                                        Image(viewModel.getUpdatedPieceImage(pieceName: "gwanju"))
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 231.16 * Constants.ControlWidth, height: 231.16 * Constants.ControlHeight)
                                            .offset(y: 10 * Constants.ControlHeight)
                                            .offset(x: -25 * Constants.ControlWidth)
                                            .overlay {
                                                Image("expression2")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 95.58 * Constants.ControlWidth, height: 69.63 * Constants.ControlHeight)
                                                    .offset(y: 10 * Constants.ControlHeight)
                                                    .offset(x: -25 * Constants.ControlWidth)
                                            }
                                        
                                        Image(viewModel.getUpdatedPieceImage(pieceName: "jeollanam"))
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 231.16 * Constants.ControlWidth, height: 231.16 * Constants.ControlHeight)
                                            .offset(y: 8 * Constants.ControlHeight)
                                            .offset(x: 150 * Constants.ControlHeight)
                                        
                                        Image(viewModel.getUpdatedPieceImage(pieceName: "chungcheongnam"))
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 231.16 * Constants.ControlWidth, height: 231.16 * Constants.ControlHeight)
                                            .clipped()
                                            .offset(y: 180 * Constants.ControlHeight)
                                            .offset(x: 90 * Constants.ControlWidth)
                                        
                                        Image(viewModel.getUpdatedPieceImage(pieceName: "gangwon"))
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 231.16 * Constants.ControlWidth, height: 231.16 * Constants.ControlHeight)
                                            .clipped()
                                            .offset(y: 180 * Constants.ControlHeight)
                                            .offset(x: -80 * Constants.ControlWidth)
                                        
                                    }
                                    .padding(.top, 60 * Constants.ControlHeight)
                                    
                                    Spacer()
                                }
                                
                                Image("swipoint_card_basic")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 239 * Constants.ControlWidth, height: 384.1 * Constants.ControlHeight)
                                    .offset(y: 35 * Constants.ControlHeight)
                                    .zIndex(1)
                            }
                        }
                    
                    
                }
            } else {
                ZStack{
                    if point == "5,000"{
                        Image("swipstone_card_5000")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 242 * Constants.ControlWidth, height: 456 * Constants.ControlHeight)
                            .overlay {
                                ZStack{
                                    VStack(spacing: 0){
                                        ZStack{
                                            Image(viewModel.getUpdatedPieceImage(pieceName: "sejong"))
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 231.16 * Constants.ControlWidth, height: 231.16 * Constants.ControlHeight)
                                                .offset(y: 10 * Constants.ControlHeight)
                                                .overlay {
                                                    Image("expression4")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 95.58 * Constants.ControlWidth, height: 69.63 * Constants.ControlHeight)
                                                        .offset(y: 10 * Constants.ControlHeight)
                                                }
                                            
                                            Image(viewModel.getUpdatedPieceImage(pieceName: "gyeongnam"))
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 231.16 * Constants.ControlWidth, height: 231.16 * Constants.ControlHeight)
                                                .offset(y: 180 * Constants.ControlHeight)
                                        }
                                        .padding(.top, 60 * Constants.ControlHeight)
                                        
                                        Spacer()
                                    }
                                }
                                Image("swipoint_card_basic")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 239 * Constants.ControlWidth)
                                    .offset(y: 35 * Constants.ControlHeight)
                                    .zIndex(1)
                                
                            }
                    }
                    
                    else if point == "10,000"{
                        Image("swipstone_card_10000")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 242 * Constants.ControlWidth, height: 456 * Constants.ControlHeight)
                            .overlay {
                                ZStack{
                                    VStack(spacing: 0){
                                        ZStack{
                                            Image(viewModel.getUpdatedPieceImage(pieceName: "ulsan"))
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 231.16 * Constants.ControlWidth, height: 231.16 * Constants.ControlHeight)
                                                .offset(y: 10 * Constants.ControlHeight)
                                                .overlay {
                                                    Image("expression1")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 95.58 * Constants.ControlWidth, height: 69.63 * Constants.ControlHeight)
                                                        .offset(y: 10 * Constants.ControlHeight)
                                                }
                                            
                                            Image(viewModel.getUpdatedPieceImage(pieceName: "chungcheongnam"))
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 231.16 * Constants.ControlWidth, height: 231.16 * Constants.ControlHeight)
                                                .offset(y: 180 * Constants.ControlHeight)
                                        }
                                        .padding(.top, 50 * Constants.ControlHeight)
                                        
                                        Spacer()
                                    }
                                    Image("swipoint_card_basic")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 239 * Constants.ControlWidth, height: 384.1 * Constants.ControlHeight)
                                        .offset(y: 35 * Constants.ControlHeight)
                                        .zIndex(1)
                                }
                            }
                    }
                    
                    else if point == "15,000"{
                        Image("swipstone_card_15000")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 242 * Constants.ControlWidth, height: 456 * Constants.ControlHeight)
                            .overlay {
                                ZStack{
                                    VStack(spacing: 0){
                                        
                                        ZStack{
                                            Image(viewModel.getUpdatedPieceImage(pieceName: "gwanju"))
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 231.16 * Constants.ControlWidth, height: 231.16 * Constants.ControlHeight)
                                                .offset(y: 10 * Constants.ControlHeight)
                                                .offset(x: -25 * Constants.ControlWidth)
                                                .overlay {
                                                    Image("expression2")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 95.58 * Constants.ControlWidth, height: 69.63 * Constants.ControlHeight)
                                                        .offset(y: 10 * Constants.ControlHeight)
                                                        .offset(x: -25 * Constants.ControlWidth)
                                                }
                                            Image(viewModel.getUpdatedPieceImage(pieceName: "jeollanam"))
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 231.16 * Constants.ControlWidth, height: 231.16 * Constants.ControlHeight)
                                                .offset(y: 10 * Constants.ControlHeight)
                                                .offset(x: 150 * Constants.ControlHeight)
                                            
                                            Image(viewModel.getUpdatedPieceImage(pieceName: "chungcheongnam"))
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 231.16 * Constants.ControlWidth, height: 231.16 * Constants.ControlHeight)
                                                .clipped()
                                                .offset(y: 180 * Constants.ControlHeight)
                                                .offset(x: 90 * Constants.ControlWidth)
                                            
                                            Image(viewModel.getUpdatedPieceImage(pieceName: "gangwon"))
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 231.16 * Constants.ControlWidth, height: 231.16 * Constants.ControlHeight)
                                                .clipped()
                                                .offset(y: 180 * Constants.ControlHeight)
                                                .offset(x: -80 * Constants.ControlWidth)
                                            
                                        }
                                        .padding(.top, 60 * Constants.ControlHeight)
                                        
                                        Spacer()
                                    }
                                }
                                Image("swipoint_card_basic")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 242.21 * Constants.ControlWidth, height: 384.1 * Constants.ControlHeight)
                                    .zIndex(1)
                                    .offset(y: 35 * Constants.ControlHeight)
                            }
                    }
                }
            }
        }
        .clipped()
    }
}

#Preview {
    SwipstoneView()
}
