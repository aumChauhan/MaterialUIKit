//
// Configuration.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 06/07/24
//

import SwiftUI

/// Configuration settings for MaterialUIKit.
public struct MUIKitConfiguration {
    
    /// The padding applied inside UI elements to separate content from borders.
    ///
    /// Defaults to `20`, providing ample space between content and edges of the element.
    public var contentPadding: CGFloat = 20
    
    /// The font style used for the extra large header (H-XL).
    ///
    /// Defaults to `.largeTitle`, which provides a prominent header style.
    public var hXL: Font = .largeTitle
    
    /// The font style used for the largest header (H1).
    ///
    /// Defaults to `.title`, which provides a prominent header style.
    public var h1: Font = .title
    
    /// The font style used for the second largest header (H2).
    ///
    /// Defaults to `.title2`, suitable for secondary headers.
    public var h2: Font = .title2
    
    /// The font style used for the third largest header (H3).
    ///
    /// Defaults to `.title3`, ideal for tertiary headers.
    public var h3: Font = .title3
    
    /// The font style used for medium-sized headers (H4).
    ///
    /// Defaults to `.body`, suitable for body text or less prominent headers.
    public var h4: Font = .body
    
    /// The font style used for smaller headers (H5).
    ///
    /// Defaults to `.subheadline`, which is typically used for subheadings.
    public var h5: Font = .subheadline
    
    /// The font style used for the smallest headers (H6).
    ///
    /// Defaults to `.caption`, suitable for small or minimal headings.
    public var h6: Font = .caption
    
    /// The horizontal padding applied to UI elements.
    ///
    /// Defaults to `16`, providing consistent spacing on the left and right sides.
    public var horizontalPadding: CGFloat = 16
    
    /// The horizontal padding applied to UI elements.
    ///
    /// Defaults to `16`, providing consistent spacing on the left and right sides.
    public var verticalPadding: CGFloat = 16
    
    /// The corner radius applied to UI elements.
    ///
    /// Defaults to `20`, giving elements a rounded appearance.
    public var cornerRadius: CGFloat = 20
    
    /// The vertical spacing applied between elements in a vertical layout.
    ///
    /// Defaults to `16`, ensuring consistent spacing between stacked elements.
    public var verticalStackSpacing: CGFloat = 16
    
    /// The horizontal spacing applied between elements in a horizontal layout.
    ///
    /// Defaults to `12`, providing consistent spacing between horizontally arranged elements.
    public var horizontalStackSpacing: CGFloat = 12
    
    /// The width of the border applied to UI elements.
    ///
    /// Defaults to `1.0`, giving elements a subtle border.
    public var borderWidth: CGFloat = 1.0
    
    /// The duration of animations applied to UI elements.
    ///
    /// Defaults to `0.4` seconds, controlling the speed of animations.
    public var animationDuration: Double = 0.3
    
    /// The type of animation applied to UI elements.
    ///
    /// Specifies the animation used for transitions and effects.
    public var animationType: Animation
    
    /// The intensity of haptic feedback for interactive elements.
    ///
    /// Defaults to `0.8`, providing a noticeable but not overwhelming feedback.
    public var hapticFeedbackIntensity: CGFloat = 0.8
    
    /// The color scheme applied to UI elements.
    ///
    /// Defaults to `MaterialClassic()`, providing a classic color theme.
    public var colorScheme: MUIColorScheme = MaterialClassic()
    
    /// Initializes a `MaterialUIKitConfiguration` instance with default values.
    public init() {
        animationType = .spring(duration: animationDuration)
    }
}
