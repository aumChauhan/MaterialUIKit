//
// Configuration.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 06/07/24
//

import SwiftUI

/// Configuration settings for MaterialUIKit.
public struct MaterialUIKitConfiguration {
    /// The margin around views.
    public var margin: CGFloat = 16
    
    /// The content padding within views.
    public var contentPadding: CGFloat = 16
        
    /// The default horizontal padding applied to views.
    public var horizontalPadding: CGFloat = 16
    
    /// The default vertical padding applied to views.
    public var verticalPadding: CGFloat = 16
    
    /// The corner radius applied to rounded UI elements.
    public var cornerRadius: CGFloat = 20
    
    /// The spacing between elements in a stack layout.
    @available(*, deprecated, message: "Use instead `verticalStackSpacing` & `horizontalStackSpacing`")
    public var stackSpacing: CGFloat = 20
    
    /// The spacing between elements in a vetical stack layout.
    public var verticalStackSpacing: CGFloat = 16
    
    /// The spacing between elements in a horizontal stack layout.
    public var horizontalStackSpacing: CGFloat = 12
    
    /// The width of the border applied to bordered elements.
    public var borderWidth: CGFloat = 1.0
    
    /// The duration of animations.
    public var animationDuration: Double = 0.4
    
    /// The type of animation curve.
    public var animationType: Animation
    
    /// The haptic feedback style.
    public var hapticFeedbackIntensity: CGFloat = 0.8
    
    /// The color scheme applied to the UI.
    public var colorScheme: MaterialColorScheme = MaterialClassic()
    
    /// Initializes a `MaterialUIKitConfiguration` instance with default values.
    public init() {
        animationType = .easeInOut(duration: animationDuration)
    }
}
