//
//  Constants.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/18/24.
//

import Foundation
import UIKit

struct Constants {
    static let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
    static let screenWidth = windowScene?.screen.bounds.width ?? 0
    static let screenHeight = windowScene?.screen.bounds.height ?? 0
    
    // 디자인 기준 세로 크기와 하단 패딩 값
    static let baseScreenWidth: CGFloat = 393 // 디자인 화면 가로 크기
    static let baseScreenHeight: CGFloat = 852 // 디자인 화면 세로 크기
    
    static let ControlWidth = screenWidth / baseScreenWidth
    static let ControlHeight = screenHeight / baseScreenHeight
}
