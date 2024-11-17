//
//  Fonts+.swift
//  SWIPO-iOS
//
//  Created by wodnd on 11/18/24.
//

import Foundation
import SwiftUI

// 무슨폰트, 사이즈
// font(.gothicNeo(size: 18 , font: "bold") 형태로 사용
extension Font {
    static func spoqa(size fontSize: CGFloat, font: String) -> Font{
        
        var fontName: String
        switch font {
        case "bold":
            fontName = "SpoqaHanSansNeo-Bold"
        case "light":
            fontName = "SpoqaHanSansNeo-Light"
        case "medium":
            fontName = "SpoqaHanSansNeo-Medium"
        case "regular":
            fontName = "SpoqaHanSansNeo-Regular"
        case "thin":
            fontName = "SpoqaHanSansNeo-Thin"
        default:
            fontName = "SpoqaHanSansNeo-Bold"
        }
        
        return Font.custom(fontName, size: fontSize)
        
    }
    
    enum Spoqa {
        case bold
        case light
        case medium
        case regular
        case thin
        
        var name: String {
            switch self {
            case .bold:
                return "SpoqaHanSansNeo-Bold"
            case .light:
                return "SpoqaHanSansNeo-Light"
            case .medium:
                return "SpoqaHanSansNeo-Medium"
            case .regular:
                return "SpoqaHanSansNeo-Regular"
            case .thin:
                return "SpoqaHanSansNeo-Thin"
            }
        }
    }
    
    /// custom Font.
    // .font(.gothicNeo(.bold, size: 12))
    static func spoqa(_ weight: Spoqa = .medium, size: CGFloat) -> Font {
        
        return custom(weight.name, size: size)
    }
    
    static func pretend(size fontSize: CGFloat, font: String) -> Font{
        
        var fontName: String
        switch font {
        case "medium":
            fontName = "Pretendard-Medium"
        default:
            fontName = "Pretendard-Medium"
        }
        
        return Font.custom(fontName, size: fontSize)
        
    }
    
    enum Pretend {
        case medium
        
        var name: String {
            switch self {
            case .medium:
                return "Pretendard-Medium"
            }
        }
    }
    
    /// custom Font.
    // .font(.gothicNeo(.bold, size: 12))
    static func pretend(_ weight: Pretend = .medium, size: CGFloat) -> Font {
        
        return custom(weight.name, size: size)
    }
}

extension Font {
    static var Headline: Font {
        return .spoqa(.medium, size: 20)
    }
    
    static var Caption: Font {
        return .spoqa(.regular, size: 12)
    }
    
    static var Subhead1: Font {
        return .spoqa(.bold, size: 12)
    }
    
    static var Subhead2: Font {
        return .spoqa(.medium, size: 14)
    }
    
    static var Subhead3: Font {
        return .spoqa(.bold, size: 16)
    }
    
    static var Display1: Font {
        return .spoqa(.bold, size: 24)
    }
    
    static var Display2: Font {
        return .spoqa(.bold, size: 28)
    }
    
    static var Display3: Font {
        return .spoqa(.bold, size: 32)
    }
    
    static var Display4: Font {
        return .spoqa(.bold, size: 36)
    }
    
    static var Display5: Font {
        return .spoqa(.bold, size: 40)
    }
    
    static var Body2: Font {
        return .spoqa(.regular, size: 16)
    }
    
    static var Body1: Font {
        return .spoqa(.regular, size: 14)
    }
}



