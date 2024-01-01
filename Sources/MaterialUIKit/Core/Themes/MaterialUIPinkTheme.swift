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
    
    /// Returns the name of the Material UI Pink color theme.
    public func themeName() -> String {
        return "MaterialUIPinkTheme"
    }
    
    /// Returns the accent color for the given color scheme.
    public func accent(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? Color(hex: "904858") : Color(hex: "FFB1C1")
    }
    
    /// Returns the icon color for the given color scheme.
    public func iconColor(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? Color(hex: "F5F1F2") : Color(hex: "2B2122")
    }
    
    /// Returns the background color for the given color scheme.
    public func background(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? Color(hex: "FFFFFF") : Color(hex: "201A1A")
    }
    
    /// Returns the secondary background color for the given color scheme.
    public func secondaryBackground(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? Color(hex: "FEE5E5") : Color(hex: "34282A")
    }
    
    /// Returns the tertiary background color for the given color scheme.
    public func tertiaryBackground(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? Color(hex: "FED9E0") : Color(hex: "5C3F43")
    }
    
    /// Returns the accent title color for the given color scheme.
    public func accentTitle(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? Color(hex: "2C1619") : Color(hex: "E9C7C9")
    }
    
    /// Returns the primary title color for the given color scheme.
    public func primaryTitle(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? Color(hex: "514C4C") : Color(hex: "C1B7B8")
    }
    
    /// Returns the secondary title color for the given color scheme.
    public func secondaryTitle(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? Color(hex: "736B6A") : Color(hex: "8F8F8D")
    }
}
