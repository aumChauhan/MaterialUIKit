//
// ShapeStyle+MUIColors.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 16/04/24
//

import SwiftUI

///  A set of custom color definitions tailored for MaterialUIKit styling.
public extension Color {
    /// The accent color based on the current tint setting.
    static let materialAccent: Color = MaterialUIKit.tint.accent()
    
    /// The accent tonal color shade based on the current tint setting.
    static var materialTonal: Color {
        MaterialUIKit.tint.tonal()
    }
    
    /// The primary background color based on the current tint setting.
    static var materialPrimaryBackground: Color {
        MaterialUIKit.tint.primaryBackground()
    }
    
    /// The secondary background color based on the current tint setting.
    static var materialSecondaryBackground: Color {
        MaterialUIKit.tint.secondaryBackground()
    }
    
    /// The tertiary background color based on the current tint setting.
    static var materialTertiaryBackground: Color {
        MaterialUIKit.tint.tertiaryBackground()
    }
    
    /// The accent title color based on the current tint setting.
    static var materialHighlight: Color {
        MaterialUIKit.tint.highlight()
    }
    
    /// The primary title color based on the current tint setting.
    static var materialPrimaryTitle: Color {
        MaterialUIKit.tint.primaryTitle()
    }
    
    /// The secondary title color based on the current tint setting.
    static var materialSecondaryTitle: Color {
        MaterialUIKit.tint.secondaryTitle()
    }
}
