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
    func accent() -> Color
    
    /// The tonal color used for tonal variations.
    func tonal() -> Color
    
    /// The primary background color.
    func primaryBackground() -> Color
    
    /// The secondary background color.
    func secondaryBackground() -> Color
    
    /// The tertiary background color.
    func tertiaryBackground() -> Color
    
    /// The color used for highlighting elements.
    func highlight() -> Color
    
    /// The primary title color.
    func primaryTitle() -> Color
    
    /// The secondary title color.
    func secondaryTitle() -> Color
}
