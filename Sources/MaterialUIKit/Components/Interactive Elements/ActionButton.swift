//
// ActionButton.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - PUBLIC

/// A Material UI style action button with various styles.
public struct ActionButton: View {
    
    // MARK: - PROPERTIES
    
    private let titleKey: String
    private let style: MUIActionButtonStyle
    private let action: () -> Void
    @Environment(\.cornerRadius) private var cornerRadius: CGFloat
    @Environment(\.font) private var font: Font
    @Environment(\.fontWeight) private var fontWeight: Font.Weight
    
    // MARK: - INITIALIZERS
    
    /// Creates a button with a default style.
    ///
    /// - Parameters:
    ///   - titleKey: The text key to display on the button.
    ///   - action: The closure to execute when the button is pressed.
    public init(_ titleKey: String, action: @escaping () -> Void) {
        self.titleKey = titleKey
        self.style = MUIActionButtonStyle.filled
        self.action = action
    }
    
    /// Creates a button with a specific style.
    ///
    /// - Parameters:
    ///   - titleKey: The text key to display on the button.
    ///   - style: The style of the button.
    ///   - action:The closure to execute when the button is pressed.
    public init(_ titleKey: String, style: MUIActionButtonStyle, action: @escaping () -> Void) {
        self.titleKey = titleKey
        self.style = style
        self.action = action
    }
    
    // MARK: - VIEW BODY
    
    public var body: some View {
        switch style {
        case .elevated:
            elevatedButtonStyle()
            
        case .filled:
            filledButtonStyle()
            
        case .tonal:
            tonalButtonStyle()
            
        case .outline:
            outlineButtonStyle()
            
        case .text:
            textButtonStyle()
            
        case .elevatedStretched:
            elevatedStretchedButtonStyle()
            
        case .filledStretched:
            filledStretchedButtonStyle()
            
        case .tonalStretched:
            tonalStretchedButtonStyle()
            
        case .outlineStretched:
            outlineStretchedButtonStyle()
        }
    }
}

extension View {
    
    /// Sets the corner radius for Material action buttons within the environment.
    ///
    /// - Parameter radius: The corner radius value to apply.
    ///
    /// - Returns: A modified view environment with the specified corner radius applied.
    public func actionButtonCornerRadius(_ radius: CGFloat) -> some View {
        self.environment(\.cornerRadius, radius)
    }
    
    /// Sets the font size for Material action buttons within the environment.
    ///
    /// - Parameter font: The font size to apply.
    ///
    /// - Returns: A modified view environment with the specified font size applied.
    public func actionButtonFontStyle(_ font: Font) -> some View {
        self.environment(\.font, font)
    }
    
    /// Sets the font weight for Material action buttons within the environment.
    ///
    /// - Parameter fontWeight: The font weight to apply.
    ///
    /// - Returns: A modified view environment with the specified font weight applied.
    public func actionButtonFontWeight(_ fontWeight: Font.Weight) -> some View {
        self.environment(\.fontWeight, fontWeight)
    }
}

// MARK: - FILE PRIVATE

fileprivate extension ActionButton {
    
    /// A button with an elevated background and rounded corners.
    func elevatedButtonStyle() -> some View {
        Button(action: action) {
            Text(titleKey)
                .elevatedStyledBackground()
                .materialActionButtonStyle(font: font, fontWeight: fontWeight, cornerRadius: cornerRadius)
                .shadow(color: .black.opacity(0.15), radius: 1.5, x: 0, y: 1)
                .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
        }
        .buttonStyle(MUIActionButtonAnimationStyle())
    }
    
    /// A button with an filled background and rounded corners.
    func filledButtonStyle() -> some View {
        return Button(action: action) {
            Text(titleKey)
                .filledStyledBackground()
                .materialActionButtonStyle(font: font, fontWeight: fontWeight, cornerRadius: cornerRadius)
        }
        .buttonStyle(MUIActionButtonAnimationStyle())
    }
    
    /// A button with an tonal background and rounded corners.
    func tonalButtonStyle() -> some View {
        return Button(action: action) {
            Text(titleKey)
                .tonalStyledBackground()
                .materialActionButtonStyle(font: font, fontWeight: fontWeight, cornerRadius: cornerRadius)
        }
        .buttonStyle(MUIActionButtonAnimationStyle())
    }
    
    /// A button with an outlined border and rounded corners.
    func outlineButtonStyle() -> some View {
        return Button(action: action) {
            Text(titleKey)
                .outlineStyledBackground(cornerRadius: cornerRadius)
                .materialActionButtonStyle(font: font, fontWeight: fontWeight, cornerRadius: cornerRadius)
        }
    }
    
    /// A button with only text.
    func textButtonStyle() -> some View {
        return Button(action: action) {
            Text(titleKey)
                .foregroundStyle(.materialUIAccent)
                .materialActionButtonStyle(font: font, fontWeight: fontWeight, cornerRadius: cornerRadius)
        }
        .buttonStyle(MUIActionButtonAnimationStyle())
    }
    
    /// A button with elevated background and rounded corners, occupying maximum available width.
    func elevatedStretchedButtonStyle() -> some View {
        return Button(action: action) {
            Text(titleKey)
                .elevatedStretchedStyledBackground()
                .materialActionButtonStyle(font: font, fontWeight: fontWeight, cornerRadius: cornerRadius)
                .shadow(color: .black.opacity(0.15), radius: 1.5, x: 0, y: 1)
                .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
        }
        .buttonStyle(MUIActionButtonAnimationStyle())
    }
    
    /// A button with filled background and rounded corners, occupying maximum available width.
    func filledStretchedButtonStyle() -> some View {
        return Button(action: action) {
            Text(titleKey)
                .filledStretchedStyledBackground()
                .materialActionButtonStyle(font: font, fontWeight: fontWeight, cornerRadius: cornerRadius)
        }
        .buttonStyle(MUIActionButtonAnimationStyle())
    }
    
    /// A button with tonal background and rounded corners, occupying maximum available width.
    func tonalStretchedButtonStyle() -> some View {
        return Button(action: action) {
            Text(titleKey)
                .tonalStretchedStyledBackground()
                .materialActionButtonStyle(font: font, fontWeight: fontWeight, cornerRadius: cornerRadius)
        }
        .buttonStyle(MUIActionButtonAnimationStyle())
    }
    
    /// A button with an outlined border and rounded corners, occupying maximum available width.
    func outlineStretchedButtonStyle() -> some View {
        return Button(action: action) {
            Text(titleKey)
                .outlineStretchedStyledBackground(cornerRadius: cornerRadius)
                .materialActionButtonStyle(font: font, fontWeight: fontWeight, cornerRadius: cornerRadius)
        }
        .buttonStyle(MUIActionButtonAnimationStyle())
    }
}

fileprivate extension View {
    
    /// Applies a specific font, font weight, and corner radius to the view's environment.
    func materialActionButtonStyle(font: Font, fontWeight: Font.Weight, cornerRadius: CGFloat) -> some View {
        self
            .font(font)
            .fontWeightWithFallback(fontWeight)
            .cornerRadius(cornerRadius)
    }
}


