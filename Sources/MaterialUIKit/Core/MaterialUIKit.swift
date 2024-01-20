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
final public class MaterialUI {
    
    // MARK: - Properties
    
    /// The color palette tint for the MaterialUI package.
    ///
    /// Set this variable to customize the color palette used throughout the MaterialUI components.
    ///
    /// Example:
    /// ```swift
    /// init() {
    ///     MaterialUI.tint = MaterialUIColorThemes.blue
    ///  }
    /// ```
    /// # Available Themes:
    /// - Blue, Green, Pink, Purple.
    public static var tint: MaterialUIColorThemeProtocol = MaterialUIColorThemes.blue
    
    // MARK: - Initializers
    
    private init() {
        print("MaterialUI color palette is set to \(MaterialUI.tint.themeName())")
    }
}
