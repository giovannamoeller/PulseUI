//
//  AppColors.swift
//  PulseUI
//
//  Created by Giovanna Moeller on 28/03/25.
//

import SwiftUI

@available(iOS 14.0, *)
public struct AppColors {
    // Primary colors
    public static let primary = Color(hex: "#007AFF")      // iOS Blue
    public static let secondary = Color(hex: "#5856D6")    // iOS Purple
    public static let accent = Color(hex: "#FF2D55")       // iOS Pink
    
    // Background colors
    public static let background = Color(hex: "#FFFFFF")   // White
    public static let secondaryBackground = Color(hex: "#F2F2F7") // iOS Light Gray
    
    // Text colors
    public static let primaryText = Color(hex: "#000000")  // Black
    public static let secondaryText = Color(hex: "#3C3C43") // Dark Gray with opacity
    public static let tertiaryText = Color(hex: "#8E8E93") // Medium Gray
    
    // Status colors
    public static let success = Color(hex: "#34C759")      // iOS Green
    public static let warning = Color(hex: "#FF9500")      // iOS Orange
    public static let error = Color(hex: "#FF3B30")        // iOS Red
    public static let info = Color(hex: "#64D2FF")         // iOS Light Blue
    
    // Additional colors for more extensive palette
    public struct Gray {
        public static let gray1 = Color(hex: "#8E8E93")
        public static let gray2 = Color(hex: "#AEAEB2")
        public static let gray3 = Color(hex: "#C7C7CC")
        public static let gray4 = Color(hex: "#D1D1D6")
        public static let gray5 = Color(hex: "#E5E5EA")
        public static let gray6 = Color(hex: "#F2F2F7")
    }
    
    public struct Brand {
        // Add your specific brand colors here
        public static let primary = Color(hex: "#007AFF")  // Customize with your primary brand color
        public static let secondary = Color(hex: "#5856D6") // Customize with your secondary brand color
    }
}

// Extension to create Color from hex string
@available(iOS 14.0, *)
public extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    // Convert Color to hex string
    var hexString: String? {
        guard let components = UIColor(self).cgColor.components else { return nil }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        
        return String(format: "#%02lX%02lX%02lX",
                     lroundf(r * 255),
                     lroundf(g * 255),
                     lroundf(b * 255))
    }
}

@available(iOS 14.0, *)
// Helper for colors with opacity
public extension Color {
    // Darken a color by percentage (0-1)
    func darken(_ percentage: Double) -> Color {
        guard let components = UIColor(self).cgColor.components else { return self }
        
        let factor = 1.0 - max(0, min(1, percentage))
        
        let r = Double(components[0]) * factor
        let g = Double(components[1]) * factor
        let b = Double(components[2]) * factor
        
        return Color(.sRGB, red: r, green: g, blue: b, opacity: Double(components[3]))
    }
    
    // Lighten a color by percentage (0-1)
    func lighten(_ percentage: Double) -> Color {
        guard let components = UIColor(self).cgColor.components else { return self }
        
        let factor = max(0, min(1, percentage))
        
        let r = Double(components[0]) + (1.0 - Double(components[0])) * factor
        let g = Double(components[1]) + (1.0 - Double(components[1])) * factor
        let b = Double(components[2]) + (1.0 - Double(components[2])) * factor
        
        return Color(.sRGB, red: r, green: g, blue: b, opacity: Double(components[3]))
    }
}
