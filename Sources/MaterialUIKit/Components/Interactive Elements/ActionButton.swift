//
// ActionButton.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - PUBLIC

/// Represents a Material UI styled button for performing actions with various visual styles.
@available(iOS 15.0, *)
public struct ActionButton: View {
    
    // MARK: - PROPERTIES
    
    private let titleKey: String
    private let style: ActionButtonStyle
    private let action: () -> Void
    
    @Environment(\.cornerRadius) private var cornerRadius: CGFloat
    @Environment(\.font) private var font: Font
    @Environment(\.fontWeight) private var fontWeight: Font.Weight
    
    // MARK: - INITIALIZERS
    
    /// Creates an action button with a default `.filled` style.
    ///
    /// - Parameters:
    ///   - titleKey: The text key to display on the button.
    ///   - action: The closure to execute when the button is pressed.
    public init(_ titleKey: String, action: @escaping () -> Void) {
        self.titleKey = titleKey
        self.style = ActionButtonStyle.filled
        self.action = action
    }
    
    /// Creates an action button with a specific style.
    ///
    /// - Parameters:
    ///   - titleKey: The text key to display on the button.
    ///   - style: The style of the button.
    ///   - action:The closure to execute when the button is pressed.
    public init(_ titleKey: String, style: ActionButtonStyle, action: @escaping () -> Void) {
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
    
    /// Sets the corner radius for an action buttons.
    ///
    /// - Parameter cornerRadius: The corner radius value to apply.
    public func actionButtonCornerRadius(_ cornerRadius: CGFloat) -> some View {
        self.environment(\.cornerRadius, cornerRadius)
    }
    
    /// Sets the font size for an action buttons.
    ///
    /// - Parameter font: The font size to apply.
    public func actionButtonFontStyle(_ font: Font) -> some View {
        self.environment(\.font, font)
    }
    
    /// Sets the font weight for an action buttons.
    ///
    /// - Parameter fontWeight: The font weight to apply.
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
        .buttonStyle(ActionButtonAnimationStyle())
    }
    
    /// A button with an filled background and rounded corners.
    func filledButtonStyle() -> some View {
        return Button(action: action) {
            Text(titleKey)
                .filledStyledBackground()
                .materialActionButtonStyle(font: font, fontWeight: fontWeight, cornerRadius: cornerRadius)
        }
        .buttonStyle(ActionButtonAnimationStyle())
    }
    
    /// A button with an tonal background and rounded corners.
    func tonalButtonStyle() -> some View {
        return Button(action: action) {
            Text(titleKey)
                .tonalStyledBackground()
                .materialActionButtonStyle(font: font, fontWeight: fontWeight, cornerRadius: cornerRadius)
        }
        .buttonStyle(ActionButtonAnimationStyle())
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
        .buttonStyle(ActionButtonAnimationStyle())
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
        .buttonStyle(ActionButtonAnimationStyle())
    }
    
    /// A button with filled background and rounded corners, occupying maximum available width.
    func filledStretchedButtonStyle() -> some View {
        return Button(action: action) {
            Text(titleKey)
                .filledStretchedStyledBackground()
                .materialActionButtonStyle(font: font, fontWeight: fontWeight, cornerRadius: cornerRadius)
        }
        .buttonStyle(ActionButtonAnimationStyle())
    }
    
    /// A button with tonal background and rounded corners, occupying maximum available width.
    func tonalStretchedButtonStyle() -> some View {
        return Button(action: action) {
            Text(titleKey)
                .tonalStretchedStyledBackground()
                .materialActionButtonStyle(font: font, fontWeight: fontWeight, cornerRadius: cornerRadius)
        }
        .buttonStyle(ActionButtonAnimationStyle())
    }
    
    /// A button with an outlined border and rounded corners, occupying maximum available width.
    func outlineStretchedButtonStyle() -> some View {
        return Button(action: action) {
            Text(titleKey)
                .outlineStretchedStyledBackground(cornerRadius: cornerRadius)
                .materialActionButtonStyle(font: font, fontWeight: fontWeight, cornerRadius: cornerRadius)
        }
        .buttonStyle(ActionButtonAnimationStyle())
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
