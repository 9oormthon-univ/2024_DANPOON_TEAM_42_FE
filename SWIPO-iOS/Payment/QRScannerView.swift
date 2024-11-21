//
//  QRScannerView.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/21/24.
//

import SwiftUI
import CodeScanner
import AVFoundation

struct QRScannerView: View {
    
    @State var storeTitle: String = ""
    @State var price: String = ""
    
    var body: some View {
        ZStack {
            
            VStack(spacing: 0) {
                NavigationBar(title: "QR 결제", showBackButton: true)
                
                QRMainView(storeTitle: $storeTitle, price: $price)
                
                Spacer()
            }
        }
        .toolbar(.hidden)
    }
}

struct QRMainView: View {
    
    @State private var isShowingScanner = true
    @State private var permissionDenied = false
    @State private var isShowing = false
    
    @Binding var storeTitle: String
    @Binding var price: String
    
    var body: some View {
        ZStack {
            
            if isShowingScanner {
                VStack(spacing: 0){
                    RoundedRectangle(cornerRadius: 18.42)
                        .frame(width: 348 * Constants.ControlWidth, height: 348 * Constants.ControlHeight)
                        .scaledToFit()
                        .overlay(RoundedRectangle(cornerRadius: 18.42).stroke(Color(hex: "4F4FFD"), lineWidth: 2)) // 파란색 테두리
                        .padding(.top, 79 * Constants.ControlHeight)
                    
                    Spacer()
                }
                
                VStack(spacing: 0) {
                    CodeScannerView(codeTypes: [.qr], simulatedData: "https://example.com") { response in
                        switch response {
                        case .success(let result):
                            processQRResult(result.string)
                            AppState.shared.navigationPath.append(qrType.payment)
                        case .failure(let error):
                            isShowing = true
                            print(error.localizedDescription)
                        }
                    }
                    .sheet(isPresented: $isShowing) {
                        WebView(url: URL(string: "https://attractive-reason-70a.notion.site/QR-1403d7dd9ab0802e9548e74ea12cd722?pvs=4")!)
                    }
                    .frame(width: 348 * Constants.ControlWidth, height: 348 * Constants.ControlHeight) // 카메라 뷰의 크기 조정
                    .cornerRadius(18.42) // 모서리를 둥글게 설정
                    .padding(.top, 79 * Constants.ControlHeight)
                    
                    VStack(spacing: 0) {
                        HStack(spacing: 10){
                            Image("payment_camera")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 22 * Constants.ControlWidth, height: 22 * Constants.ControlHeight)
                            
                            Text("QR 코드로 결제하세요!")
                                .font(.Headline)
                                .foregroundColor(.white)
                        }
                        
                        Text("QR 코드를 화면에 비추면 \n 자동으로 인식 후 다음 화면으로 전환됩니다.")
                            .font(.Body2)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding(.top, 24 * Constants.ControlHeight)
                        
                        
                    }
                    .padding(.top, 22 * Constants.ControlHeight)
                    
                    Spacer()
                }
            }
        }
        .onAppear() {
            checkCameraPermission()
        }
        .alert(isPresented: $permissionDenied) {
            Alert(
                title: Text("카메라 접근 권한이 필요합니다"),
                message: Text("앱 설정으로 가서 카메라 접근 권한을 허용해 주세요."),
                primaryButton: .cancel(Text("취소")),
                secondaryButton: .default(Text("설정하기"), action: {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                })
            )
        }
    }
    
    private func checkCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            isShowingScanner = true
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    if granted {
                        isShowingScanner = true
                    } else {
                        permissionDenied = true
                    }
                }
            }
        case .denied, .restricted:
            permissionDenied = true
        @unknown default:
            break
        }
    }
    
    /// QR 결과를 처리하는 함수
    func processQRResult(_ result: String) {
        let components = result.split(separator: "/")
        if components.count == 2 {
            storeTitle = String(components[0])
            price = String(components[1])
        } else {
            print("Invalid QR format: \(result)")
        }
    }
}

enum qrType{
    case payment
}

#Preview {
    QRScannerView()
}
