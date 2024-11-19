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
    var scale: CGFloat
    var type: StickerType
    var isSelectable: Bool = true // 선택 가능 여부
}
