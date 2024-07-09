//
// MaterialIconButton.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - MUIIconButton

/// A Material UI styled circular icon button.
public struct MaterialCircularButton: View {
    
    // MARK: - Properties
    
    private let systemSymbol: String?
    private let image: String?
    private let style: MaterialCircularButtonStyle
    private let action: () -> ()
    
    // MARK: - Initializers
    
    /// Creates a circular button with a system symbol, style, and action.
    ///
    /// - Parameters:
    ///  - systemSymbol: SF Symbol string for system-provided icons.
    ///  - style: The style of the button, defined by `MUIIconButtonStyle`.
    ///  - action: The closure to execute when the button is pressed.
    public init(
        systemSymbol: String,
        style: MaterialCircularButtonStyle,
        _ action: @escaping () -> Void
    ) {
        self.systemSymbol = systemSymbol
        self.style = style
        self.action = action
        self.image = nil
    }
    
    /// Creates a circular button with a custom image, style, and action.
    ///
    /// - Parameters:
    ///   - image: String representing the name of a custom image.
    ///   - style: The style of the button, defined by `MUIIconButtonStyle`.
    ///   - action: The closure to execute when the button is pressed.
    public init(
        _ image: String,
        style: MaterialCircularButtonStyle,
        _ action: @escaping () -> Void
    ) {
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
    
    // MARK: - Helpers
    
    /// An icon from SFSymbol or bundle image.
    private func icon() -> some View {
        VStack {
            if let systemSymbol = systemSymbol {
                Image(systemName: systemSymbol)
                
            } else if let image = image {
                Image(image)
                    .resizable()
                    .renderingMode(.template)
            } else {
                EmptyView()
            }
        }
        .fontWeightWithFallback(.semibold)
        .frame(minWidth: 25)
        .frame(height: 30)
    }
    
    /// A circular button with a elevated background.
    private func elevatedIconStyle() -> some View {
        Button(action: action) {
            icon()
                .elevatedStyledBackground()
                .frame(width: 45, height: 45)
                .cornerRadius(50)
                .padding(1)
                .shadow(color: .black.opacity(0.15), radius: 1.5, x: 0, y: 1)
                .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
        }
        .buttonStyle(ShrinkFadeButtonStyle())
    }
    
    /// A circular button with a filled background.
    private func filledIconStyle() -> some View {
        Button(action: action) {
            icon()
                .filledStyledBackground()
                .frame(width: 45, height: 45)
                .cornerRadius(50)
        }
        .buttonStyle(ShrinkFadeButtonStyle())
    }
    
    /// A circular button with a tonal background.
    private func tonalIconStyle() -> some View {
        Button(action: action) {
            icon()
                .tonalStyledBackground()
                .frame(width: 45, height: 45)
                .cornerRadius(50)
        }
        .buttonStyle(ShrinkFadeButtonStyle())
    }
    
    /// A circular button with a secondary background.
    private func secondaryIconStyle() -> some View {
        Button(action: action) {
            icon()
                .fontWeightWithFallback(.medium)
                .foregroundStyle(.materialAccent)
                .padding(.vertical, 15)
                .padding(.horizontal, 20)
                .background(.materialSecondaryBackground)
                .frame(width: 45, height: 45)
                .cornerRadius(50)
        }
        .buttonStyle(ShrinkFadeButtonStyle())
    }
}
