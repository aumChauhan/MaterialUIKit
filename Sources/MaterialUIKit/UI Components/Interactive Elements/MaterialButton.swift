//
// MaterialButton.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

/// A MaterialUI styled button with various styles.
public struct MaterialButton: View {
    
    // MARK: - Properties
    
    private let title: String
    private let style: MaterialButtonStyle
    private let action: () -> Void
    
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
            elevatedInfinityButtonStyle()
            
        case .filledStretched:
            filledInfinityButtonStyle()
            
        case .tonalStretched:
            tonalInfinityButtonStyle()
            
        case .outlineStretched:
            outlineInfinityButtonStyle()
        }
    }
}

// MARK: - Extension MUIButton (Dynamic Width)

@available(iOS 15.0, *)
extension MaterialButton {
    /// A button with an elevated background and rounded corners.
    private func elevatedButtonStyle() -> some View {
        Button(action: action) {
            Text(title)
                .elevatedStyledBackground()
                .cornerRadius(100)
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
                .cornerRadius(100)
        }
        .buttonStyle(ShrinkFadeButtonStyle())
    }
    
    /// A button with an tonal background and rounded corners.
    private func tonalButtonStyle() -> some View {
        return Button(action: action) {
            Text(title)
                .tonalStyledBackground()
                .cornerRadius(100)
        }
        .buttonStyle(ShrinkFadeButtonStyle())
    }
    
    /// A button with an outlined border and rounded corners.
    private func outlineButtonStyle() -> some View {
        return Button(action: action) {
            Text(title)
                .outlineStyledBackground()
            
        }
        .buttonStyle(ShrinkFadeButtonStyle())
    }
    
    /// A button with only text.
    private func textButtonStyle() -> some View {
        return Button(action: action) {
            Text(title)
                .foregroundStyle(.materialAccent)
                .cornerRadius(100)
                .padding()
        }
        .buttonStyle(ShrinkFadeButtonStyle())
    }
    
    
    // MARK: - Extension MUIButton (Infinity Width)
    
    /// A button with elevated background and rounded corners, occupying full available width.
    private func elevatedInfinityButtonStyle() -> some View {
        return Button(action: action) {
            Text(title)
                .elevatedStretchedStyledBackground()
                .cornerRadius(100)
                .shadow(color: .black.opacity(0.15), radius: 1.5, x: 0, y: 1)
                .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
        }
        .buttonStyle(ShrinkFadeButtonStyle())
    }
    
    /// A button with filled background and rounded corners, occupying full available width.
    private func filledInfinityButtonStyle() -> some View {
        return Button(action: action) {
            Text(title)
                .filledStretchedStyledBackground()
                .cornerRadius(100)
        }
        .buttonStyle(ShrinkFadeButtonStyle())
    }
    
    /// A button with tonal background and rounded corners, occupying full available width.
    private func tonalInfinityButtonStyle() -> some View {
        return Button(action: action) {
            Text(title)
                .tonalStretchedStyledBackground()
                .cornerRadius(100)
        }
        .buttonStyle(ShrinkFadeButtonStyle())
    }
    
    /// A button with an outlined border and rounded corners, occupying full available width.
    private func outlineInfinityButtonStyle() -> some View {
        return Button(action: action) {
            Text(title)
                .outlineStretchedStyledBackground()
                .cornerRadius(100)
        }
        .buttonStyle(ShrinkFadeButtonStyle())
    }
}
