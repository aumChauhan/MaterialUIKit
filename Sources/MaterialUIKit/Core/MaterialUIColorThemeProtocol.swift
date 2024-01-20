//
// MaterialUIColorThemeProtocol.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

/// A protocol defining methods to provide color values for various components based on the specified color scheme.
@available(iOS 15.0, *)
public protocol MaterialUIColorThemeProtocol {
    
    /// Returns the accent color based on the given color scheme.
    /// - Returns: The accent color.
    func accent() -> Color
    
    /// Returns the icon color based on the given color scheme.
    /// - Returns: The icon color.
    func iconColor() -> Color
    
    /// Returns the background co_ lor based on the given color scheme.
    /// - Returns: The background color.
    func background() -> Color
    
    /// Returns the secondary background color based on the given color scheme.
    /// - Returns: The secondary background color.
    func secondaryBackground() -> Color
    
    /// Returns the tertiary background color based on the given color scheme.
    /// - Returns: The tertiary background color.
    func tertiaryBackground() -> Color
    
    /// Returns the accent title color based on the given color scheme.
    /// - Returns: The accent title color.
    func accentTitle() -> Color
    
    /// Returns the primary title color based on the given color scheme.
    /// - Returns: The primary title color.
    func primaryTitle() -> Color
    
    /// Returns the secondary title color based on the given color scheme.
    /// - Returns: The secondary title color.
    func secondaryTitle() -> Color
    
    /// Returns the theme name.
    /// - Returns: Theme name (String).
    func themeName() -> String
}
