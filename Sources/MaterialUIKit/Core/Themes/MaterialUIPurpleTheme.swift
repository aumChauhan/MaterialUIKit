//
// MaterialUIPurpleTheme.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import Foundation
import SwiftUI

/// A concrete implementation of `MaterialUIColorThemeProtocol` representing the Material UI Purple color theme.
@available(iOS 17.0, *)
final public class MaterialUIPurpleTheme: MaterialUIColorThemeProtocol {
    
    /// Returns the name of the Material UI Purple color theme.
    public func themeName() -> String {
        return "MaterialUIPurpleTheme"
    }
    
    /// Returns the accent color for the given color scheme.
    public func accent(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? Color(hex: "725188") : Color(hex: "DABBF5")
    }
    
    /// Returns the icon color for the given color scheme.
    public func iconColor(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? Color(hex: "F2F0F5") : Color(hex: "262429")
    }
    
    /// Returns the background color for the given color scheme.
    public func background(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? Color(hex: "FFFFFF") : Color(hex: "1D1B1E")
    }
    
    /// Returns the secondary background color for the given color scheme.
    public func secondaryBackground(_ colorScheme: ColorScheme) -> Color {
       colorScheme == .light ? Color(hex: "F7E8F2") : Color(hex: "2B282F")
    }
    
    /// Returns the tertiary background color for the given color scheme.
    public func tertiaryBackground(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? Color(hex: "F0DDF5") : Color(hex: "4F4256")
    }
    
    /// Returns the accent title color for the given color scheme.
    public func accentTitle(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? Color(hex: "48434B") : Color(hex: "E3D7EA")
    }
    
    /// Returns the primary title color for the given color scheme.
    public func primaryTitle(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? Color(hex: "727574") : Color(hex: "D1CBD1")
    }
    
    /// Returns the secondary title color for the given color scheme.
    public func secondaryTitle(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? Color(hex: "4F4E52") : Color(hex: "8E8C8D")
    }
}
