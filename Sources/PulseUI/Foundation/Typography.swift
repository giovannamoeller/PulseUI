//
//  AppTypography.swift
//  PulseUI
//
//  Created by Giovanna Moeller on 28/03/25.
//

import SwiftUI

@available(iOS 13.0, *)
public struct AppTypography {
    // Font sizes
    public struct FontSize {
        public static let small: CGFloat = 12
        public static let medium: CGFloat = 16
        public static let large: CGFloat = 20
        public static let xLarge: CGFloat = 24
        public static let xxLarge: CGFloat = 34
    }
    
    // Font weights
    public struct FontWeight {
        public static let regular = Font.Weight.regular
        public static let medium = Font.Weight.medium
        public static let semibold = Font.Weight.semibold
        public static let bold = Font.Weight.bold
    }
    
    // Text styles
    public static func title() -> Font {
        Font.system(size: FontSize.xxLarge, weight: FontWeight.bold)
    }
    
    public static func heading() -> Font {
        Font.system(size: FontSize.xLarge, weight: FontWeight.semibold)
    }
    
    public static func subheading() -> Font {
        Font.system(size: FontSize.large, weight: FontWeight.medium)
    }
    
    public static func body() -> Font {
        Font.system(size: FontSize.medium, weight: FontWeight.regular)
    }
    
    public static func caption() -> Font {
        Font.system(size: FontSize.small, weight: FontWeight.regular)
    }
}
