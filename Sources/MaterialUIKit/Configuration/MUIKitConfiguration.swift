//
// Configuration.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 06/07/24
//

import SwiftUI

/// Configuration settings for MaterialUIKit.
///
/// The `MUIKitConfiguration` struct provides a centralized way to define and manage the configuration settings for the MaterialUIKit components.
/// This includes various design attributes such as padding, font styles, spacing, and color schemes, which are used to maintain a consistent and customizable look and feel across the UI components.
@available(iOS 15.0, *)
public struct MUIKitConfiguration {
    
    /// The padding applied inside UI elements to separate content from borders.
    ///
    /// Defaults to `20`.
    public var contentPadding: CGFloat
    
    /// The font style used for the extra large header (H-XL).
    ///
    /// Defaults to `.largeTitle`.
    public var hXL: Font
    
    /// The font style used for the largest header (H1).
    ///
    /// Defaults to `.title`.
    public var h1: Font
    
    /// The font style used for the second largest header (H2).
    ///
    /// Defaults to `.title2`.
    public var h2: Font
    
    /// The font style used for the third largest header (H3).
    ///
    /// Defaults to `.title3`.
    public var h3: Font
    
    /// The font style used for medium-sized headers (H4).
    ///
    /// Defaults to `.body`.
    public var h4: Font
    
    /// The font style used for smaller headers (H5).
    ///
    /// Defaults to `.subheadline`.
    public var h5: Font
    
    /// The font style used for the smallest headers (H6).
    ///
    /// Defaults to `.caption`.
    public var h6: Font
    
    /// The horizontal padding applied to UI elements.
    ///
    /// Defaults to `16`.
    public var horizontalPadding: CGFloat
    
    /// The horizontal padding applied to UI elements.
    ///
    /// Defaults to `16`.
    public var verticalPadding: CGFloat
    
    /// The corner radius applied to UI elements.
    ///
    /// Defaults to `20`.
    public var cornerRadius: CGFloat
    
    /// The vertical spacing applied between elements in a vertical layout.
    ///
    /// Defaults to `16`.
    public var verticalStackSpacing: CGFloat
    
    /// The horizontal spacing applied between elements in a horizontal layout.
    ///
    /// Defaults to `12`.
    public var horizontalStackSpacing: CGFloat
    
    /// The width of the border applied to UI elements.
    ///
    /// Defaults to `1.0.
    public var borderWidth: CGFloat
    
    /// The type of animation applied to UI elements.
    ///
    /// Defaults to `.spring()`.
    public var animationType: Animation
    
    /// The intensity of haptic feedback for interactive elements.
    ///
    /// Defaults to `0.8`.
    public var hapticFeedbackIntensity: CGFloat
    
    /// The intensity of haptic feedback for interactive elements.
    ///
    /// Defaults to `.light`.
    public var hapticFeedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle
    
    /// The color scheme applied to UI elements.
    ///
    /// Defaults to `MaterialClassic()`.
    public var colorScheme: ColorScheme
    
    /// Initializes a `MaterialUIKitConfiguration` instance with default values.
    public init() {
        self.contentPadding = 20
        self.hXL = .largeTitle
        self.h1 = .title
        self.h2 = .title2
        self.h3 = .title3
        self.h4 = .body
        self.h5 = .subheadline
        self.h6 = .caption
        self.horizontalPadding = 16
        self.verticalPadding = 16
        self.cornerRadius = 20
        self.verticalStackSpacing = 16
        self.horizontalStackSpacing = 12
        self.borderWidth = 1.0
        self.animationType = .spring(duration: 0.4)
        self.hapticFeedbackIntensity = 0.6
        self.hapticFeedbackStyle = .light
        self.colorScheme = MaterialClassic()
    }
    
    /// Initializes a `MUIKitConfiguration` instance with specified values for each property.
    public init(
        contentPadding: CGFloat,
        hXL: Font,
        h1: Font,
        h2: Font,
        h3: Font,
        h4: Font,
        h5: Font,
        h6: Font,
        horizontalPadding: CGFloat,
        verticalPadding: CGFloat,
        cornerRadius: CGFloat,
        verticalStackSpacing: CGFloat,
        horizontalStackSpacing: CGFloat,
        borderWidth: CGFloat,
        animationDuration: Double,
        animationType: Animation,
        hapticFeedbackIntensity: CGFloat,
        hapticFeedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle,
        colorScheme: ColorScheme
    ) {
        self.contentPadding = contentPadding
        self.hXL = hXL
        self.h1 = h1
        self.h2 = h2
        self.h3 = h3
        self.h4 = h4
        self.h5 = h5
        self.h6 = h6
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.cornerRadius = cornerRadius
        self.verticalStackSpacing = verticalStackSpacing
        self.horizontalStackSpacing = horizontalStackSpacing
        self.borderWidth = borderWidth
        self.animationType = animationType
        self.hapticFeedbackIntensity = hapticFeedbackIntensity
        self.hapticFeedbackStyle = hapticFeedbackStyle
        self.colorScheme = colorScheme
    }
}
