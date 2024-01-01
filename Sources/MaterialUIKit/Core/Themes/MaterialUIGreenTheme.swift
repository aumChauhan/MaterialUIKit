//
// MaterialUIGreenTheme.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import Foundation
import SwiftUI

/// A concrete implementation of `MaterialUIColorThemeProtocol` representing the Material UI Green color theme.
@available(iOS 17.0, *)
final public class MaterialUIGreenTheme: MaterialUIColorThemeProtocol {
    
    /// Returns the name of the Material UI Green color theme.
    public func themeName() -> String {
        return "MaterialUIGreenTheme"
    }
    
    /// Returns the accent color for the given color scheme.
    public func accent(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? Color(hex: "38693C") : Color(hex: "9DD49D")
    }
    
    /// Returns the icon color for the given color scheme.
    public func iconColor(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? Color(hex: "EDF2EE") : Color(hex: "20251F")
    }
    
    /// Returns the background color for the given color scheme.
    public func background(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? Color(hex: "FFFFFF") : Color(hex: "1A1C19")
    }
    
    /// Returns the secondary background color for the given color scheme.
    public func secondaryBackground(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? Color(hex: "EAF0E6") : Color(hex: "262D25")
    }
    
    /// Returns the tertiary background color for the given color scheme.
    public func tertiaryBackground(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? Color(hex: "D4E7D0") : Color(hex: "3A4B39")
    }
    
    /// Returns the accent title color for the given color scheme.
    public func accentTitle(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? Color(hex: "101E0E") : Color(hex: "C1C9BC")
    }
    
    /// Returns the primary title color for the given color scheme.
    public func primaryTitle(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? Color(hex: "747474") : Color(hex: "CAD0C8")
    }
    
    /// Returns the secondary title color for the given color scheme.
    public func secondaryTitle(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? Color(hex: "51534B") : Color(hex: "909090")
    }
}
