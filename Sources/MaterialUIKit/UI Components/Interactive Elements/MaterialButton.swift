//
// MaterialButton.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

/// A Material UI style button with various styles.
public struct MaterialButton: View {
    
    // MARK: - Properties
    
    private let title: String
    private let style: MaterialButtonStyle
    private let action: () -> Void
    @Environment(\.cornerRadius) private var cornerRadius: CGFloat
    @Environment(\.font) private var font: Font
    @Environment(\.fontWeight) private var fontWeight: Font.Weight
    
    // MARK: - Initializers
    
    /// Creates a button with a default style.
    ///
    /// - Parameters:
    ///   - title: The text to display on the button.
    ///   - action: The closure to execute when the button is pressed.
    public init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.style = MaterialButtonStyle.filled
        self.action = action
    }
    
    /// Creates a button with a specific style.
    ///
    /// - Parameters:
    ///   - title: The text to display on the button.
    ///   - style: The style of the button.
    ///   - action:The closure to execute when the button is pressed.
    public init(_ title: String, style: MaterialButtonStyle, action: @escaping () -> Void) {
        self.title = title
        self.style = style
        self.action = action
    }
    
    // MARK: - View Body
    
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
    
    /// A button with an elevated background and rounded corners.
    private func elevatedButtonStyle() -> some View {
        Button(action: action) {
            Text(title)
                .elevatedStyledBackground()
                .materialButtonStyle(font: font, fontWeight: fontWeight, cornerRadius: cornerRadius)
                .shadow(color: .black.opacity(0.15), radius: 1.5, x: 0, y: 1)
                .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
        }
        .buttonStyle(ShrinkFadeButtonStyle())
    }
    
    /// A button with an filled background and rounded corners.
    private func filledButtonStyle() -> some View {
        return Button(action: action) {
            Text(title)
                .filledStyledBackground()
                .materialButtonStyle(font: font, fontWeight: fontWeight, cornerRadius: cornerRadius)
        }
        .buttonStyle(ShrinkFadeButtonStyle())
    }
    
    /// A button with an tonal background and rounded corners.
    private func tonalButtonStyle() -> some View {
        return Button(action: action) {
            Text(title)
                .tonalStyledBackground()
                .materialButtonStyle(font: font, fontWeight: fontWeight, cornerRadius: cornerRadius)
        }
        .buttonStyle(ShrinkFadeButtonStyle())
    }
    
    /// A button with an outlined border and rounded corners.
    private func outlineButtonStyle() -> some View {
        return Button(action: action) {
            Text(title)
                .outlineStyledBackground(cornerRadius: cornerRadius)
                .materialButtonStyle(font: font, fontWeight: fontWeight, cornerRadius: cornerRadius)
        }
        .buttonStyle(ShrinkFadeButtonStyle())
    }
    
    /// A button with only text.
    private func textButtonStyle() -> some View {
        return Button(action: action) {
            Text(title)
                .foregroundStyle(.materialAccent)
                .materialButtonStyle(font: font, fontWeight: fontWeight, cornerRadius: cornerRadius)
                .padding()
        }
        .buttonStyle(ShrinkFadeButtonStyle())
    }
    
    /// A button with elevated background and rounded corners, occupying maximum available width.
    private func elevatedStretchedButtonStyle() -> some View {
        return Button(action: action) {
            Text(title)
                .elevatedStretchedStyledBackground()
                .materialButtonStyle(font: font, fontWeight: fontWeight, cornerRadius: cornerRadius)
                .shadow(color: .black.opacity(0.15), radius: 1.5, x: 0, y: 1)
                .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
        }
        .buttonStyle(ShrinkFadeButtonStyle())
    }
    
    /// A button with filled background and rounded corners, occupying maximum available width.
    private func filledStretchedButtonStyle() -> some View {
        return Button(action: action) {
            Text(title)
                .filledStretchedStyledBackground()
                .materialButtonStyle(font: font, fontWeight: fontWeight, cornerRadius: cornerRadius)
        }
        .buttonStyle(ShrinkFadeButtonStyle())
    }
    
    /// A button with tonal background and rounded corners, occupying maximum available width.
    private func tonalStretchedButtonStyle() -> some View {
        return Button(action: action) {
            Text(title)
                .tonalStretchedStyledBackground()
                .materialButtonStyle(font: font, fontWeight: fontWeight, cornerRadius: cornerRadius)
        }
        .buttonStyle(ShrinkFadeButtonStyle())
    }
    
    /// A button with an outlined border and rounded corners, occupying maximum available width.
    private func outlineStretchedButtonStyle() -> some View {
        return Button(action: action) {
            Text(title)
                .outlineStretchedStyledBackground(cornerRadius: cornerRadius)
                .materialButtonStyle(font: font, fontWeight: fontWeight, cornerRadius: cornerRadius)
        }
        .buttonStyle(ShrinkFadeButtonStyle())
    }
}

fileprivate extension View {
    /// Applies a specific font, font weight, and corner radius to the view's environment.
    func materialButtonStyle(font: Font, fontWeight: Font.Weight, cornerRadius: CGFloat) -> some View {
        self
            .font(font)
            .fontWeightWithFallback(fontWeight)
            .cornerRadius(cornerRadius)
    }
}

// MARK: - Environment Keys

/// Environment key for setting the corner radius.
fileprivate struct CornerRadiusKey: EnvironmentKey {
    static var defaultValue: CGFloat = 16
}

/// Environment key for setting the font.
fileprivate struct FontKey: EnvironmentKey {
    static var defaultValue: Font = .headline
}

/// Environment key for setting the font weight.
fileprivate struct FontWeightKey: EnvironmentKey {
    static var defaultValue: Font.Weight = .medium
}

fileprivate extension EnvironmentValues {
    var cornerRadius: CGFloat {
        get { self[CornerRadiusKey.self] }
        set { self[CornerRadiusKey.self] = newValue }
    }
    
    var font: Font {
        get { self[FontKey.self] }
        set { self[FontKey.self] = newValue }
    }
    
    var fontWeight: Font.Weight {
        get { self[FontWeightKey.self] }
        set { self[FontWeightKey.self] = newValue }
    }
}

// MARK: - Extension View

extension View {
    
    /// Sets the corner radius for Material Buttons within the environment.
    ///
    /// - Parameter radius: The corner radius value to apply.
    ///
    /// - Returns: A modified view environment with the specified corner radius applied.
    public func materialButtonCornerRadius(_ radius: CGFloat) -> some View {
        self.environment(\.cornerRadius, radius)
    }
    
    /// Sets the font size for Material Buttons within the environment.
    ///
    /// - Parameter font: The font size to apply.
    ///
    /// - Returns: A modified view environment with the specified font size applied.
    public func materialButtonFontStyle(_ font: Font) -> some View {
        self.environment(\.font, font)
    }
    
    /// Sets the font weight for Material Buttons within the environment.
    ///
    /// - Parameter fontWeight: The font weight to apply.
    ///
    /// - Returns: A modified view environment with the specified font weight applied.
    public func materialButtonFontWeight(_ fontWeight: Font.Weight) -> some View {
        self.environment(\.fontWeight, fontWeight)
    }
}
