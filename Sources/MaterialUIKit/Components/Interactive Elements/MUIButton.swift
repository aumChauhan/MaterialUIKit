//
// MUIButton.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - MUIButtonStyle

/// Enumeration representing different styles for the `MUIButton`.
@available(iOS 15.0, *)
public enum MUIButtonStyle {
    /// A button with an elevated background and rounded corners.
    case elevated
    
    /// A button with a filled background and rounded corners.
    case filled
    
    /// A button with a tonal background and rounded corners.
    case tonal
    
    /// A button with an outlined border and rounded corners.
    case outline
    
    /// A text-only button with no background.
    case text
    
    /// A button with elevated background and rounded corners, occupying full available width.
    case elevatedInfinity
    
    /// A button with a filled background and rounded corners, occupying full available width.
    case filledInfinity
    
    /// A button with a tonal background and rounded corners, occupying full available width.
    case tonalInfinity
    
    /// A button with an outlined border and rounded corners, occupying full available width.
    case outlineInfinity
}


// MARK: - MUIButtonTapStyle

/// A SwiftUI button style for animating the appearance of a button during clicks.
///  - Note : `MUIButtonTapStyle` is the default button style in `MUIButton`,  `MUIFloatingButton` & `MUIIconButton`.
@available(iOS 15.0, *)
public struct MUIButtonTapStyle: ButtonStyle {
    
    /// A SwiftUI button style for animating the appearance of a button during clicks.
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// MARK: - MUIButton

/// `MUIButton` is a versatile SwiftUI button with various styles to fit different design needs.
@available(iOS 15.0, *)
public struct MUIButton: View {
    
    // MARK: - Properties
    
    public let title: String
    public let style: MUIButtonStyle
    public let action: () -> Void
    
    
    // MARK: - Initializers
    
    /// Creates a MaterialButton with a default style.
    /// - Parameters:
    ///   - title: The text to display on the button.
    ///   - action: The closure to execute when the button is pressed.
    public init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.style = MUIButtonStyle.filled
        self.action = action
    }
    
    /// Creates a MaterialButton with a specific style.
    /// - Parameters:
    ///   - title: The text to display on the button.
    ///   - style: The style of the button.
    ///   - action:The closure to execute when the button is pressed.
    public init(_ title: String, style: MUIButtonStyle, action: @escaping () -> Void) {
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
            
        case .elevatedInfinity:
            elevatedInfinityButtonStyle()
            
        case .filledInfinity:
            filledInfinityButtonStyle()
            
        case .tonalInfinity:
            tonalInfinityButtonStyle()
            
        case .outlineInfinity:
            outlineInfinityButtonStyle()
        }
    }
}

// MARK: - Extension MUIButton (Dynamic Width)

@available(iOS 15.0, *)
extension MUIButton {
    /// A button with an elevated background and rounded corners.
    private func elevatedButtonStyle() -> some View {
        Button(action: action) {
            Text(title)
                .elevatedButtonStyle()
                .cornerRadius(100)
                .shadow(color: .black.opacity(0.15), radius: 1.5, x: 0, y: 1)
                .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
        }
        .buttonStyle(MUIButtonTapStyle())
    }
    
    /// A button with an filled background and rounded corners.
    private func filledButtonStyle() -> some View {
        return Button(action: action) {
            Text(title)
                .filledButtonStyle()
                .cornerRadius(100)
        }
        .buttonStyle(MUIButtonTapStyle())
    }
    
    /// A button with an tonal background and rounded corners.
    private func tonalButtonStyle() -> some View {
        return Button(action: action) {
            Text(title)
                .tonalButtonStyle()
                .cornerRadius(100)
        }
        .buttonStyle(MUIButtonTapStyle())
    }
    
    /// A button with an outlined border and rounded corners.
    private func outlineButtonStyle() -> some View {
        return Button(action: action) {
            Text(title)
                .outlineButtonStyle()
                
        }
        .buttonStyle(MUIButtonTapStyle())
    }
    
    /// A button with only text.
    private func textButtonStyle() -> some View {
        return Button(action: action) {
            Text(title)
                .foregroundColor(MaterialUI.tint.accent())
                .cornerRadius(100)
                .padding()
        }
        .buttonStyle(MUIButtonTapStyle())
    }
}

// MARK: - Extension MUIButton (Infinity Width)

@available(iOS 15.0, *)
extension MUIButton {
    /// A button with elevated background and rounded corners, occupying full available width.
    private func elevatedInfinityButtonStyle() -> some View {
        return Button(action: action) {
            Text(title)
                .elevatedInfinityButtonStyle()
                .cornerRadius(100)
                .shadow(color: .black.opacity(0.15), radius: 1.5, x: 0, y: 1)
                .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
        }
        .buttonStyle(MUIButtonTapStyle())
    }
    
    /// A button with filled background and rounded corners, occupying full available width.
    private func filledInfinityButtonStyle() -> some View {
        return Button(action: action) {
            Text(title)
                .filledInfinityButtonStyle()
                .cornerRadius(100)
        }
        .buttonStyle(MUIButtonTapStyle())
    }
    
    /// A button with tonal background and rounded corners, occupying full available width.
    private func tonalInfinityButtonStyle() -> some View {
        return Button(action: action) {
            Text(title)
                .tonalInfinityButtonStyle()
                .cornerRadius(100)
        }
        .buttonStyle(MUIButtonTapStyle())
    }
    
    /// A button with an outlined border and rounded corners, occupying full available width.
    private func outlineInfinityButtonStyle() -> some View {
        return Button(action: action) {
            Text(title)
                .outlineInfinityButtonStyle()
                .cornerRadius(100)
        }
        .buttonStyle(MUIButtonTapStyle())
    }
}


// MARK: - Extension View

@available(iOS 15.0, *)
extension View {
    
    /// `MaterialUI :` A button with an elevated background and rounded corners.
    public func elevatedButtonStyle() -> some View {
        return self
            .font(.headline)
            .fontWeightWithFallback(.medium)
            .foregroundColor(MaterialUI.tint.accentTitle())
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(MaterialUI.tint.tertiaryBackground())
            .cornerRadius(15)
            .shadow(color: .black.opacity(0.15), radius: 1.5, x: 0, y: 1)
            .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
    }
    
    /// `MaterialUI :` A button with a filled background and rounded corners.
    public func filledButtonStyle() -> some View {
        return self
            .font(.headline)
            .fontWeightWithFallback(.medium)
            .foregroundColor(MaterialUI.tint.iconColor())
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(MaterialUI.tint.accent())
            .cornerRadius(15)
    }
    
    /// `MaterialUI :` A button with a tonal background and rounded corners.
    public func tonalButtonStyle() -> some View {
        return self
            .font(.headline)
            .fontWeightWithFallback(.medium)
            .foregroundColor(MaterialUI.tint.accentTitle())
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(MaterialUI.tint.secondaryBackground())
            .cornerRadius(15)
    }
    
    /// `MaterialUI :` A button with a outline background and rounded corners.
    public func outlineButtonStyle() -> some View {
        return self
            .font(.headline)
            .fontWeightWithFallback(.medium)
            .foregroundColor(MaterialUI.tint.accentTitle())
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .overlay(
                RoundedRectangle(cornerRadius: 100)
                    .stroke(MaterialUI.tint.primaryTitle(), lineWidth: 1)
            )
    }
    
    /// `MaterialUI :`  A text-only button with no background.
    public func textButtonStyle(_ padding: CGFloat? = nil) -> some View {
        return self
            .font(.headline)
            .fontWeightWithFallback(.medium)
            .foregroundColor(MaterialUI.tint.accent())
            .padding(padding ?? 10)
    }
    
    // MARK: - Infinity Width...
    
    /// `MaterialUI:` A button with elevated background and rounded corners, occupying full available width.
    public func elevatedInfinityButtonStyle() -> some View {
        return self
            .font(.headline)
            .fontWeightWithFallback(.medium)
            .foregroundColor(MaterialUI.tint.accentTitle())
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .background(MaterialUI.tint.tertiaryBackground())
            .cornerRadius(15)
            .shadow(color: .black.opacity(0.15), radius: 1.5, x: 0, y: 1)
            .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
    }
    
    /// `MaterialUI:` A button with a filled background and rounded corners, occupying full available width.
    public func filledInfinityButtonStyle() -> some View {
        return self
            .font(.headline)
            .fontWeightWithFallback(.medium)
            .foregroundColor(MaterialUI.tint.iconColor())
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .background(MaterialUI.tint.accent())
            .cornerRadius(15)
    }
    
    /// `MaterialUI:` A button with a tonal background and rounded corners, occupying full available width.
    public func tonalInfinityButtonStyle() -> some View {
        return self
            .font(.headline)
            .fontWeightWithFallback(.medium)
            .foregroundColor(MaterialUI.tint.accentTitle())
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .background(MaterialUI.tint.secondaryBackground())
            .cornerRadius(15)
    }
    
    /// `MaterialUI:` A button with an outlined border and rounded corners, occupying full available width.
    public func outlineInfinityButtonStyle() -> some View {
        return self
            .font(.headline)
            .fontWeightWithFallback(.medium)
            .foregroundColor(MaterialUI.tint.accentTitle())
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 99)
                    .stroke(MaterialUI.tint.primaryTitle(), lineWidth: 1)
                    .frame(maxWidth: .infinity)
            )
    }
}
