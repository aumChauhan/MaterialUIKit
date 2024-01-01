//
// MaterialUIBlueTheme.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import Foundation
import SwiftUI

/// A concrete implementation of `MaterialUIColorThemeProtocol` representing the Material UI Blue color theme.
@available(iOS 17.0, *)
final public class MaterialUIBlueTheme: MaterialUIColorThemeProtocol {
    
    /// Returns the name of the Material UI Blue color theme.
    public func themeName() -> String {
        return "MaterialUIBlueTheme"
    }
    
    /// Returns the accent color for the given color scheme.
    public func accent(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? Color(hex: "246488") : Color(hex: "94CDF8")
    }
     
    /// Returns the icon color for the given color scheme.
    public func iconColor(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? Color(hex: "EDF2F6") : Color(hex: "202529")
    }
    
    /// Returns the background color for the given color scheme.
    public func background(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? Color(hex: "FFFFFF") : Color(hex: "181C1F")
    }
    
    /// Returns the secondary background color for the given color scheme.
    public func secondaryBackground(_ colorScheme: ColorScheme) -> Color {
        // F2F8FF
        colorScheme == .light ? Color(hex: "E4EEF9") : Color(hex: "22292F")
    }
    
    /// Returns the tertiary background color for the given color scheme.
    public func tertiaryBackground(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? Color(hex: "D3E4F5") : Color(hex: "384855")
    }
    
    /// Returns the accent title color for the given color scheme.
    public func accentTitle(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? Color(hex: "454A50") : Color(hex: "C9D0D6")
    }
    
    /// Returns the primary title color for the given color scheme.
    public func primaryTitle(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? Color(hex: "3D3D3D") : Color(hex: "E1E5E8")
    }
    
    /// Returns the secondary title color for the given color scheme.
    public func secondaryTitle(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .light ? Color(hex: "181D21") : Color(hex: "969A99")
    }
}
