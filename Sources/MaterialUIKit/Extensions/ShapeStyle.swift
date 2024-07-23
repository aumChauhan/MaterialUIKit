//
// ShapeStyle.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 16/04/24
//

import SwiftUI

/// A set of custom color definitions tailored for MaterialUIKit styling.
public extension ShapeStyle where Self == Color {
    /// The accent color based on the current color scheme setting.
    static var materialAccent: Color {
        MaterialUIKit.configuration.colorScheme.accent
    }
    
    /// The accent tonal color shade based on the current color scheme setting.
    static var materialTonal: Color {
        MaterialUIKit.configuration.colorScheme.tonal
    }
    
    /// The primary background color based on the current color scheme setting.
    static var materialPrimaryBackground: Color {
        MaterialUIKit.configuration.colorScheme.primaryBackground
    }
    
    /// The secondary background color based on the current color scheme setting.
    static var materialSecondaryBackground: Color {
        MaterialUIKit.configuration.colorScheme.secondaryBackground
    }
    
    /// The tertiary background color based on the current color scheme setting.
    static var materialTertiaryBackground: Color {
        MaterialUIKit.configuration.colorScheme.tertiaryBackground
    }
    
    /// The quaternary background color based on the current color scheme setting.
    static var materialQuaternaryBackground: Color {
        MaterialUIKit.configuration.colorScheme.quaternaryBackground
    }
    
    /// The accent title color based on the current color scheme setting.
    static var materialHighlight: Color {
        MaterialUIKit.configuration.colorScheme.highlight
    }
    
    /// The primary title color based on the current color scheme setting.
    static var materialPrimaryTitle: Color {
        MaterialUIKit.configuration.colorScheme.primaryTitle
    }
    
    /// The secondary title color based on the current color scheme setting.
    static var materialSecondaryTitle: Color {
        MaterialUIKit.configuration.colorScheme.secondaryTitle
    }
    
    /// The color used for indicating errors and alerts.
    static var materialError: Color {
        MaterialUIKit.configuration.colorScheme.error
    }
    
    /// The divider color based on the current color scheme setting.
    static var materialDivider: Color {
        MaterialUIKit.configuration.colorScheme.dividerColor
    }
}
