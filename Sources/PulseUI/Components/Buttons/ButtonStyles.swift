//
//  ButtonStyles.swift
//  DesignSystem
//
//  Created on 29/03/25.
//

import SwiftUI

@available(iOS 14.0, *)
// MARK: - Button Styles
public struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.designSystem) private var designSystem
    @Environment(\.colorScheme) private var colorScheme
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppTypography.body())
            .padding(.vertical, AppSpacing.small)
            .padding(.horizontal, AppSpacing.medium)
            .background(
                isEnabled
                    ? designSystem.primaryColor
                    : designSystem.primaryColor.opacity(0.5)
            )
            .foregroundColor(colorScheme == .dark ? .black : .white)
            .cornerRadius(AppShapes.mediumRadius)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .opacity(configuration.isPressed ? 0.9 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

@available(iOS 14.0, *)
public struct SecondaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.designSystem) private var designSystem
    @Environment(\.colorScheme) private var colorScheme
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppTypography.body())
            .padding(.vertical, AppSpacing.small)
            .padding(.horizontal, AppSpacing.medium)
            .background(Color.clear)
            .foregroundColor(
                isEnabled
                    ? designSystem.primaryColor
                    : designSystem.primaryColor.opacity(0.5)
            )
            .cornerRadius(AppShapes.mediumRadius)
            .overlay(
                RoundedRectangle(cornerRadius: AppShapes.mediumRadius)
                    .stroke(
                        isEnabled
                            ? designSystem.primaryColor
                            : designSystem.primaryColor.opacity(0.5),
                        lineWidth: 1
                    )
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .opacity(configuration.isPressed ? 0.9 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

@available(iOS 14.0, *)
public struct TextButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.designSystem) private var designSystem
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppTypography.body())
            .foregroundColor(
                isEnabled
                    ? designSystem.primaryColor
                    : designSystem.primaryColor.opacity(0.5)
            )
            .padding(.vertical, AppSpacing.xSmall)
            .opacity(configuration.isPressed ? 0.7 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

@available(iOS 14.0, *)
public struct IconButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.designSystem) private var designSystem
    @Environment(\.colorScheme) private var colorScheme
    
    private let size: CGFloat
    private let backgroundColor: Color?
    
    public init(size: CGFloat = 44, backgroundColor: Color? = nil) {
        self.size = size
        self.backgroundColor = backgroundColor
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: size * 0.4))
            .foregroundColor(
                isEnabled
                    ? (backgroundColor != nil
                        ? (colorScheme == .dark ? .black : .white)
                        : designSystem.primaryColor)
                    : (backgroundColor != nil
                        ? (colorScheme == .dark ? .black.opacity(0.7) : .white.opacity(0.7))
                        : designSystem.primaryColor.opacity(0.5))
            )
            .frame(width: size, height: size)
            .background(
                Circle()
                    .fill(
                        backgroundColor != nil
                            ? (isEnabled ? backgroundColor! : backgroundColor!.opacity(0.5))
                            : Color.clear
                    )
            )
            .contentShape(Circle())
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

@available(iOS 14.0, *)
public struct FloatingButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.designSystem) private var designSystem
    @Environment(\.colorScheme) private var colorScheme
    
    private let size: CGFloat
    private let backgroundColor: Color?
    
    public init(size: CGFloat = 56, backgroundColor: Color? = nil) {
        self.size = size
        self.backgroundColor = backgroundColor
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: size * 0.4))
            .foregroundColor(colorScheme == .dark ? .black : .white)
            .frame(width: size, height: size)
            .background(
                Circle()
                    .fill(
                        isEnabled
                            ? (backgroundColor ?? designSystem.primaryColor)
                            : (backgroundColor?.opacity(0.5) ?? designSystem.primaryColor.opacity(0.5))
                    )
                    .shadow(
                        color: designSystem.shadowColor,
                        radius: 8,
                        x: 0,
                        y: 4
                    )
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

@available(iOS 14.0, *)
public struct GradientButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.colorScheme) private var colorScheme
    
    private let startColor: Color
    private let endColor: Color
    private let customTextColor: Color?
    
    public init(
        startColor: Color,
        endColor: Color,
        textColor: Color? = nil
    ) {
        self.startColor = startColor
        self.endColor = endColor
        self.customTextColor = textColor
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        // Determine text color here, where environment values are available
        let textColor = customTextColor ?? (colorScheme == .dark ? .black : .white)
        
        return configuration.label
            .font(AppTypography.body())
            .padding(.vertical, AppSpacing.small)
            .padding(.horizontal, AppSpacing.medium)
            .foregroundColor(textColor)
            .background(
                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            isEnabled ? startColor : startColor.opacity(0.5),
                            isEnabled ? endColor : endColor.opacity(0.5)
                        ]
                    ),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(AppShapes.mediumRadius)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .opacity(configuration.isPressed ? 0.9 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

@available(iOS 14.0, *)
// MARK: - Advanced Toggle Style
public struct CustomToggleStyle: ToggleStyle {
    @Environment(\.designSystem) private var designSystem
    @Environment(\.colorScheme) private var colorScheme
    
    private let onColor: Color?
    private let offColor: Color?
    private let thumbColor: Color?
    
    public init(
        onColor: Color? = nil,
        offColor: Color? = nil,
        thumbColor: Color? = nil
    ) {
        self.onColor = onColor
        self.offColor = offColor
        self.thumbColor = thumbColor
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        configuration.isOn
                            ? (onColor ?? designSystem.primaryColor)
                            : (offColor ?? (colorScheme == .dark ? Color.gray.opacity(0.4) : Color.gray.opacity(0.3)))
                    )
                    .frame(width: 50, height: 30)
                
                Circle()
                    .fill(thumbColor ?? (colorScheme == .dark ? Color.black : Color.white))
                    .shadow(radius: 1, x: 0, y: 1)
                    .frame(width: 26, height: 26)
                    .offset(x: configuration.isOn ? 10 : -10)
                    .animation(.spring(response: 0.2, dampingFraction: 0.7), value: configuration.isOn)
            }
            .onTapGesture {
                configuration.isOn.toggle()
            }
        }
    }
}
