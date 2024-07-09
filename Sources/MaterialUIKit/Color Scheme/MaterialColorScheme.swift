//
// MaterialColorScheme.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

/// A protocol defining methods to provide color values for various components based on the specified color scheme.
public protocol MaterialColorScheme {
    /// The accent color used for emphasis.
    var accent: Color { get set }
    
    /// The tonal color used for tonal variations.
    var tonal: Color { get set }
    
    /// The color used for indicating errors and alerts.
    var error: Color { get set }
    
    /// The primary background color.
    var primaryBackground: Color { get set }
    
    /// The secondary background color.
    var secondaryBackground: Color { get set }
    
    /// The tertiary background color.
    var tertiaryBackground: Color { get set }
    
    /// The quaternary background color.
    var quaternaryBackground: Color { get set }
    
    /// The color used for highlighting elements.
    var highlight: Color { get set }
    
    /// The primary title color.
    var primaryTitle: Color { get set }
    
    /// The secondary title color.
    var secondaryTitle: Color { get set }
}
