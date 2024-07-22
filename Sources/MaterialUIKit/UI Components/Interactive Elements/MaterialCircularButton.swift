//
// MaterialIconButton.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - MUIIconButton

/// A Material UI style circular icon button.
public struct MaterialCircularButton: View {
    
    // MARK: - Properties
    
    private let systemSymbol: String?
    private let image: String?
    private let style: MaterialCircularButtonStyle
    private let action: () -> ()
    
    @Environment(\.frameSize) private var frameSize: CGFloat
    @Environment(\.font) private var fontSize: Font
    
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
    
    /// A circular button with a elevated background.
    private func elevatedIconStyle() -> some View {
        Button(action: action) {
            icon()
                .frame(width: frameSize, height: frameSize)
                .elevatedStyledBackground()
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.15), radius: 1.5, x: 0, y: 1)
                .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
        }
        .buttonStyle(ShrinkFadeButtonStyle())
    }
    
    /// A circular button with a filled background.
    private func filledIconStyle() -> some View {
        Button(action: action) {
            icon()
                .frame(width: frameSize, height: frameSize)
                .filledStyledBackground()
                .clipShape(Circle())
        }
        .buttonStyle(ShrinkFadeButtonStyle())
    }
    
    /// A circular button with a tonal background.
    private func tonalIconStyle() -> some View {
        Button(action: action) {
            icon()
                .frame(width: frameSize, height: frameSize)
                .tonalStyledBackground()
                .clipShape(Circle())
        }
        .buttonStyle(ShrinkFadeButtonStyle())
    }
    
    /// A circular button with a secondary background.
    private func secondaryIconStyle() -> some View {
        Button(action: action) {
            icon()
                .foregroundStyle(.materialAccent)
                .frame(width: frameSize, height: frameSize)
                .margin()
                .background(.materialSecondaryBackground)
                .clipShape(Circle())
        }
        .buttonStyle(ShrinkFadeButtonStyle())
    }
}

// MARK: - Environment Keys

/// Environment key for setting the frame size.
fileprivate struct FrameSizeKey: EnvironmentKey {
    static var defaultValue: CGFloat = MaterialUIKit.configuration.verticalPadding
}

/// Environment key for setting the font weight.
fileprivate struct FontSizeKey: EnvironmentKey {
    static var defaultValue: Font = .subheadline
}

fileprivate extension EnvironmentValues {
    var frameSize: CGFloat {
        get { self[FrameSizeKey.self] }
        set { self[FrameSizeKey.self] = newValue }
    }
    
    var font: Font {
        get { self[FontSizeKey.self] }
        set { self[FontSizeKey.self] = newValue }
    }
}

// MARK: - Extension View

extension View {
    
    /// Sets the corner radius for Material Buttons within the environment.
    ///
    /// - Parameter radius: The corner radius value to apply.
    ///
    /// - Returns: A modified view environment with the specified corner radius applied.
    public func materialCircularButtonSize(_ frameSize: CGFloat) -> some View {
        self.environment(\.frameSize, frameSize)
    }
    
    /// Sets the font weight for Material Circular button within the environment.
    ///
    /// - Parameter fontWeight: The font weight to apply.
    ///
    /// - Returns: A modified view environment with the specified font weight applied.
    public func materialCircularButtonFontSize(_ fontSize: Font) -> some View {
        self.environment(\.font, fontSize)
    }
}
