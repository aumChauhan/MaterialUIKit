//
// IconButton.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - PUBLIC

/// A Material UI style circular icon button.
public struct IconButton: View {
    
    // MARK: - PROPERTIES
    
    private let systemSymbol: String?
    private let image: String?
    private let style: MUIIconButtonStyle
    private let action: () -> ()
    
    @Environment(\.frameSize) private var frameSize: CGFloat
    @Environment(\.font) private var fontSize: Font
    
    // MARK: - INITIALIZERS
    
    /// Creates a circular icon button with a system symbol, style, and action.
    ///
    /// - Parameters:
    ///  - systemSymbol: SF Symbol string for system-provided icons.
    ///  - style: The style of the button, defined by `MUIIconButtonStyle`.
    ///  - action: The closure to execute when the button is pressed.
    public init(
        systemSymbol: String,
        style: MUIIconButtonStyle,
        _ action: @escaping () -> Void
    ) {
        self.systemSymbol = systemSymbol
        self.style = style
        self.action = action
        self.image = nil
    }
    
    /// Creates a circular icon  button with a custom image, style, and action.
    ///
    /// - Parameters:
    ///   - image: String representing the name of a custom image.
    ///   - style: The style of the button, defined by `MUIIconButtonStyle`.
    ///   - action: The closure to execute when the button is pressed.
    public init(
        _ image: String,
        style: MUIIconButtonStyle,
        _ action: @escaping () -> Void
    ) {
        self.style = style
        self.action = action
        self.image = image
        self.systemSymbol = nil
    }
    
    // MARK: - VIEW BODY
    
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

extension View {
    
    /// Sets the corner radius for Material icon button  within the environment.
    ///
    /// - Parameter radius: The corner radius value to apply.
    ///
    /// - Returns: A modified view environment with the specified corner radius applied.
    public func iconButtonSize(_ frameSize: CGFloat) -> some View {
        self.environment(\.frameSize, frameSize)
    }
    
    /// Sets the font weight for Material icon button within the environment.
    ///
    /// - Parameter fontWeight: The font weight to apply.
    ///
    /// - Returns: A modified view environment with the specified font weight applied.
    public func iconButtonFontSize(_ fontSize: Font) -> some View {
        self.environment(\.font, fontSize)
    }
}

// MARK: - FILE PRIVATE

fileprivate extension IconButton {
    /// An icon from SFSymbol or bundle image.
    func icon() -> some View {
        VStack {
            if let systemSymbol = systemSymbol {
                Image(systemName: systemSymbol)
                    .font(fontSize)
            } else if let image = image {
                Image(image)
                    .resizable()
                    .renderingMode(.template)
                    .font(fontSize)
            }
        }
        .fontWeightWithFallback(.semibold)
    }
    
    /// A circular icon  button with a elevated background.
    func elevatedIconStyle() -> some View {
        Button(action: action) {
            icon()
                .frame(width: frameSize, height: frameSize)
                .elevatedStyledBackground()
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.15), radius: 1.5, x: 0, y: 1)
                .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
        }
        .buttonStyle(MUIActionButtonAnimationStyle())
    }
    
    /// A circular button with a filled background.
    func filledIconStyle() -> some View {
        Button(action: action) {
            icon()
                .frame(width: frameSize, height: frameSize)
                .filledStyledBackground()
                .clipShape(Circle())
        }
        .buttonStyle(MUIActionButtonAnimationStyle())
    }
    
    /// A circular button with a tonal background.
    func tonalIconStyle() -> some View {
        Button(action: action) {
            icon()
                .frame(width: frameSize, height: frameSize)
                .tonalStyledBackground()
                .clipShape(Circle())
        }
        .buttonStyle(MUIActionButtonAnimationStyle())
    }
    
    /// A circular button with a secondary background.
    func secondaryIconStyle() -> some View {
        Button(action: action) {
            icon()
                .foregroundStyle(.materialUIAccent)
                .frame(width: frameSize, height: frameSize)
                .contentPadding()
                .background(.materialUISecondaryBackground)
                .clipShape(Circle())
        }
        .buttonStyle(MUIActionButtonAnimationStyle())
    }
}
