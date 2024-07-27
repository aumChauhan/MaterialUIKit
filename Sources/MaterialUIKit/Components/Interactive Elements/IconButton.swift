//
// IconButton.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - PUBLIC

/// Represents a Material UI styled icon button for user interaction.
@available(iOS 15.0, *)
public struct IconButton: View {
    
    // MARK: - PROPERTIES
    
    private let systemImage: String?
    private let imageName: String?
    private let style: IconButtonStyle
    private let action: () -> ()
    
    @Environment(\.frameSize) private var frameSize: CGFloat
    @Environment(\.font) private var fontSize: Font
    
    // MARK: - INITIALIZERS
    
    /// Creates a circular icon button with a system symbol, style, and action.
    ///
    /// - Parameters:
    ///  - systemImage: SF Symbol string for system-provided icons.
    ///  - style: The style of the button, defined by `IconButtonStyle`.
    ///  - action: The closure to execute when the button is pressed.
    public init(
        systemImage: String,
        style: IconButtonStyle,
        _ action: @escaping () -> Void
    ) {
        self.systemImage = systemImage
        self.style = style
        self.action = action
        self.imageName = nil
    }
    
    /// Creates a circular icon button with a custom image, style, and action.
    ///
    /// - Parameters:
    ///   - imageName: String representing the name of a custom image.
    ///   - style: The style of the button, defined by `IconButtonStyle`.
    ///   - action: The closure to execute when the button is pressed.
    public init(
        imageName: String,
        style: IconButtonStyle,
        _ action: @escaping () -> Void
    ) {
        self.style = style
        self.action = action
        self.imageName = imageName
        self.systemImage = nil
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
        }
    }
}

extension View {
    
    /// Sets the corner radius for the icon button.
    ///
    /// - Parameter radius: The corner radius value to apply.
    public func iconButtonSize(_ frameSize: CGFloat) -> some View {
        self.environment(\.frameSize, frameSize)
    }
    
    /// Sets the font weight for the icon button.
    ///
    /// - Parameter fontWeight: The font weight to apply.
    public func iconButtonFontSize(_ fontSize: Font) -> some View {
        self.environment(\.font, fontSize)
    }
}

// MARK: - FILE PRIVATE

fileprivate extension IconButton {
    /// An icon from SFSymbol or bundle image.
    func icon() -> some View {
        VStack {
            if let systemImage = systemImage {
                Image(systemName: systemImage)
                    .font(fontSize)
            } else if let imageName = imageName {
                Image(imageName)
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
        .buttonStyle(ActionButtonAnimationStyle())
    }
    
    /// A circular button with a filled background.
    func filledIconStyle() -> some View {
        Button(action: action) {
            icon()
                .frame(width: frameSize, height: frameSize)
                .filledStyledBackground()
                .clipShape(Circle())
        }
        .buttonStyle(ActionButtonAnimationStyle())
    }
    
    /// A circular button with a tonal background.
    func tonalIconStyle() -> some View {
        Button(action: action) {
            icon()
                .frame(width: frameSize, height: frameSize)
                .tonalStyledBackground()
                .clipShape(Circle())
        }
        .buttonStyle(ActionButtonAnimationStyle())
    }
}
