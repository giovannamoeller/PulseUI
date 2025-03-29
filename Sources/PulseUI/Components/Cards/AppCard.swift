//
//  AppCard.swift
//  PulseUI
//
//  Created on 28/03/25.
//

import SwiftUI

@available(iOS 14.0, *)
public struct AppCard<Content: View>: View {
    public enum CardStyle {
        case elevated
        case outlined
        case flat
    }
    
    private let content: Content
    private let style: CardStyle
    private let cornerRadius: CGFloat
    private let padding: CGFloat
    @Environment(\.designSystem) private var designSystem
    
    public init(
        style: CardStyle = .elevated,
        cornerRadius: CGFloat = AppShapes.mediumRadius,
        padding: CGFloat = AppSpacing.medium,
        @ViewBuilder content: () -> Content
    ) {
        self.style = style
        self.cornerRadius = cornerRadius
        self.padding = padding
        self.content = content()
    }
    
    public var body: some View {
        content
            .padding(padding)
            .background(
                Group {
                    switch style {
                    case .elevated:
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(designSystem.backgroundColor)
                            .modifier(AppShadows.medium())
                    case .outlined:
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(designSystem.backgroundColor)
                            .overlay(
                                RoundedRectangle(cornerRadius: cornerRadius)
                                    .stroke(AppColors.Gray.gray4, lineWidth: 1)
                            )
                    case .flat:
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(designSystem.secondaryBackgroundColor)
                    }
                }
            )
    }
}

// MARK: - Preview
#if DEBUG
@available(iOS 14.0, *)
struct AppCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            AppCard {
                VStack(alignment: .leading, spacing: AppSpacing.small) {
                    Text("Elevated Card")
                        .font(AppTypography.subheading())
                    Text("This is a card with elevation (shadow)")
                        .font(AppTypography.body())
                }
            }
            
            AppCard(style: .outlined) {
                VStack(alignment: .leading, spacing: AppSpacing.small) {
                    Text("Outlined Card")
                        .font(AppTypography.subheading())
                    Text("This is a card with outline border")
                        .font(AppTypography.body())
                }
            }
            
            AppCard(style: .flat) {
                VStack(alignment: .leading, spacing: AppSpacing.small) {
                    Text("Flat Card")
                        .font(AppTypography.subheading())
                    Text("This is a flat card with background color")
                        .font(AppTypography.body())
                }
            }
        }
        .padding()
    }
}
#endif
