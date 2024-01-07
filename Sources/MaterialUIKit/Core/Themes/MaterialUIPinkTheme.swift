//
// MaterialUIPinkTheme.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import Foundation
import SwiftUI

/// A concrete implementation of `MaterialUIColorThemeProtocol` representing the Material UI Pink color theme.
@available(iOS 17.0, *)
final public class MaterialUIPinkTheme: MaterialUIColorThemeProtocol {
    
    /// Returns the theme name
    public func themeName() -> String {
        return "MaterialUIPinkTheme"
    }
    
    /// Returns the accent color for the given color scheme.
    public func accent() -> Color {
        Color(lightHex: "904858", darkHex : "FFB1C1")
    }
    
    /// Returns the icon color for the given color scheme.
    public func iconColor() -> Color {
        Color(lightHex: "F5F1F2", darkHex : "2B2122")
    }
    
    /// Returns the background color for the given color scheme.
    public func background() -> Color {
        Color(lightHex: "FFFFFF", darkHex : "201A1A")
    }
    
    /// Returns the secondary background color for the given color scheme.
    public func secondaryBackground() -> Color {
        Color(lightHex: "FEE5E5", darkHex : "34282A")
    }
    
    /// Returns the tertiary background color for the given color scheme.
    public func tertiaryBackground() -> Color {
        Color(lightHex: "FED9E0", darkHex : "5C3F43")
    }
    
    /// Returns the accent title color for the given color scheme.
    public func accentTitle() -> Color {
        Color(lightHex: "2C1619", darkHex : "E9C7C9")
    }
    
    /// Returns the primary title color for the given color scheme.
    public func primaryTitle() -> Color {
        Color(lightHex: "514C4C", darkHex : "C1B7B8")
    }
    
    /// Returns the secondary title color for the given color scheme.
    public func secondaryTitle() -> Color {
        Color(lightHex: "736B6A", darkHex : "8F8F8D")
    }
}
