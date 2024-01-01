//
// MaterialUIColorThemes.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

/// A class containing built-in color themes of type `MaterialUIColorPalette` for the MaterialUI package.
/// - Note: MaterialUIColorThemes extension allows you to create a custom theme by setting thecolors.
@available(iOS 17.0, *)
final public class MaterialUIColorThemes {
    
    // MARK: - Static Properties
    
    /// The built-in blue color theme for the MaterialUI package.
    public static let blue = MaterialUIBlueTheme()
    
    /// The built-in green color theme for the MaterialUI package.
    public static let green = MaterialUIGreenTheme()
    
    /// The built-in pink color theme for the MaterialUI package.
    public static let pink = MaterialUIPinkTheme()
    
    /// The built-in purple color theme for the MaterialUI package.
    public static let purple = MaterialUIPurpleTheme()
}


/// Extension to create SwiftUI `Color` from hexadecimal color values.
@available(iOS 17.0, *)
extension Color {
    
    /// Creates a `Color` instance with a hexadecimal color value.
    ///
    /// - Parameter hex: A string representing the hexadecimal color value.
    ///                  It can be in the format "#RRGGBB" or "RRGGBB".
    @available(iOS 17.0, *)
    public init(hex: String) {
        // Trim and sanitize the input hex string
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        // Convert hex string to a UInt64 integer
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        // Extract red, green, and blue components from the integer
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        
        // Initialize the Color with the extracted components
        self.init(red: red, green: green, blue: blue)
    }
}
