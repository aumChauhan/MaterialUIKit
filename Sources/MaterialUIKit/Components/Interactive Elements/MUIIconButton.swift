//
// MUIIconButton.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - MUIIconButtonStyle

/// Enumeration representing different styles for the `MUIIconButtonStyle`.
@available(iOS 17.0, *)
public enum MUIIconButtonStyle {
    /// A circular button with an secondary background.
    case secondary
    
    /// A circular button with an elevated background.
    case elevated
    
    /// A circular button with a filled background.
    case filled
    
    /// A circular  button with a tonal background.
    case tonal
}

// MARK: - MUIIconButton

/// `MUIIconButton` is a  SwiftUI icon button with various styles to fit different design needs.
@available(iOS 17.0, *)
public struct MUIIconButton: View {
    
    // MARK: - Properties
    
    public let systemSymbol: String?
    public let image: String?
    public let style: MUIIconButtonStyle
    public let action: () -> ()
    
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - Initializers
    
    /// Creates an icon button with a system symbol, style, and action.
    ///
    ///  - Parameters:
    /// - `systemSymbol`: SF Symbol string for system-provided icons.
    /// - `style`: The style of the button, defined by `MUIIconButtonStyle`.
    /// - `action`: The closure to execute when the button is pressed.
    public init(systemSymbol: String, style: MUIIconButtonStyle, _ action: @escaping () -> Void) {
        self.systemSymbol = systemSymbol
        self.style = style
        self.action = action
        self.image = nil
    }
    
    /// Creates an icon button with a custom image, style, and action.
    ///
    ///  - Parameters:
    /// - `image`: String representing the name of a custom image.
    /// - `style`: The style of the button, defined by `MUIIconButtonStyle`.
    /// - `action`: The closure to execute when the button is pressed.
    public init(_ image: String, style: MUIIconButtonStyle, _ action: @escaping () -> Void) {
        self.style = style
        self.action = action
        self.image = image
        self.systemSymbol = nil
    }
    
    // MARK: - View Body
    
    public var body: some View {
        switch style {
        case .elevated:
            elevatedIconStyle()
            
        case .filled:
            filledIconStyle()
            
        case .tonal:
            tonalIconStyle()
            
        case .secondary:
            secondaryIconStyle()
        }
    }
}

// MARK: - Extension MUIIconButton

@available(iOS 17.0, *)
extension MUIIconButton {
    
    /// An icon from SFSymbol or bundle image.
    private func icon() -> some View {
        VStack {
            if let systemSymbol = systemSymbol { // System symbol
                Image(systemName: systemSymbol)
                
            } else if let image = image { // Image (asset)
                Image(image)
                    .resizable()
                    .renderingMode(.template)
            } else {
                EmptyView()
            }
        }
        .fontWeight(.semibold)
        .frame(minWidth: 25)
        .frame(height: 30)
    }
    
    /// A circular button with a elevated background.
    private func elevatedIconStyle() -> some View {
        Button(action: action) {
            icon()
                .elevatedButtonStyle(colorScheme)
                .frame(width: 45, height: 45)
                .cornerRadius(50)
                .padding(1)
                .shadow(color: .black.opacity(0.15), radius: 1.5, x: 0, y: 1)
                .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
        }
        .buttonStyle(MUIButtonTapStyle())
    }
    
    /// A circular button with a filled background.
    private func filledIconStyle() -> some View {
        Button(action: action) {
            icon()
                .filledButtonStyle(colorScheme)
                .frame(width: 45, height: 45)
                .cornerRadius(50)
        }
        .buttonStyle(MUIButtonTapStyle())
    }
    
    /// A circular button with a tonal background.
    private func tonalIconStyle() -> some View {
        Button(action: action) {
            icon()
                .tonalButtonStyle(colorScheme)
                .frame(width: 45, height: 45)
                .cornerRadius(50)
        }
        .buttonStyle(MUIButtonTapStyle())
    }
    
    /// A circular button with a secondary background.
    private func secondaryIconStyle() -> some View {
        Button(action: action) {
            icon()
                .fontWeight(.medium)
                .foregroundColor(MaterialUI.tint.accent(colorScheme))
                .padding(.vertical, 15)
                .padding(.horizontal, 20)
                .background(MaterialUI.tint.secondaryBackground(colorScheme))
                .frame(width: 45, height: 45)
                .cornerRadius(50)
        }
        .buttonStyle(MUIButtonTapStyle())
    }
}
