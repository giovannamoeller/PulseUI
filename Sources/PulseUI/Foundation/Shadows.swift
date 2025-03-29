//
//  AppShadows.swift
//  PulseUI
//
//  Created by Giovanna Moeller on 28/03/25.
//

import SwiftUI

@available(iOS 13.0, *)
public struct AppShadows {
    public static func small() -> some ViewModifier {
        ShadowModifier(
            color: Color.black.opacity(0.1),
            radius: 4,
            x: 0,
            y: 2
        )
    }
    
    public static func medium() -> some ViewModifier {
        ShadowModifier(
            color: Color.black.opacity(0.15),
            radius: 8,
            x: 0,
            y: 4
        )
    }
    
    public static func large() -> some ViewModifier {
        ShadowModifier(
            color: Color.black.opacity(0.2),
            radius: 16,
            x: 0,
            y: 8
        )
    }
}

@available(iOS 13.0, *)
public struct ShadowModifier: ViewModifier {
    let color: Color
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat
    
    public func body(content: Content) -> some View {
        content
            .shadow(color: color, radius: radius, x: x, y: y)
    }
}
