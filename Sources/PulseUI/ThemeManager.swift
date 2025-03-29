//
//  ThemeManager.swift
//  DesignSystem
//
//  Created on 29/03/25.
//

import SwiftUI

@available(iOS 14.0, *)
public struct ThemeManager {
    // MARK: - Light Theme Colors
    public static let lightTheme = ThemeColors(
        // Main colors
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        accent: AppColors.accent,
        
        // Background colors
        background: Color.white,
        secondaryBackground: Color(hex: "#F2F2F7"),
        tertiaryBackground: Color(hex: "#EFEFF4"),
        
        // Text colors
        primaryText: Color.black,
        secondaryText: Color.black.opacity(0.8),
        tertiaryText: Color.black.opacity(0.6),
        
        // UI Element colors
        divider: Color(hex: "#C6C6C8"),
        shadow: Color.black.opacity(0.1),
        overlay: Color.black.opacity(0.4),
        
        // Status colors
        success: AppColors.success,
        warning: AppColors.warning,
        error: AppColors.error,
        info: AppColors.info
    )
    
    // MARK: - Dark Theme Colors
    public static let darkTheme = ThemeColors(
        // Main colors
        primary: AppColors.primary.lighten(0.1),
        secondary: AppColors.secondary.lighten(0.1),
        accent: AppColors.accent.lighten(0.1),
        
        // Background colors
        background: Color.black,
        secondaryBackground: Color(hex: "#1C1C1E"),
        tertiaryBackground: Color(hex: "#2C2C2E"),
        
        // Text colors
        primaryText: Color.white,
        secondaryText: Color.white.opacity(0.8),
        tertiaryText: Color.white.opacity(0.6),
        
        // UI Element colors
        divider: Color(hex: "#38383A"),
        shadow: Color.black.opacity(0.3),
        overlay: Color.black.opacity(0.6),
        
        // Status colors
        success: AppColors.success.lighten(0.1),
        warning: AppColors.warning.lighten(0.1),
        error: AppColors.error.lighten(0.1),
        info: AppColors.info.lighten(0.1)
    )
    
    // Get the appropriate theme based on the color scheme
    public static func theme(for colorScheme: ColorScheme) -> ThemeColors {
        colorScheme == .dark ? darkTheme : lightTheme
    }
}

// MARK: - Theme Colors Structure
@available(iOS 13.0, *)
public struct ThemeColors: Sendable {
    // Main colors
    public let primary: Color
    public let secondary: Color
    public let accent: Color
    
    // Background colors
    public let background: Color
    public let secondaryBackground: Color
    public let tertiaryBackground: Color
    
    // Text colors
    public let primaryText: Color
    public let secondaryText: Color
    public let tertiaryText: Color
    
    // UI Element colors
    public let divider: Color
    public let shadow: Color
    public let overlay: Color
    
    // Status colors
    public let success: Color
    public let warning: Color
    public let error: Color
    public let info: Color
    
    public init(
        primary: Color,
        secondary: Color,
        accent: Color,
        background: Color,
        secondaryBackground: Color,
        tertiaryBackground: Color,
        primaryText: Color,
        secondaryText: Color,
        tertiaryText: Color,
        divider: Color,
        shadow: Color,
        overlay: Color,
        success: Color,
        warning: Color,
        error: Color,
        info: Color
    ) {
        self.primary = primary
        self.secondary = secondary
        self.accent = accent
        self.background = background
        self.secondaryBackground = secondaryBackground
        self.tertiaryBackground = tertiaryBackground
        self.primaryText = primaryText
        self.secondaryText = secondaryText
        self.tertiaryText = tertiaryText
        self.divider = divider
        self.shadow = shadow
        self.overlay = overlay
        self.success = success
        self.warning = warning
        self.error = error
        self.info = info
    }
}
