//
//  DesignSystem.swift
//  DesignSystem
//
//  Created on 29/03/25.
//

import SwiftUI
import Combine

@available(iOS 14.0, *)
public final class DesignSystem: ObservableObject, @unchecked Sendable {
    // Theme colors (auto-updates based on system appearance)
    @Published public var primaryColor: Color
    @Published public var secondaryColor: Color
    @Published public var accentColor: Color
    
    // Background colors
    @Published public var backgroundColor: Color
    @Published public var secondaryBackgroundColor: Color
    @Published public var tertiaryBackgroundColor: Color
    
    // Text colors
    @Published public var primaryTextColor: Color
    @Published public var secondaryTextColor: Color
    @Published public var tertiaryTextColor: Color
    
    // UI Element colors
    @Published public var dividerColor: Color
    @Published public var shadowColor: Color
    @Published public var overlayColor: Color
    
    // Status colors
    @Published public var successColor: Color
    @Published public var warningColor: Color
    @Published public var errorColor: Color
    @Published public var infoColor: Color
    
    // Font configuration
    @Published public var fonts: FontConfiguration = FontConfiguration()
    
    // Current color scheme (light/dark)
    @Published public var colorScheme: ColorScheme = .light
    
    // Theming mode
    public enum ThemeMode {
        case auto     // Follow system
        case light    // Always light
        case dark     // Always dark
        case custom   // Custom theme
    }
    
    @Published public var themeMode: ThemeMode = .auto
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initializers
    
    // Default initializer
    public init() {
        // Initialize with light theme
        let lightTheme = ThemeManager.lightTheme
        
        self.primaryColor = lightTheme.primary
        self.secondaryColor = lightTheme.secondary
        self.accentColor = lightTheme.accent
        self.backgroundColor = lightTheme.background
        self.secondaryBackgroundColor = lightTheme.secondaryBackground
        self.tertiaryBackgroundColor = lightTheme.tertiaryBackground
        self.primaryTextColor = lightTheme.primaryText
        self.secondaryTextColor = lightTheme.secondaryText
        self.tertiaryTextColor = lightTheme.tertiaryText
        self.dividerColor = lightTheme.divider
        self.shadowColor = lightTheme.shadow
        self.overlayColor = lightTheme.overlay
        self.successColor = lightTheme.success
        self.warningColor = lightTheme.warning
        self.errorColor = lightTheme.error
        self.infoColor = lightTheme.info
    }
    
    // Custom initializer
    public init(
        themeMode: ThemeMode = .auto,
        customTheme: ThemeColors? = nil,
        fonts: FontConfiguration = FontConfiguration()
    ) {
        self.themeMode = themeMode
        self.fonts = fonts
        
        // Initialize with light theme (will be updated based on mode)
        let initialTheme = customTheme ?? ThemeManager.lightTheme
        
        self.primaryColor = initialTheme.primary
        self.secondaryColor = initialTheme.secondary
        self.accentColor = initialTheme.accent
        self.backgroundColor = initialTheme.background
        self.secondaryBackgroundColor = initialTheme.secondaryBackground
        self.tertiaryBackgroundColor = initialTheme.tertiaryBackground
        self.primaryTextColor = initialTheme.primaryText
        self.secondaryTextColor = initialTheme.secondaryText
        self.tertiaryTextColor = initialTheme.tertiaryText
        self.dividerColor = initialTheme.divider
        self.shadowColor = initialTheme.shadow
        self.overlayColor = initialTheme.overlay
        self.successColor = initialTheme.success
        self.warningColor = initialTheme.warning
        self.errorColor = initialTheme.error
        self.infoColor = initialTheme.info
    }
    
    // MARK: - Theme Management
    
    // Call this method to update the design system based on the system appearance
    public func updateForColorScheme(_ newColorScheme: ColorScheme) {
        // Only update if in auto mode
        guard themeMode == .auto else { return }
        
        self.colorScheme = newColorScheme
        applyTheme(newColorScheme == .dark ? ThemeManager.darkTheme : ThemeManager.lightTheme)
    }
    
    // Set a specific theme mode
    public func setThemeMode(_ mode: ThemeMode, customTheme: ThemeColors? = nil) {
        self.themeMode = mode
        
        switch mode {
        case .light:
            applyTheme(ThemeManager.lightTheme)
        case .dark:
            applyTheme(ThemeManager.darkTheme)
        case .custom:
            if let customTheme = customTheme {
                applyTheme(customTheme)
            }
        case .auto:
            // Will be updated when updateForColorScheme is called
            break
        }
    }
    
    // Apply the given theme
    private func applyTheme(_ theme: ThemeColors) {
        self.primaryColor = theme.primary
        self.secondaryColor = theme.secondary
        self.accentColor = theme.accent
        self.backgroundColor = theme.background
        self.secondaryBackgroundColor = theme.secondaryBackground
        self.tertiaryBackgroundColor = theme.tertiaryBackground
        self.primaryTextColor = theme.primaryText
        self.secondaryTextColor = theme.secondaryText
        self.tertiaryTextColor = theme.tertiaryText
        self.dividerColor = theme.divider
        self.shadowColor = theme.shadow
        self.overlayColor = theme.overlay
        self.successColor = theme.success
        self.warningColor = theme.warning
        self.errorColor = theme.error
        self.infoColor = theme.info
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
    
    // Helper to apply automatic dark/light mode
    func withAdaptiveDesignSystem(_ designSystem: DesignSystem) -> some View {
        self.modifier(AdaptiveThemeModifier(designSystem: designSystem))
    }
}

// Modifier to automatically update the design system based on the color scheme
@available(iOS 14.0, *)
public struct AdaptiveThemeModifier: ViewModifier {
    @ObservedObject var designSystem: DesignSystem
    @Environment(\.colorScheme) var colorScheme
    
    public func body(content: Content) -> some View {
        content
            .designSystem(designSystem)
            .onAppear {
                designSystem.updateForColorScheme(colorScheme)
            }
            .onChange(of: colorScheme) { newColorScheme in
                designSystem.updateForColorScheme(newColorScheme)
            }
    }
}

// Font configuration structure
@available(iOS 14.0, *)
public struct FontConfiguration {
    public let titleFont: Font
    public let headingFont: Font
    public let subheadingFont: Font
    public let bodyFont: Font
    public let captionFont: Font
    
    public init(
        titleFont: Font = .system(size: AppTypography.FontSize.xxLarge, weight: .bold),
        headingFont: Font = .system(size: AppTypography.FontSize.xLarge, weight: .semibold),
        subheadingFont: Font = .system(size: AppTypography.FontSize.large, weight: .medium),
        bodyFont: Font = .system(size: AppTypography.FontSize.medium, weight: .regular),
        captionFont: Font = .system(size: AppTypography.FontSize.small, weight: .regular)
    ) {
        self.titleFont = titleFont
        self.headingFont = headingFont
        self.subheadingFont = subheadingFont
        self.bodyFont = bodyFont
        self.captionFont = captionFont
    }
}
