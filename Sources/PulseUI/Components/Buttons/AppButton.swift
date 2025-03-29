//
//  AppButton.swift
//  PulseUI
//
//  Created by Giovanna Moeller on 28/03/25.
//

import SwiftUI

@available(iOS 14.0, *)
// MARK: - Button Component
public struct AppButton: View {
    // Button type enum
    public enum ButtonType {
        case primary
        case secondary
        case text
        case icon
        case floating
        case gradient
    }
    
    // Button size enum
    public enum ButtonSize {
        case small
        case medium
        case large
        
        var verticalPadding: CGFloat {
            switch self {
            case .small: return AppSpacing.xxSmall
            case .medium: return AppSpacing.small
            case .large: return AppSpacing.medium
            }
        }
        
        var horizontalPadding: CGFloat {
            switch self {
            case .small: return AppSpacing.small
            case .medium: return AppSpacing.medium
            case .large: return AppSpacing.large
            }
        }
        
        var iconSize: CGFloat {
            switch self {
            case .small: return 36
            case .medium: return 44
            case .large: return 56
            }
        }
        
        var fontSize: CGFloat {
            switch self {
            case .small: return AppTypography.FontSize.small
            case .medium: return AppTypography.FontSize.medium
            case .large: return AppTypography.FontSize.large
            }
        }
    }
    
    // Properties
    private let title: String?
    private let type: ButtonType
    private let size: ButtonSize
    private let action: () -> Void
    private let isEnabled: Bool
    private let icon: Image?
    private let isFullWidth: Bool
    private let startColor: Color?
    private let endColor: Color?
    private let leadingIcon: Image?
    private let trailingIcon: Image?
    @Environment(\.designSystem) private var designSystem
    
    // MARK: - Initializers
    
    // Main initializer with all options
    public init(
        title: String? = nil,
        type: ButtonType = .primary,
        size: ButtonSize = .medium,
        action: @escaping () -> Void,
        isEnabled: Bool = true,
        icon: Image? = nil,
        isFullWidth: Bool = false,
        startColor: Color? = nil,
        endColor: Color? = nil,
        leadingIcon: Image? = nil,
        trailingIcon: Image? = nil
    ) {
        self.title = title
        self.type = type
        self.size = size
        self.action = action
        self.isEnabled = isEnabled
        self.icon = icon
        self.isFullWidth = isFullWidth
        self.startColor = startColor
        self.endColor = endColor
        self.leadingIcon = leadingIcon
        self.trailingIcon = trailingIcon
    }
    
    // Convenience initializer for icon buttons
    public init(
        icon: Image,
        type: ButtonType = .icon,
        size: ButtonSize = .medium,
        action: @escaping () -> Void,
        isEnabled: Bool = true,
        backgroundColor: Color? = nil
    ) {
        self.title = nil
        self.type = type
        self.size = size
        self.action = action
        self.isEnabled = isEnabled
        self.icon = icon
        self.isFullWidth = false
        self.startColor = backgroundColor
        self.endColor = backgroundColor
        self.leadingIcon = nil
        self.trailingIcon = nil
    }
    
    // Convenience initializer for gradient buttons
    public init(
        title: String,
        startColor: Color,
        endColor: Color,
        size: ButtonSize = .medium,
        action: @escaping () -> Void,
        isEnabled: Bool = true,
        icon: Image? = nil,
        isFullWidth: Bool = false
    ) {
        self.title = title
        self.type = .gradient
        self.size = size
        self.action = action
        self.isEnabled = isEnabled
        self.icon = icon
        self.isFullWidth = isFullWidth
        self.startColor = startColor
        self.endColor = endColor
        self.leadingIcon = nil
        self.trailingIcon = nil
    }
    
    // MARK: - Body
    public var body: some View {
        Button(action: action) {
            buildButtonContent()
        }
        .disabled(!isEnabled)
        .apply(buttonStyle: type, size: size, startColor: startColor, endColor: endColor)
    }
    
    // MARK: - Helper Methods
    @ViewBuilder
    private func buildButtonContent() -> some View {
        switch type {
        case .icon, .floating:
            // For icon-only buttons
            icon ?? Image(systemName: "circle")
                .font(.system(size: size.fontSize)) as! Image
        
        default:
            // For buttons with text
            HStack(spacing: AppSpacing.small) {
                if let leadingIcon = leadingIcon {
                    leadingIcon
                        .font(.system(size: size.fontSize))
                }
                
                if let icon = icon, title == nil {
                    icon
                        .font(.system(size: size.fontSize))
                }
                
                if let title = title {
                    Text(title)
                        .font(.system(size: size.fontSize, weight: .medium))
                        .lineLimit(1)
                }
                
                if let icon = icon, title != nil {
                    icon
                        .font(.system(size: size.fontSize))
                }
                
                if let trailingIcon = trailingIcon {
                    trailingIcon
                        .font(.system(size: size.fontSize))
                }
            }
            .frame(maxWidth: isFullWidth ? .infinity : nil)
            .padding(.vertical, size.verticalPadding)
            .padding(.horizontal, size.horizontalPadding)
        }
    }
}

@available(iOS 14.0, *)
// MARK: - Private Helper Extension
private extension View {
    @ViewBuilder
    func apply(
        buttonStyle type: AppButton.ButtonType,
        size: AppButton.ButtonSize,
        startColor: Color?,
        endColor: Color?
    ) -> some View {
        switch type {
        case .primary:
            self.primaryButtonStyle()
        case .secondary:
            self.secondaryButtonStyle()
        case .text:
            self.textButtonStyle()
        case .icon:
            self.iconButtonStyle(size: size.iconSize, backgroundColor: startColor)
        case .floating:
            self.floatingButtonStyle(size: size.iconSize, backgroundColor: startColor)
        case .gradient:
            if let startColor = startColor, let endColor = endColor {
                self.gradientButtonStyle(startColor: startColor, endColor: endColor)
            } else {
                // Fallback to primary if no gradient colors provided
                self.primaryButtonStyle()
            }
        }
    }
}

// MARK: - Preview
#if DEBUG
@available(iOS 14.0, *)
struct AppButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            AppButton(title: "Primary Button", type: .primary, action: {})
            
            AppButton(
                title: "Secondary Button",
                type: .secondary,
                action: {},
                icon: Image(systemName: "star.fill")
            )
            
            AppButton(
                title: "Text Button",
                type: .text,
                action: {}
            )
            
            AppButton(
                title: "Full Width",
                action: {},
                isFullWidth: true
            )
            
            AppButton(
                title: "Disabled",
                action: {},
                isEnabled: false
            )
            
            HStack {
                AppButton(
                    icon: Image(systemName: "plus"),
                    action: {}
                )
                
                AppButton(
                    icon: Image(systemName: "trash"),
                    type: .icon,
                    action: {},
                    backgroundColor: Color.red
                )
                
                AppButton(
                    icon: Image(systemName: "pencil"),
                    type: .floating,
                    action: {}
                )
            }
            
            AppButton(
                title: "Gradient",
                startColor: Color(hex: "#4568DC"),
                endColor: Color(hex: "#B06AB3"),
                action: {}
            )
            
            AppButton(
                title: "With Leading & Trailing Icons",
                action: {},
                leadingIcon: Image(systemName: "lock.fill"),
                trailingIcon: Image(systemName: "arrow.right")
            )
            
            // Different sizes
            HStack {
                AppButton(
                    title: "Small",
                    size: .small,
                    action: {}
                )
                
                AppButton(
                    title: "Large",
                    size: .large,
                    action: {}
                )
            }
        }
        .padding()
    }
}
#endif
