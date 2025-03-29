# PulseUI Usage Guide

This guide will help you integrate and use the PulseUI in your SwiftUI projects.

## Installation

### Swift Package Manager

1. In Xcode, go to File > Swift Packages > Add Package Dependency
2. Enter the repository URL: `https://github.com/giovannamoeller/PulseUI.git`
3. Select the version rules and click Next
4. Choose the target you want to add the package to and click Finish

## Basic Setup

First, import the package in your SwiftUI files:

```swift
import PulseUI
```

### Setting up the Design System

In your `App.swift` or root view, set up the design system environment:

```swift
@main
struct MyApp: App {
    @StateObject private var designSystem = DesignSystem()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .designSystem(designSystem)
        }
    }
}
```

For dark mode support, you can conditionally use different design systems:

```swift
@main
struct MyApp: App {
    @Environment(\.colorScheme) private var colorScheme
    @StateObject private var lightDesignSystem = DesignSystem.light
    @StateObject private var darkDesignSystem = DesignSystem.dark
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .designSystem(colorScheme == .dark ? darkDesignSystem : lightDesignSystem)
        }
    }
}
```

## Using Components

### Buttons

```swift
// Primary Button
AppButton(
    title: "Sign In", 
    action: signIn
)

// Secondary Button
AppButton(
    title: "Cancel", 
    type: .secondary, 
    action: cancel
)

// Text Button
AppButton(
    title: "Forgot Password?", 
    type: .text, 
    action: forgotPassword
)

// Icon Button
AppButton(
    icon: Image(systemName: "plus"), 
    action: addItem
)

// Floating Action Button
AppButton(
    icon: Image(systemName: "pencil"), 
    type: .floating, 
    action: editItem
)

// Gradient Button
AppButton(
    title: "Subscribe", 
    startColor: Color(hex: "#4568DC"), 
    endColor: Color(hex: "#B06AB3"), 
    action: subscribe
)
```

### Cards

```swift
// Elevated Card (with shadow)
AppCard {
    VStack(alignment: .leading) {
        Text("Card Title")
            .font(AppTypography.subheading())
        Text("Card content goes here...")
            .font(AppTypography.body())
    }
}

// Outlined Card
AppCard(style: .outlined) {
    // Your content here
}

// Flat Card
AppCard(style: .flat) {
    // Your content here
}
```

### Text Fields

```swift
@State private var email = ""
@State private var password = ""

var body: some View {
    VStack {
        AppTextField(
            title: "Email",
            placeholder: "Enter your email",
            text: $email,
            icon: Image(systemName: "envelope")
        )
        
        AppTextField(
            title: "Password",
            placeholder: "Enter your password",
            text: $password,
            icon: Image(systemName: "lock"),
            isSecure: true
        )
    }
}
```

## Using Design Tokens

### Colors

```swift
Text("Primary Color")
    .foregroundColor(AppColors.primary)
    
Rectangle()
    .fill(AppColors.secondaryBackground)
    
// Using hex colors
Text("Custom Color")
    .foregroundColor(Color(hex: "#FF5733"))
```

### Typography

```swift
Text("This is a title")
    .font(AppTypography.title())
    
Text("This is a heading")
    .font(AppTypography.heading())
    
Text("This is body text")
    .font(AppTypography.body())
    
Text("This is caption text")
    .font(AppTypography.caption())
```

### Spacing

```swift
VStack(spacing: AppSpacing.medium) {
    // Content with medium spacing
}

.padding(.horizontal, AppSpacing.large)
```

### Shadows

```swift
RoundedRectangle(cornerRadius: AppShapes.mediumRadius)
    .modifier(AppShadows.medium())
    
// Or using extension
MyView()
    .shadow(AppShadows.small())
```

### Shapes

```swift
RoundedRectangle(cornerRadius: AppShapes.largeRadius)

Circle()
    .frame(width: 50, height: 50)
```

## Customizing the Design System

You can customize the design system by modifying the properties of your `DesignSystem` instance:

```swift
// In your setup code
designSystem.primaryColor = Color(hex: "#FF0000") // Change to red
designSystem.backgroundColor = Color(hex: "#F5F5F5") // Light gray background
```

## Best Practices

1. **Consistency**: Use the design system components and tokens consistently throughout your app.
2. **Avoid Hardcoding**: Don't hardcode colors, fonts, or spacing values. Always use the design system values.
3. **Responsive Design**: Consider different screen sizes and orientations when using the design system.
4. **Documentation**: Document any custom extensions or modifications to the design system.

## Example: Login Screen

Here's an example of a login screen using the design system:

```swift
struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @Environment(\.designSystem) private var designSystem
    
    var body: some View {
        VStack(spacing: AppSpacing.large) {
            // Logo and Title
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            
            Text("Welcome Back")
                .font(AppTypography.title())
                .foregroundColor(designSystem.primaryTextColor)
            
            // Form Fields
            AppCard {
                VStack(spacing: AppSpacing.medium) {
                    AppTextField(
                        title: "Email",
                        placeholder: "Enter your email",
                        text: $email,
                        icon: Image(systemName: "envelope")
                    )
                    
                    AppTextField(
                        title: "Password",
                        placeholder: "Enter your password",
                        text: $password,
                        icon: Image(systemName: "lock"),
                        isSecure: true
                    )
                    
                    AppButton(title: "Forgot Password?", type: .text, action: forgotPassword)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            
            // Login Button
            AppButton(
                title: "Sign In",
                action: login,
                isFullWidth: true
            )
            
            // Register Link
            HStack {
                Text("Don't have an account?")
                    .font(AppTypography.body())
                    .foregroundColor(designSystem.secondaryTextColor)
                
                AppButton(title: "Sign Up", type: .text, action: register)
            }
            .padding(.top)
        }
        .padding(.horizontal, AppSpacing.large)
        .padding(.vertical, AppSpacing.xxLarge)
        .background(designSystem.backgroundColor.edgesIgnoringSafeArea(.all))
    }
    
    private func login() {
        // Implement login functionality
    }
    
    private func forgotPassword() {
        // Implement forgot password functionality
    }
    
    private func register() {
        // Navigate to registration screen
    }
}
```
