# PulseUI

A comprehensive, customizable SwiftUI design system for iOS applications. Easily implement consistent UI components across your apps.

## Features

- 🎨 Consistent color palette and theming
- 📝 Typography system with predefined text styles
- 🔘 Various button styles and configurations
- 🖼️ Card components for organizing content
- 📱 Input components for forms
- 📏 Standardized spacing and layout
- 🌈 Shadow and shape definitions
- 🎭 Light and dark mode support
- 🔌 Swift Package Manager compatibility

## Requirements

- iOS 14.0+
- Swift 6.0+
- Xcode 15.0+

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/giovannamoeller/PulseUI.git", from: "1.0.0")
]
```

Or via Xcode:
1. Go to File > Swift Packages > Add Package Dependency
2. Enter the repository URL: `https://github.com/giovannamoeller/PulseUI.git`
3. Select version requirements and target

## Quick Start

```swift
import PulseUI

struct ContentView: View {
    @State private var text = ""
    
    var body: some View {
        VStack(spacing: AppSpacing.medium) {
            // Typography
            Text("Welcome to PulseUI")
                .font(AppTypography.title())
                .foregroundColor(AppColors.primary)
            
            // Card
            AppCard {
                VStack(alignment: .leading) {
                    Text("This is a card")
                        .font(AppTypography.subheading())
                    Text("With consistent styling")
                        .font(AppTypography.body())
                }
            }
            
            // Text field
            AppTextField(
                title: "Input",
                placeholder: "Enter something",
                text: $text,
                icon: Image(systemName: "pencil")
            )
            
            // Button
            AppButton(
                title: "Primary Action",
                action: {
                    print("Button tapped")
                }
            )
        }
        .padding(AppSpacing.large)
    }
}
```

## Components

- **AppButton**: Versatile button component with various styles (primary, secondary, text, icon, floating, gradient)
- **AppCard**: Container component with different styles (elevated, outlined, flat)
- **AppTextField**: Input field with various styles (outlined, filled, underlined)

## Design Tokens

- **AppColors**: Color definitions with support for hex values
- **AppTypography**: Text styles and font sizes
- **AppSpacing**: Consistent spacing values
- **AppShapes**: Corner radius and shape definitions
- **AppShadows**: Shadow presets for depth

## Customization

Customize the design system through the `DesignSystem` environment object:

```swift
@main
struct MyApp: App {
    @StateObject private var designSystem = DesignSystem()
    
    init() {
        // Customize design system
        designSystem.primaryColor = Color(hex: "#FF0000")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .designSystem(designSystem)
        }
    }
}
```

## Documentation

For detailed documentation and usage examples, see the [PulseUI Usage Guide](Usage.md).

## License

This project is available under the MIT license. See the LICENSE file for more info.

## Author

Giovanna Moeller


