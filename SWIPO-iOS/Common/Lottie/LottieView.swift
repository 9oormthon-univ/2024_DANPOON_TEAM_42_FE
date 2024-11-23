//
//  LottieView.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/23/24.
//

import Foundation
import SwiftUI
import Lottie
import UIKit

// 로티 애니메이션 뷰 정의
struct LottieView: UIViewRepresentable {
    var name: String // JSON 파일 이름
    var loopMode: LottieLoopMode // 반복 모드 설정
    var onAnimationCompleted: (() -> Void)? // 애니메이션 완료 콜백

    init(jsonName: String, loopMode: LottieLoopMode = .playOnce, onAnimationCompleted: (() -> Void)? = nil) {
        self.name = jsonName
        self.loopMode = loopMode
        self.onAnimationCompleted = onAnimationCompleted
    }
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)

        // Lottie 애니메이션 뷰 생성
        let animationView = LottieAnimationView(name: name)
        animationView.loopMode = loopMode // 애니메이션 반복 모드 설정
        animationView.contentMode = .scaleAspectFill // 화면에 꽉 차게 설정
        animationView.backgroundBehavior = .pauseAndRestore // 백그라운드에서 일시 중지 후 복원

        // 애니메이션 완료 시 콜백 처리
        animationView.play { (finished) in
            if finished {
                // 애니메이션이 끝나면 콜백 호출
                onAnimationCompleted?()
            }
        }
        
        // 제약 조건 설정
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animationView.topAnchor.constraint(equalTo: view.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // 필요시 업데이트 로직 추가 가능
    }
}
