//
//  AppTextField.swift
//  PulseUI
//
//  Created on 28/03/25.
//

import SwiftUI

@available(iOS 14.0, *)
public struct AppTextField: View {
    // Text field styles
    public enum TextFieldStyle {
        case outlined
        case filled
        case underlined
    }
    
    // Properties
    private let title: String
    private let placeholder: String
    private var text: Binding<String>
    private let style: TextFieldStyle
    private let icon: Image?
    private let errorMessage: String?
    private let isSecure: Bool
    private let keyboardType: UIKeyboardType
    @State private var isFocused: Bool = false
    @Environment(\.designSystem) private var designSystem
    
    // Initializer
    public init(
        title: String,
        placeholder: String,
        text: Binding<String>,
        style: TextFieldStyle = .outlined,
        icon: Image? = nil,
        errorMessage: String? = nil,
        isSecure: Bool = false,
        keyboardType: UIKeyboardType = .default
    ) {
        self.title = title
        self.placeholder = placeholder
        self.text = text
        self.style = style
        self.icon = icon
        self.errorMessage = errorMessage
        self.isSecure = isSecure
        self.keyboardType = keyboardType
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xSmall) {
            // Label
            Text(title)
                .font(AppTypography.caption())
                .foregroundColor(
                    errorMessage != nil ? AppColors.error : designSystem.primaryTextColor
                )
            
            // Text Field with style
            HStack {
                if let icon = icon {
                    icon
                        .foregroundColor(designSystem.tertiaryTextColor)
                        .padding(.trailing, AppSpacing.xSmall)
                }
                
                if isSecure {
                    SecureField(placeholder, text: text)
                        .keyboardType(keyboardType)
                        .autocapitalization(.none)
                } else {
                    TextField(placeholder, text: text, onEditingChanged: { editing in
                        isFocused = editing
                    })
                    .keyboardType(keyboardType)
                    .autocapitalization(.none)
                }
            }
            .padding(AppSpacing.small)
            .background(
                Group {
                    switch style {
                    case .outlined:
                        RoundedRectangle(cornerRadius: AppShapes.mediumRadius)
                            .stroke(
                                errorMessage != nil ? AppColors.error :
                                    (isFocused ? designSystem.primaryColor : AppColors.Gray.gray3),
                                lineWidth: 1
                            )
                    case .filled:
                        RoundedRectangle(cornerRadius: AppShapes.mediumRadius)
                            .fill(designSystem.secondaryBackgroundColor)
                    case .underlined:
                        VStack {
                            Spacer()
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(
                                    errorMessage != nil ? AppColors.error :
                                        (isFocused ? designSystem.primaryColor : AppColors.Gray.gray3)
                                )
                        }
                    }
                }
            )
            .frame(height: 48)
            
            // Error message if any
            if let errorMessage = errorMessage, !errorMessage.isEmpty {
                Text(errorMessage)
                    .font(AppTypography.caption())
                    .foregroundColor(AppColors.error)
                    .padding(.top, 4)
            }
        }
    }
}

// MARK: - Preview
#if DEBUG
@available(iOS 14.0, *)
struct AppTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            AppTextField(
                title: "Email",
                placeholder: "Enter your email",
                text: .constant(""),
                style: .outlined,
                icon: Image(systemName: "envelope")
            )
            
            AppTextField(
                title: "Password",
                placeholder: "Enter your password",
                text: .constant("password123"),
                style: .outlined,
                icon: Image(systemName: "lock"),
                isSecure: true
            )
            
            AppTextField(
                title: "Username",
                placeholder: "Enter your username",
                text: .constant("johndoe"),
                style: .filled,
                icon: Image(systemName: "person")
            )
            
            AppTextField(
                title: "Phone",
                placeholder: "Enter your phone number",
                text: .constant(""),
                style: .underlined,
                icon: Image(systemName: "phone"),
                errorMessage: "Please enter a valid phone number",
                keyboardType: .phonePad
            )
        }
        .padding()
    }
}
#endif
