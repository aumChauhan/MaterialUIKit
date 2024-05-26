//
// MUIGreenTheme.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import Foundation
import SwiftUI

/// A concrete implementation of `MUIColorThemeProtocol` representing the Material UI Green color theme.
@available(iOS 15.0, *)
public struct MUIGreenTheme: MUIColorThemeProtocol {
    
    /// Returns the theme name.
    public func themeName() -> String {
        return "MaterialUI-GreenTheme"
    }
    
    /// Returns the accent color for the given `MUIGreenTheme` scheme.
    public func accent() -> Color {
        Color(lightHex: "38693C", darkHex: "9DD49D")
    }
    
    /// Returns the accent tone color for the `MUIGreenTheme` color scheme.
    public func tonal() -> Color {
        Color(lightHex: "EDF2EE", darkHex: "20251F")
    }
    
    /// Returns the primary background color for the `MUIGreenTheme` color scheme.
    public func primaryBackground() -> Color {
        Color(lightHex: "FFFFFF", darkHex: "1A1C19")
    }
    
    /// Returns the secondary background color for the `MUIGreenTheme` color scheme.
    public func secondaryBackground() -> Color {
        Color(lightHex: "EAF0E6", darkHex: "262D25")
    }
    
    /// Returns the tertiary background color for the `MUIGreenTheme` color scheme.
    public func tertiaryBackground() -> Color {
        Color(lightHex: "D4E7D0", darkHex: "3A4B39")
    }
    
    /// Returns the accent title color for the `MUIGreenTheme` color scheme.
    public func accentTitle() -> Color {
        Color(lightHex: "101E0E", darkHex: "C1C9BC")
    }
    
    /// Returns the primary title color for the `MUIGreenTheme` color scheme.
    public func primaryTitle() -> Color {
        Color(lightHex: "747474", darkHex: "CAD0C8")
    }
    
    /// Returns the secondary title color for the `MUIGreenTheme` color scheme.
    public func secondaryTitle() -> Color {
        Color(lightHex: "51534B", darkHex: "909090")
    }
}
