//
// MaterialUIPurpleTheme.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import Foundation
import SwiftUI

/// A concrete implementation of `MaterialUIColorThemeProtocol` representing the Material UI Purple color theme.
@available(iOS 17.0, *)
final public class MaterialUIPurpleTheme: MaterialUIColorThemeProtocol {
    
    /// Returns the themeName
    public func themeName() -> String {
        return "MaterialUIPurpleTheme"
    }
    
    /// Returns the accent color for the given color scheme.
    public func accent() -> Color {
        Color(lightHex: "725188", darkHex: "DABBF5")
    }
    
    /// Returns the icon color for the given color scheme.
    public func iconColor() -> Color {
        Color(lightHex: "F2F0F5", darkHex: "262429")
    }
    
    /// Returns the background color for the given color scheme.
    public func background() -> Color {
        Color(lightHex: "FFFFFF", darkHex: "1D1B1E")
    }
    
    /// Returns the secondary background color for the given color scheme.
    public func secondaryBackground() -> Color {
        Color(lightHex: "F7E8F2", darkHex: "2B282F")
    }
    
    /// Returns the tertiary background color for the given color scheme.
    public func tertiaryBackground() -> Color {
        Color(lightHex: "F0DDF5", darkHex: "4F4256")
    }
    
    /// Returns the accent title color for the given color scheme.
    public func accentTitle() -> Color {
        Color(lightHex: "48434B", darkHex: "E3D7EA")
    }
    
    /// Returns the primary title color for the given color scheme.
    public func primaryTitle() -> Color {
        Color(lightHex: "727574", darkHex: "D1CBD1")
    }
    
    /// Returns the secondary title color for the given color scheme.
    public func secondaryTitle() -> Color {
        Color(lightHex: "4F4E52", darkHex: "8E8C8D")
    }
}
