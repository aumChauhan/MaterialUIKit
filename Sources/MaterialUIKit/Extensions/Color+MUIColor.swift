//
// ShapeStyle+MUIColors.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 16/04/24
//


import SwiftUI

///  A set of custom color definitions tailored for MaterialUIKit styling.
@available(iOS 15.0, *)
public extension Color {
    
    /// The accent color based on the current tint setting.
    static var muiAccent: Color {
        MaterialUIKit.tint.accent()
    }
    
    /// The accent tonal color shade based on the current tint setting.
    static var muiTonal: Color {
        MaterialUIKit.tint.tonal()
    }
    
    /// The primary background color based on the current tint setting.
    static var muiPrimaryBackground: Color {
        MaterialUIKit.tint.primaryBackground()
    }
    
    /// The secondary background color based on the current tint setting.
    static var muiSecondaryBackground: Color {
        MaterialUIKit.tint.secondaryBackground()
    }
    
    /// The tertiary background color based on the current tint setting.
    static var muiTertiaryBackground: Color {
        MaterialUIKit.tint.tertiaryBackground()
    }
    
    /// The accent title color based on the current tint setting.
    static var muiAccentTitle: Color {
        MaterialUIKit.tint.accentTitle()
    }
    
    /// The primary title color based on the current tint setting.
    static var muiPrimaryTitle: Color {
        MaterialUIKit.tint.primaryTitle()
    }
    
    /// The secondary title color based on the current tint setting.
    static var muiSecondaryTitle: Color {
        MaterialUIKit.tint.secondaryTitle()
    }
}
