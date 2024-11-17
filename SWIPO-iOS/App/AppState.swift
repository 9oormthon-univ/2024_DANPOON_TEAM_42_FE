//
//  AppState.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/18/24.
//

import Foundation
import SwiftUI

@MainActor
class AppState: ObservableObject {
    static let shared = AppState()
  
    // 네비게이션 스택 경로
    @Published var navigationPath = NavigationPath()
}
