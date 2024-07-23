//
// MaterialColorScheme.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

/// Definines the color scheme for Material UI components.
public protocol MaterialColorScheme {
    /// The accent color used for emphasis.
    var accent: Color { get set }
    
    /// The tonal color used for tonal variations.
    var tonal: Color { get set }
    
    /// The color used for indicating errors and alerts.
    var onError: Color { get set }
    
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
    
    /// The color used for dividers and separator.
    var separator: Color { get set }
    
    /// The color used for outlines and stroke.
    var outline: Color { get set }
    
    /// The color used for representing disabled or inactive elements in the UI.
    /// 
    /// This color is typically applied to elements that are not currently interactive,
    /// such as switchs, checkbox, or radio buttons in a disabled state. It helps indicate to users
    /// that these elements cannot be interacted with.
    var onDisabled: Color { get set }
}
