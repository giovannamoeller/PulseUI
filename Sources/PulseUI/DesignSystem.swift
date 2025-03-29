//
//  DesignSystem.swift
//  PulseUI
//
//  Created on 28/03/25.
//

import SwiftUI

@available(iOS 14.0, *)
public class DesignSystem: ObservableObject, @unchecked Sendable {
    // Theme colors
    @Published public var primaryColor: Color
    @Published public var secondaryColor: Color
    @Published public var accentColor: Color
    
    // Background colors
    @Published public var backgroundColor: Color
    @Published public var secondaryBackgroundColor: Color
    
    // Text colors
    @Published public var primaryTextColor: Color
    @Published public var secondaryTextColor: Color
    @Published public var tertiaryTextColor: Color
    
    // Initialize with default colors
    public init(
        primaryColor: Color = AppColors.primary,
        secondaryColor: Color = AppColors.secondary,
        accentColor: Color = AppColors.accent,
        backgroundColor: Color = AppColors.background,
        secondaryBackgroundColor: Color = AppColors.secondaryBackground,
        primaryTextColor: Color = AppColors.primaryText,
        secondaryTextColor: Color = AppColors.secondaryText,
        tertiaryTextColor: Color = AppColors.tertiaryText
    ) {
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.accentColor = accentColor
        self.backgroundColor = backgroundColor
        self.secondaryBackgroundColor = secondaryBackgroundColor
        self.primaryTextColor = primaryTextColor
        self.secondaryTextColor = secondaryTextColor
        self.tertiaryTextColor = tertiaryTextColor
    }
    
    // Create a dark mode design system
    public static var dark: DesignSystem {
        DesignSystem(
            primaryColor: AppColors.primary,
            secondaryColor: AppColors.secondary,
            accentColor: AppColors.accent,
            backgroundColor: Color.black,
            secondaryBackgroundColor: Color(hex: "#1C1C1E"),
            primaryTextColor: Color.white,
            secondaryTextColor: Color.white.opacity(0.8),
            tertiaryTextColor: Color.white.opacity(0.6)
        )
    }
    
    // Create a light mode design system (default)
    public static var light: DesignSystem {
        DesignSystem()
    }
}

// Environment key for the design system
@available(iOS 14.0, *)
private struct DesignSystemKey: EnvironmentKey {
    static let defaultValue = DesignSystem()
}

@available(iOS 14.0, *)
public extension EnvironmentValues {
    var designSystem: DesignSystem {
        get { self[DesignSystemKey.self] }
        set { self[DesignSystemKey.self] = newValue }
    }
}

@available(iOS 14.0, *)
public extension View {
    func designSystem(_ designSystem: DesignSystem) -> some View {
        environment(\.designSystem, designSystem)
    }
}
