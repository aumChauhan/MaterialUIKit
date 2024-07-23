//
// Color+MaterialColorScheme.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 16/04/24
//

import SwiftUI

/// A set of custom color definitions tailored for MaterialUIKit styling.
public extension Color {
    /// The accent color based on the current color scheme setting.
    static let materialAccent: Color = MaterialUIKit.configuration.colorScheme.accent
    
    /// The accent tonal color shade based on the current color scheme setting.
    static var materialTonal: Color = MaterialUIKit.configuration.colorScheme.tonal
    
    /// The primary background color based on the current color scheme setting.
    static var materialPrimaryBackground: Color = MaterialUIKit.configuration.colorScheme.primaryBackground
    
    /// The secondary background color based on the current color scheme setting.
    static var materialSecondaryBackground: Color = MaterialUIKit.configuration.colorScheme.secondaryBackground
    
    /// The tertiary background color based on the current color scheme setting.
    static var materialTertiaryBackground: Color = MaterialUIKit.configuration.colorScheme.tertiaryBackground
    
    /// The quaternary background color based on the current color scheme setting.
    static var materialQuaternaryBackground: Color = MaterialUIKit.configuration.colorScheme.quaternaryBackground
    
    /// The accent title color based on the current color scheme setting.
    static var materialHighlight: Color = MaterialUIKit.configuration.colorScheme.highlight
    
    /// The primary title color based on the current color scheme setting.
    static var materialPrimaryTitle: Color = MaterialUIKit.configuration.colorScheme.primaryTitle
    
    /// The secondary title color based on the current color scheme setting.
    static var materialSecondaryTitle: Color = MaterialUIKit.configuration.colorScheme.secondaryTitle
    
    /// The color used for indicating errors and alerts.
    static var materialOnError: Color = MaterialUIKit.configuration.colorScheme.onError
    
    /// The separator color based on the current color scheme setting.
    static var materialSeparator: Color = MaterialUIKit.configuration.colorScheme.separator
    
    /// The color used for indicating inactive or disabled state.
    static var materialOnDisabled: Color = MaterialUIKit.configuration.colorScheme.onDisabled
    
    /// The color used for outlines and stroke.
    static var materialOutline: Color = MaterialUIKit.configuration.colorScheme.outline
}
