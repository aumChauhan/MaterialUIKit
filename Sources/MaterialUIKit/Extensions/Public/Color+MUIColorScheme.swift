//
// Color+MUIColorScheme.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 16/04/24
//

import SwiftUI

/// A set of custom color definitions tailored for MaterialUIKit styling.
public extension Color {
    /// The accent color based on the current color scheme setting.
    static let materialUIAccent: Color = MaterialUIKit.configuration.colorScheme.accent
    
    /// The accent tonal color shade based on the current color scheme setting.
    static var materialUITonal: Color = MaterialUIKit.configuration.colorScheme.tonal
    
    /// The primary background color based on the current color scheme setting.
    static var materialUIPrimaryBackground: Color = MaterialUIKit.configuration.colorScheme.primaryBackground
    
    /// The secondary background color based on the current color scheme setting.
    static var materialUISecondaryBackground: Color = MaterialUIKit.configuration.colorScheme.secondaryBackground
    
    /// The tertiary background color based on the current color scheme setting.
    static var materialUITertiaryBackground: Color = MaterialUIKit.configuration.colorScheme.tertiaryBackground
    
    /// The quaternary background color based on the current color scheme setting.
    static var materialUIQuaternaryBackground: Color = MaterialUIKit.configuration.colorScheme.quaternaryBackground
    
    /// The accent title color based on the current color scheme setting.
    static var materialUIHighlight: Color = MaterialUIKit.configuration.colorScheme.highlight
    
    /// The primary title color based on the current color scheme setting.
    static var materialUIPrimaryTitle: Color = MaterialUIKit.configuration.colorScheme.primaryTitle
    
    /// The secondary title color based on the current color scheme setting.
    static var materialUISecondaryTitle: Color = MaterialUIKit.configuration.colorScheme.secondaryTitle
    
    /// The color used for indicating errors and alerts.
    static var materialUIOnError: Color = MaterialUIKit.configuration.colorScheme.onError
    
    /// The separator color based on the current color scheme setting.
    static var materialUISeparator: Color = MaterialUIKit.configuration.colorScheme.separator
    
    /// The color used for indicating inactive or disabled state.
    static var materialUIOnDisabled: Color = MaterialUIKit.configuration.colorScheme.onDisabled
    
    /// The color used for outlines and stroke.
    static var materialUIOutline: Color = MaterialUIKit.configuration.colorScheme.outline
}
