//
// Color+UIColors.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 7/01/24
//

import SwiftUI
import UIKit

/// Extension on `UIColor` providing a convenience initializer to create a color from a hex string.
package extension UIColor {
    
    /// Initializes a color with a hex string and an optional alpha value.
    ///
    /// - Parameters:
    ///   - hex: A hex string representing the color.
    ///   - alpha: An optional alpha value (default is 1.0).
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

/// Extension on `Color` providing an initializer that dynamically selects a color based on the current user interface style.
package extension Color {
    
    /// Initializes a color with light and dark hex strings.
    ///
    /// - Parameters:
    ///   - lightHex: The hex string for the light mode color.
    ///   - darkHex: The hex string for the dark mode color.
    init(lightHex: String, darkHex: String) {
        self = Color(UIColor { (traitCollection) -> UIColor in
            if traitCollection.userInterfaceStyle == .dark {
                return UIColor(hex: darkHex)
            } else {
                return UIColor(hex: lightHex)
            }
        })
    }
}


