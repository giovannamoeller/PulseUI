//
//  AppShapes.swift
//  PulseUI
//
//  Created by Giovanna Moeller on 28/03/25.
//

import SwiftUI

@available(iOS 13.0, *)
public struct AppShapes {
    public static let smallRadius: CGFloat = 4
    public static let mediumRadius: CGFloat = 8
    public static let largeRadius: CGFloat = 16
    public static let circleRadius: CGFloat = 9999
    
    public struct Corners {
        public static func small() -> RoundedCornerStyle {
            return .continuous
        }
        
        public static func medium() -> RoundedCornerStyle {
            return .continuous
        }
    }
}
