//
//  SwipayView.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/18/24.
//

import SwiftUI

struct SwipayView: View {
    
    @StateObject var viewModel = SwipayViewModel()
    @State private var currentIndex: Int = 0
    @State private var newsCurrentIndex: Int = 0
    
    var body: some View {
        ScrollView{
            ZStack{
                VStack(spacing: 12){
                    //스위페이
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 361 * Constants.ControlWidth, height: 214 * Constants.ControlHeight)
                        .scaledToFit()
                        .foregroundColor(.greyDarkHover)
                        .overlay {
                            VStack(spacing: 0){
                                Rectangle()
                                    .frame(width: 361 * Constants.ControlWidth, height: 72 * Constants.ControlHeight)
                                    .scaledToFit()
                                    .overlay{
                                        LinearGradient(gradient: Gradient(colors: [Color(hex: "4F4FFD"), Color(hex: "8C8CFF")]), startPoint: UnitPoint(x: 0.3, y: 0.5), endPoint: .trailing)
                                    }
                                    .cornerRadius(16, corners: .topLeft)
                                    .cornerRadius(16, corners: .topRight)
                                    .overlay {
                                        HStack(spacing: 5){
                                            Image("swipay_P")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 19 * Constants.ControlWidth, height: 22 * Constants.ControlWidth)
                                            
                                            Text("스위페이")
                                                .font(.Headline)
                                                .foregroundColor(.white)
                                            
                                            Spacer()
                                            
                                            Image("swipay_chevron_right")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 32 * Constants.ControlWidth)
                                        }
                                        .padding(.leading, 22 * Constants.ControlWidth)
                                        .padding(.trailing, 22 * Constants.ControlHeight)
                                    }
                                
                                HStack(spacing: 4){
                                    Text("82,597")
                                        .font(.Display3)
                                        .foregroundColor(.white)
                                    
                                    Text("원")
                                        .font(.Display1)
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        AppState.shared.navigationPath.append(swipayType.payment)
                                    }, label: {
                                        RoundedRectangle(cornerRadius: 6)
                                            .frame(width: 66 * Constants.ControlWidth, height: 34 * Constants.ControlHeight)
                                            .foregroundColor(.greyNormalHover)
                                            .overlay {
                                                HStack(spacing: 4){
                                                    Image("swipay_scan")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 20 * Constants.ControlWidth)
                                                    
                                                    Text("결제")
                                                        .font(.Body1)
                                                        .foregroundColor(.white)
                                                }
                                            }
                                            .scaledToFit()
                                    })
                                }
                                .padding(.top, 21 * Constants.ControlHeight)
                                .padding(.leading, 22 * Constants.ControlWidth)
                                .padding(.trailing, 22 * Constants.ControlWidth)
                                .padding(.bottom, 21 * Constants.ControlHeight)
                                
                                HStack(spacing: 0){
                                    Button(action: {
                                        AppState.shared.navigationPath.append(swipayType.payCharge)
                                    }, label: {
                                        RoundedRectangle(cornerRadius: 6)
                                            .frame(width: 156.6 * Constants.ControlWidth, height: 40 * Constants.ControlHeight)
                                            .scaledToFit()
                                            .foregroundColor(.greyNormalHover)
                                            .overlay {
                                                HStack(spacing: 4){
                                                    Image("swipay_kakaopay")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 42 * Constants.ControlWidth, height: 13.18 * Constants.ControlHeight)

                                                    Text("충전")
                                                        .font(.Body1)
                                                        .foregroundColor(.white)
                                                }
                                            }
                                    })
                                    
                                    Spacer()
                                    
                                    RoundedRectangle(cornerRadius: 6)
                                        .frame(width: 156.6 * Constants.ControlWidth, height: 40 * Constants.ControlHeight)
                                        .scaledToFit()
                                        .foregroundColor(.greyNormalActive)
                                        .overlay {
                                            HStack(spacing: 4){
                                                Image("swipay_link")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 20 * Constants.ControlWidth)
                                                
                                                Text("계좌 연동")
                                                    .font(.Body1)
                                                    .foregroundColor(.greyLightActive)
                                            }
                                        }
                                }
                                .padding(.leading, 22 * Constants.ControlWidth)
                                .padding(.trailing, 22 * Constants.ControlWidth)
                                
                                Spacer()
                                
                            }
                        }
                    
                    //소비 생활
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 361 * Constants.ControlWidth, height: 88 * Constants.ControlHeight)
                        .scaledToFit()
                        .foregroundColor(.greyDarkHover)
                        .overlay {
                            HStack(spacing: 0){
                                
                                VStack(spacing: 2){
                                    HStack(spacing: 0){
                                        Text("스위포인트로 알뜰한 소비생활!")
                                            .lineLimit(1)
                                            .font(.Subhead3)
                                            .foregroundColor(.greyLighter)
                                        
                                        Image("swipay_chevron_right_greyLighterHover")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 22 * Constants.ControlWidth)
                                        
                                        Spacer()
                                    }
                                    .padding(.leading, 22 * Constants.ControlWidth)
                                    
                                    HStack(spacing: 4){
                                        Text("11월 받은 혜택 :")
                                            .font(.Body2)
                                            .foregroundColor(.greyLightHover)
                                        
                                        Text("52,100원")
                                            .font(.Body2)
                                            .foregroundColor(.white)
                                        
                                        Spacer()
                                    }
                                    .padding(.leading, 22 * Constants.ControlWidth)
                                }
                                
                                Spacer()
                            }
                            
                            HStack(spacing: 0){
                                Spacer()
                                
                                Image("swipay_character_triangle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 128 * Constants.ControlWidth, height: 88 * Constants.ControlHeight)
                            }
                        }
                    
                    //최근 이용 내역
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 361 * Constants.ControlWidth, height: 158 * Constants.ControlHeight)
                        .scaledToFit()
                        .foregroundColor(.greyDarkHover)
                        .overlay {
                            VStack(spacing: 0){
                                HStack(spacing: 0){
                                    Text("최근 이용 내역")
                                        .font(.Headline)
                                        .foregroundColor(.greyLighter)
                                    
                                    Spacer()
                                    
                                    Image("swipay_chevron_right_greyLighterHover")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 32)
                                        .overlay {
                                            VStack(spacing: 0){
                                                HStack(spacing: 0){
                                                    Spacer()
                                                    
                                                    Circle()
                                                        .frame(width: 6)
                                                        .scaledToFit()
                                                        .foregroundColor(.danger)
                                                }
                                                
                                                Spacer()
                                            }
                                        }
                                }
                                
                                TabView(selection: $currentIndex) {
                                    ForEach(viewModel.state.getRecentUsageResponse.indices, id: \.self) { index in
                                        UsageDetailItem(region: viewModel.state.getRecentUsageResponse[index].region, title: viewModel.state.getRecentUsageResponse[index].title, date: viewModel.state.getRecentUsageResponse[index].date, type: viewModel.state.getRecentUsageResponse[index].type, price: viewModel.state.getRecentUsageResponse[index].price)
                                        .padding(.top, 14 * Constants.ControlHeight)
                                        .tag(index)
                                    }
                                }
                                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                                
                                // 커스텀 인디케이터
                                HStack(spacing: 4) {
                                    ForEach(viewModel.state.getRecentUsageResponse.indices, id: \.self) { index in
                                        Circle()
                                            .fill(index == currentIndex ? Color.white : Color.gray)
                                            .frame(width: 6 * Constants.ControlWidth, height: 6 * Constants.ControlHeight)
                                    }
                                }
                                .padding(.top, 18 * Constants.ControlHeight)
                                
                            }
                            .padding(.top)
                            .padding(.trailing, 22 * Constants.ControlWidth)
                            .padding(.leading, 22 * Constants.ControlWidth)
                            .padding(.bottom)
                        }
                    
                    //스위포인트
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 361 * Constants.ControlWidth, height: 610 * Constants.ControlHeight)
                        .scaledToFit()
                        .foregroundColor(.greyDarkHover)
                        .overlay {
                            VStack(spacing: 0){
                                Rectangle()
                                    .frame(width: 361 * Constants.ControlWidth, height: 72 * Constants.ControlHeight)
                                    .scaledToFit()
                                    .overlay{
                                        LinearGradient(gradient: Gradient(colors: [Color(hex: "4F4FFD"), Color(hex: "8C8CFF")]), startPoint: UnitPoint(x: 0.3, y: 0.5), endPoint: .trailing)
                                    }
                                    .cornerRadius(16, corners: .topLeft)
                                    .cornerRadius(16, corners: .topRight)
                                    .overlay {
                                        HStack(spacing: 5){
                                            Image("swipay_O")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 19 * Constants.ControlWidth, height: 22 * Constants.ControlWidth)
                                            
                                            Text("스위포인트")
                                                .font(.Headline)
                                                .foregroundColor(.white)
                                            
                                            Spacer()
                                            
                                            Button(action: {
                                                AppState.shared.navigationPath.append(swipayType.swipoint)
                                            }, label: {
                                                Image("swipay_chevron_right")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 32 * Constants.ControlWidth)
                                            })
                                        }
                                        .padding(.leading, 22 * Constants.ControlWidth)
                                        .padding(.trailing, 22 * Constants.ControlHeight)
                                    }
                                        
                                
                                SwipayCardView(viewModel: viewModel)
                                    .padding(.leading, 22 * Constants.ControlWidth)
                                    .padding(.top, 22 * Constants.ControlHeight)
                                    .padding(.trailing, 22 * Constants.ControlWidth)
                                    .padding(.bottom)
                                
                                Spacer()
                            }
                        }
                    
                    //소식
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 361 * Constants.ControlWidth, height: 211 * Constants.ControlHeight)
                        .scaledToFit()
                        .foregroundColor(.greyDarkHover)
                        .overlay {
                            VStack(spacing: 0){
                                HStack(spacing: 0){
                                    Text("SWEEP하게 알려주는 소식! 📝")
                                        .font(.Body2)
                                        .foregroundColor(.greyLighter)
                                    
                                    Spacer()
                                    
                                    Image("swipay_chevron_right_greyLighterHover")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 32)
                                        .overlay {
                                            VStack(spacing: 0){
                                                HStack(spacing: 0){
                                                    Spacer()
                                                    
                                                    Circle()
                                                        .frame(width: 6)
                                                        .scaledToFit()
                                                        .foregroundColor(.danger)
                                                }
                                                
                                                Spacer()
                                            }
                                        }
                                }
                                .padding(.top)
                                .padding(.leading, 22 * Constants.ControlWidth)
                                .padding(.trailing, 22 * Constants.ControlWidth)
                            
                                TabView(selection: $newsCurrentIndex) {
                                    ForEach(viewModel.state.getSwipayNewsResponse.indices, id: \.self) { index in
                                        SwipayNewsView(title: viewModel.state.getSwipayNewsResponse[index].title, content: viewModel.state.getSwipayNewsResponse[index].content)
                                        .tag(index)
                                    }
                                }
                                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                                
                                // 커스텀 인디케이터
                                HStack(spacing: 4) {
                                    ForEach(viewModel.state.getSwipayNewsResponse.indices, id: \.self) { index in
                                        Circle()
                                            .fill(index == newsCurrentIndex ? Color.white : Color.gray)
                                            .frame(width: 6 * Constants.ControlWidth, height: 6 * Constants.ControlHeight)
                                    }
                                }
                                .padding(.bottom)
                                
                                Spacer()
                            }
                        }
                    
                    //광고
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
                    Spacer()
                }
                
                VStack(spacing: 0){
                    Spacer()
                    
                    Image("swipay_shadow")
                        .resizable()
                        .frame(width: 394 * Constants.ControlWidth, height: 518 * Constants.ControlHeight)
                        .zIndex(1)
                        .allowsHitTesting(false)
                }
            }
            .toolbar(.hidden)
        }
        .toolbar(.hidden)
        .navigationDestination(for: swipayType.self) { view in
            switch view {
            case .payCharge:
                PayChargeView()
            case .payment:
                QRScannerView()
            case .swipoint:
                SwipointView()
            case .swipointDetail(let id):
                SwipointView(isSelectedRegion: id)
            }
        }
    }
}

public struct RoundedCorner: Shape {
    public var radius: CGFloat = .infinity
    public var corners: UIRectCorner = .allCorners
    
    public init(radius: CGFloat, corners: UIRectCorner) {
        self.radius = radius
        self.corners = corners
    }
    
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    public func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct UsageDetailItem: View {
    
    var region: String
    var title: String
    var date: String
    var type: String
    var price: String
    
    var body: some View {
        ZStack{
            HStack(spacing: 0){
                
                Image(region)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48 * Constants.ControlWidth)
                    .padding(.trailing, 12 * Constants.ControlWidth)
                
                VStack(alignment: .leading, spacing: 0){
                    Text(title)
                        .font(.Body2)
                        .lineLimit(1)
                        .foregroundColor(.white)
                    
                    HStack(spacing: 4){
                        Text(date)
                            .font(.Caption)
                            .foregroundColor(.greyLightHover)
                        
                        Rectangle()
                            .frame(width: 1, height: 16 * Constants.ControlHeight)
                            .foregroundColor(.greyLightHover)
                        
                        Text(type)
                            .font(.Caption)
                            .foregroundColor(.greyLightHover)
                    }
                }
                
                Spacer()
                
                Text("-\(price)원")
                    .font(.Subhead3)
                    .foregroundColor(.white)
                
            }
            
        }
    }
}

struct SwipayCardView: View {
    @ObservedObject var viewModel: SwipayViewModel
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) { // 카드 간 간격 조정
                ForEach(viewModel.state.getSwipointCardResponse, id: \.id) { data in
                    ZStack{
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: 242 * Constants.ControlWidth, height: 482.33 * Constants.ControlHeight)
                            .scaledToFit()
                            .foregroundColor(Color(hex: "242424"))
                            .overlay {
                                VStack(spacing: 0){
                                    HStack(spacing: 0){
                                        Text("\(data.region) 스위포인트")
                                            .font(.Headline)
                                            .foregroundColor(.white)
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            AppState.shared.navigationPath.append(swipayType.swipointDetail(id: data.id))
                                        }, label: {
                                            Image("swipay_chevron_right_greyLighterHover")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 24 * Constants.ControlWidth)
                                        })
                                    }
                                    .padding(.top, 22 * Constants.ControlHeight)
                                    .padding(.leading, 22 * Constants.ControlWidth)
                                    .padding(.trailing, 22 * Constants.ControlWidth)
                                    
                                    HStack(spacing: 0){
                                        Text("\(data.point)원 사용 가능")
                                            .font(.Subhead3)
                                            .foregroundColor(.mainLightHover)
                                        
                                        Spacer()
                                    }
                                    .padding(.leading, 22 * Constants.ControlWidth)
                                    .padding(.bottom, 14 * Constants.ControlHeight)
                                    
                                    Image("swipay_card_ex1")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 202 * Constants.ControlWidth, height: 320.33 * Constants.ControlHeight)
                                        .padding(.bottom, 14 * Constants.ControlHeight)
                                
                                    RoundedRectangle(cornerRadius: 6)
                                        .frame(width: 202 * Constants.ControlWidth, height: 40 * Constants.ControlHeight)
                                        .scaledToFit()
                                        .foregroundColor(.greyNormalHover)
                                        .overlay {
                                            Text("스위포인트 이동하기")
                                                .font(.Body1)
                                                .foregroundColor(.white)
                                        }
                                    
                                    Spacer()
                                }
                            }
                    }
                }
            }
        }
    }
}

struct SwipayNewsView: View {
    var title: String
    var content: String
    
    var body: some View {
        VStack(spacing: 0){
            HStack(spacing: 0){
                Text(title)
                    .lineLimit(2)
                    .font(.Headline)
                    .foregroundColor(.greyLighter)
                
                Spacer()
            }
            .padding(.leading, 22 * Constants.ControlWidth)
            
            ZStack{
                Image("swipay_news_shadow")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 327 * Constants.ControlWidth, height: 76 * Constants.ControlHeight)
                    .zIndex(1)
                
                Text(content)
                    .font(.spoqa(.regular, size: 12))
                    .lineLimit(2)
                    .frame(width: 327 * Constants.ControlWidth)
            }
        }
    }
}

enum swipayType: Hashable {
    case payCharge
    case payment
    case swipoint
    case swipointDetail(id: Int64)
}

#Preview {
    SwipayView()
}

