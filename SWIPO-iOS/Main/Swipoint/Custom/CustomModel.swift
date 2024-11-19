//
//  CustomModel.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/19/24.
//

import Foundation


struct StickerItemModel: Identifiable {
    var id: UUID = UUID()
    var image: String
    var position: CGPoint
    var scale: CGFloat = 1.0
    var type: StickerType // 스티커 유형
}
