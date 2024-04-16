//
// MUIColorThemes.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

/// A class containing built-in color themes of type MaterialUI ColorPalette for the MaterialUI package.
/// - Note: `MUIColorThemes` extension allows you to create a custom theme by setting thecolors.
@available(iOS 15.0, *)
final public class MUIColorThemes {
    
    // MARK: - Static Properties
    
    /// The built-in blue color theme for the MaterialUI package.
    public static let blue = MUIBlueTheme()
    
    /// The built-in green color theme for the MaterialUI package.
    public static let green = MUIGreenTheme()
    
    /// The built-in pink color theme for the MaterialUI package.
    public static let pink = MUIPinkTheme()
    
    /// The built-in purple color theme for the MaterialUI package.
    public static let purple = MUIPurpleTheme()
}

