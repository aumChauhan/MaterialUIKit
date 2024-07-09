//
// Configuration.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 06/07/24
//

import Foundation
import SwiftUI

public struct MaterialUIKitConfiguration {
    /// The margin around views.
    public var margin: CGFloat = 20
        
    /// The default horizontal padding applied to views.
    public var horizontalPadding: CGFloat = 12
    
    /// The default vertical padding applied to views.
    public var verticalPadding: CGFloat = 16
    
    /// The corner radius applied to rounded UI elements.
    public var cornerRadius: CGFloat = 24
    
    /// The spacing between elements in a stack layout.
    public var stackSpacing: CGFloat = 20
    
    /// The width of the border applied to bordered elements.
    public var borderWidth: CGFloat = 0.8
    
    /// The color of the border applied to bordered elements.
    public var borderColor: Color = Color.gray
    
    /// The duration of animations.
    public var animationDuration: Double = 0.4
    
    /// The type of animation curve.
    public var animationType: Animation
    
    /// The haptic feedback style.
    public var hapticFeedbackIntensity: CGFloat = 0.5
    
    /// The color scheme applied to the UI.
    public var colorScheme: MaterialColorScheme = DefaultColorScheme()
    
    /// Initializes a `MaterialUIKitConfiguration` instance with default values.
    public init() {
        animationType = .bouncy(duration: animationDuration)
    }
}
