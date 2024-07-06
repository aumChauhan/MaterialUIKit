//
// MUIBlueTheme.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import Foundation
import SwiftUI

/// A concrete implementation of `MaterialColorScheme` representing the Material UI Blue color theme.
@available(iOS 15.0, *)
public struct MUIBlueTheme: MaterialColorScheme {
    
    /// Returns the theme name.
    public func themeName() -> String {
        return "MaterialUI-BlueTheme"
    }
    
    /// Returns the accent color for the `MUIBlueTheme` color scheme.
    public func accent() -> Color {
        Color(lightHex: "246488", darkHex: "94CDF8")
    }
     
    /// Returns the accent tone color for the `MUIBlueTheme` color scheme.
    public func tonal() -> Color {
        Color(lightHex: "EDF2F6", darkHex: "202529")
    }
    
    /// Returns the primary background color for the `MUIBlueTheme` color scheme.
    public func primaryBackground() -> Color {
        Color(lightHex: "FFFFFF", darkHex: "181C1F")
    }
    
    /// Returns the secondary background color for the `MUIBlueTheme` color scheme.
    public func secondaryBackground() -> Color {
        // F2F8FF
        Color(lightHex: "E4EEF9", darkHex: "22292F")
    }
    
    /// Returns the tertiary background color for the `MUIBlueTheme` color scheme.
    public func tertiaryBackground() -> Color {
        Color(lightHex: "D3E4F5", darkHex: "384855")
    }
    
    /// Returns the accent title color for the `MUIBlueTheme` color scheme.
    public func highlight() -> Color {
        Color(lightHex: "454A50", darkHex: "C9D0D6")
    }
    
    /// Returns the primary title color for the `MUIBlueTheme` color scheme.
    public func primaryTitle() -> Color {
        Color(lightHex: "3D3D3D", darkHex: "E1E5E8")
    }
    
    /// Returns the secondary title color for the `MUIBlueTheme` color scheme.
    public func secondaryTitle() -> Color {
        Color(lightHex: "181D21", darkHex: "969A99")
    }
}
