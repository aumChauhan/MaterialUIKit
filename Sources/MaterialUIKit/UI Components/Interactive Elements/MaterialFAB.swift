//
// MaterialFloatingButton.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

extension View {
    
    /// Presents a Material UI style FAB to the view with a bottom trailing alignment.
    ///
    /// - Parameters:
    ///   - systemSymbol: The system symbol name for the button icon.
    ///   - title: The title text displayed on the button.
    ///   - action: A closure to be executed when the button is tapped.
    public func materialFAB(
        systemName: String,
        title: String,
        action: @escaping () -> Void
    ) -> some View {
        self.modifier(
            MaterialFABModifier(systemName: systemName, title: title, cornerRadius: nil, action: action)
        )
    }
    /// Presents a Material UI style FAB to the view with a bottom trailing alignment and a customizable corner radius.
    ///
    /// - Parameters:
    ///   - systemName: The system symbol name for the button icon.
    ///   - title: The title text displayed on the button.
    ///   - cornerRadius: The corner radius to apply to the button.
    ///   - action: A closure to be executed when the button is tapped.
    public func materialFAB(
        systemName: String,
        title: String,
        cornerRadius: CGFloat,
        action: @escaping () -> Void
    ) -> some View {
        self.modifier(
            MaterialFABModifier(systemName: systemName, title: title, cornerRadius: cornerRadius, action: action)
        )
    }
}

// MARK: - MaterialFABModifier

/// A view modifier that adds a floating button with specified system symbol and title aligned at the bottom of the screen.
fileprivate struct MaterialFABModifier: ViewModifier {
    let systemName: String
    let title: String
    let cornerRadius: CGFloat?
    let action: () -> Void
        
    func body(content: Content) -> some View {
        content.overlay(
            MaterialFAB(systemName: systemName, title: title, action, cornerRadius: cornerRadius)
                .align(.bottomTrailing)
                .padding(MaterialUIKit.configuration.contentPadding)
        )
    }
}

// MARK: - MaterialFAB

/// A Material UI style FAB.
fileprivate struct MaterialFAB: View {
    
    // MARK: - Properties
    
    let systemName: String
    let image: String?
    let title: String
    let cornerRadius: CGFloat?
    let action: () -> Void
    
    // MARK: - Initializers
    
    /// Creates a FAB with a system symbol, title, and an action.
    init(systemName: String, title: String, _ action: @escaping () -> Void, cornerRadius: CGFloat?) {
        self.systemName = systemName
        self.title = title
        self.action = action
        self.cornerRadius = cornerRadius
        self.image = nil
    }
    
    // MARK: - View Body
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: systemName)
                Text(title)
                    .font(MaterialUIKit.configuration.h4)
            }
            .fontWeightWithFallback(.medium)
            .filledStyledBackground()
            .cornerRadius(cornerRadius ?? MaterialUIKit.configuration.cornerRadius)
        }
        .buttonStyle(ShrinkFadeButtonStyle())
    }
}
