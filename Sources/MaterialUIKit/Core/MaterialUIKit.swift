//
// MaterialUI.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

/// The core class for the MaterialUI package containing configuration settings.
@available(iOS 15.0, *)
final public class MaterialUIKit {
    
    // MARK: - Properties
    
    /// The color palette tint for the MaterialUI package.
    ///
    /// Set this variable to customize the color palette used throughout the MaterialUI components.
    ///
    /// Example:
    /// ```swift
    /// init() {
    ///     MaterialUIKit.tint = MUIColorThemes.blue
    ///  }
    /// ```
    /// # Available Themes:
    /// - Blue, Green, Pink, Purple.
    public static var tint: MUIColorThemeProtocol = MUIColorThemes.pink
    
    // MARK: - Initializers
    
    private init() {
        print("MaterialUI color palette is set to \(MaterialUIKit.tint.themeName())")
    }
}
