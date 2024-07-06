//
// MUIPinkTheme.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import Foundation
import SwiftUI

/// A concrete implementation of `MaterialColorScheme` representing the Material UI Pink color theme.
@available(iOS 15.0, *)
public struct MUIPinkTheme: MaterialColorScheme {
    
    /// Returns the theme name
    public func themeName() -> String {
        return "MaterialUI-PinkTheme"
    }
    
    /// Returns the accent color for the `MUIPinkTheme` color scheme.
    public func accent() -> Color {
        Color(lightHex: "904858", darkHex : "FFB1C1")
    }
    
    /// Returns the accent tone color for the `MUIPinkTheme` color scheme.
    public func tonal() -> Color {
        Color(lightHex: "F5F1F2", darkHex : "2B2122")
    }
    
    /// Returns the primary background color for the `MUIPinkTheme` color scheme.
    public func primaryBackground() -> Color {
        Color(lightHex: "FFFFFF", darkHex : "201A1A")
    }
    
    /// Returns the secondary background color for the `MUIPinkTheme` color scheme.
    public func secondaryBackground() -> Color {
        Color(lightHex: "FEE5E5", darkHex : "34282A")
    }
    
    /// Returns the tertiary background color for the `MUIPinkTheme` color scheme.
    public func tertiaryBackground() -> Color {
        Color(lightHex: "FED9E0", darkHex : "5C3F43")
    }
    
    /// Returns the accent title color for the `MUIPinkTheme` color scheme.
    public func highlight() -> Color {
        Color(lightHex: "2C1619", darkHex : "E9C7C9")
    }
    
    /// Returns the primary title color for the `MUIPinkTheme` color scheme.
    public func primaryTitle() -> Color {
        Color(lightHex: "514C4C", darkHex : "C1B7B8")
    }
    
    /// Returns the secondary title color for the `MUIPinkTheme` color scheme.
    public func secondaryTitle() -> Color {
        Color(lightHex: "736B6A", darkHex : "8F8F8D")
    }
}
