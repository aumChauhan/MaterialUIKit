//
// MaterialUIColorThemeProtocol.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

/// A protocol defining methods to provide color values for various components based on the specified color scheme.
@available(iOS 17.0, *)
public protocol MaterialUIColorThemeProtocol {
    
    /// Returns the accent color based on the given color scheme.
    /// - Parameter colorScheme: The color scheme (light or dark).
    /// - Returns: The accent color.
    func accent(_ colorScheme: ColorScheme) -> Color
    
    /// Returns the icon color based on the given color scheme.
    /// - Parameter colorScheme: The color scheme (light or dark).
    /// - Returns: The icon color.
    func iconColor(_ colorScheme: ColorScheme) -> Color
    
    /// Returns the background co_ lor based on the given color scheme.
    /// - Parameter colorScheme: The color scheme (light or dark).
    /// - Returns: The background color.
    func background(_ colorScheme: ColorScheme) -> Color
    
    /// Returns the secondary background color based on the given color scheme.
    /// - Parameter colorScheme: The color scheme (light or dark).
    /// - Returns: The secondary background color.
    func secondaryBackground(_ colorScheme: ColorScheme) -> Color
    
    /// Returns the tertiary background color based on the given color scheme.
    /// - Parameter colorScheme: The color scheme (light or dark).
    /// - Returns: The tertiary background color.
    func tertiaryBackground(_ colorScheme: ColorScheme) -> Color
    
    /// Returns the accent title color based on the given color scheme.
    /// - Parameter colorScheme: The color scheme (light or dark).
    /// - Returns: The accent title color.
    func accentTitle(_ colorScheme: ColorScheme) -> Color
    
    /// Returns the primary title color based on the given color scheme.
    /// - Parameter colorScheme: The color scheme (light or dark).
    /// - Returns: The primary title color.
    func primaryTitle(_ colorScheme: ColorScheme) -> Color
    
    /// Returns the secondary title color based on the given color scheme.
    /// - Parameter colorScheme: The color scheme (light or dark).
    /// - Returns: The secondary title color.
    func secondaryTitle(_ colorScheme: ColorScheme) -> Color
    
    /// Returns the theme name.
    /// - Returns: Theme name (String).
    func themeName() -> String
}
